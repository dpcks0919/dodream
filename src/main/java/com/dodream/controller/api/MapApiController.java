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
import com.dodream.model.User;
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
	
	private int interval = 30;

	
	@PostMapping("/requestListProc")
	public ResponseDto<Request[]> requestListProc() {  // (기관,단체,요청) 주소리스트 string 으로 리턴
		return new ResponseDto<Request[]>(HttpStatus.OK.value(), requestService.requestListProcService(interval));
	}
	
	@PostMapping("/groupListProc")
	public ResponseDto<User[]> groupListProc() {  // (기관,단체,요청) 주소리스트 string 으로 리턴
		return new ResponseDto<User[]>(HttpStatus.OK.value(), userService.getGroupUserSerive());
	}

	
	@PostMapping("/markProc")	// searchAndMark 요청 종류별로 마커 찍기
	public ResponseDto<Request[]> markProc(@RequestParam(value = "clientType") String clientType) {	
		System.out.println("MARKPROC HERE: " + requestService.markProcService(clientType)[0].getClientType());
		return new ResponseDto<Request[]>(HttpStatus.OK.value(), requestService.markProcService(clientType));
	}

}
