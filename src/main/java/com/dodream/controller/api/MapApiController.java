package com.dodream.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dodream.dto.ResponseDto;
import com.dodream.model.Request;
import com.dodream.service.RequestService;
import com.dodream.service.UserService;

@RestController
public class MapApiController {
	@Autowired
	private UserService userService;
	@Autowired
	private RequestService requestService;
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Value("${social.password}")
	private String socialPassword;
	
	@PostMapping("/markProc")	// searchAndMark 요청 종류별로 마커 찍기
	public ResponseDto<Request[]> sendText(@RequestParam(value = "clientType") String clientType) {	// verifyCode(스트링) 리턴 
		//System.out.println("MARKPROC HERE: " + clientType);
		return new ResponseDto<Request[]>(HttpStatus.OK.value(), requestService.markProcService(clientType));
	}

}
