package com.dodream.config.oauth;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.config.oauth.provider.FacebookUserInfo;
import com.dodream.config.oauth.provider.GoogleUserInfo;
import com.dodream.config.oauth.provider.KakaoUserInfo;
import com.dodream.config.oauth.provider.NaverUserInfo;
import com.dodream.config.oauth.provider.OAuth2UserInfo;
import com.dodream.model.User;
import com.dodream.repository.UserRepository;
import com.dodream.service.UserService;

//해당 함수가 종료될 때, @AuthenticationPrincipal 어노테이션이 만들어진다.
@Service
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserRepository userRepository;
	
	@Value("${social.password}")
	private String socialPassword;

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

		OAuth2User oauth2User = super.loadUser(userRequest);
		//System.out.println(oauth2User.getAttributes()); // 계정에 대한 정보!
		
		OAuth2UserInfo oAuth2UserInfo = null;
		if(userRequest.getClientRegistration().getRegistrationId().equals("google")) {
			System.out.println("구글 로그인 요청");
			oAuth2UserInfo = new GoogleUserInfo(oauth2User.getAttributes());
		}else if(userRequest.getClientRegistration().getRegistrationId().equals("facebook")) {
			System.out.println("페이스북 로그인 요청");
			oAuth2UserInfo = new FacebookUserInfo(oauth2User.getAttributes());
		}else if(userRequest.getClientRegistration().getRegistrationId().equals("naver")) {
			System.out.println("네이버 로그인 요청");							// yml에서 response라고 설정했기 때문에 response내용만 받아옴.
			oAuth2UserInfo = new NaverUserInfo((Map<String, Object>)oauth2User.getAttributes().get("response")); // 네이버는 response안에 response로 또 감싸여져 있기 때문에.
		}else if(userRequest.getClientRegistration().getRegistrationId().equals("kakao")) {
			System.out.println("카카오 로그인 요청");
			
			Map<String, Object> kakaoOauth = new HashMap<String, Object>();
			
			Map<String,Object> response = (Map<String, Object>)oauth2User.getAttributes().get("kakao_account");
			Map<String, Object> profile = (Map<String, Object>) response.get("profile");
			
			kakaoOauth.put("id", oauth2User.getAttributes().get("id"));
			kakaoOauth.put("email", response.get("email"));
			kakaoOauth.put("name", profile.get("nickname"));

			oAuth2UserInfo = new KakaoUserInfo(kakaoOauth); 
		} 																						 
		
		String userName = oAuth2UserInfo.getName();
		String provider = oAuth2UserInfo.getProvider();
		String providerId = oAuth2UserInfo.getProviderId();
		String loginId = provider + "_" + providerId;
		String password = bCryptPasswordEncoder.encode(socialPassword);
		//String userEmail = oAuth2UserInfo.getEmail(); //카카오의 경우 선택사항
		
		User userEntity = userRepository.findByLoginId(loginId);
		
		if(userEntity == null) {
			userEntity = User.builder()
					.loginId(loginId)
					.loginPassword(password)
					.userName(userName)
					//.userEmail(userEmail)
					.isSocial(1)
					.build();
		}else {
			userService.increaseLoginCount(userEntity.getId());
		}
				
		return new PrincipalDetails(userEntity, oauth2User.getAttributes()); //이제 얘가 authentication세션 안에 들어감!
	}
}
