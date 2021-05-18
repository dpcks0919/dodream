package com.dodream.controller.api;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.FileUploadDto;
import com.dodream.dto.RequestDto;
import com.dodream.dto.ResponseDto;
import com.dodream.model.Request;
import com.dodream.model.RequestItem;
import com.dodream.model.User;
import com.dodream.service.RequestService;

@RestController
public class RequestApiController {
	@Autowired
	private RequestService requestService;

	@Value("${summernote.upload}")
	private String uploadFilePath;
	
	@PostMapping("/getValidUserListProc")
	public ResponseDto<User[]> getValidList() {
		// Valid User 리턴
		User[] validUserList = requestService.getValidUserListService();		
		return new ResponseDto<User[]> (HttpStatus.OK.value(),validUserList);
	}
	
	@PostMapping("/notifyByEmailProc")
	@ResponseBody
	public ResponseDto<Integer> notifyByEmail(@RequestParam(value = "stringUserList") String[] stringUserList, @RequestParam(value = "stringRequest") String[] stringRequest) throws UnsupportedEncodingException, MessagingException {
		// userEmail 추출
		String[] userEmailList = new String[stringUserList.length/24];
		for(int i = 0; i < userEmailList.length; i++) {
			String email = stringUserList[i * 24 + 7].substring(13, stringUserList[i * 24 + 7].length()-1);
			userEmailList[i] = email;
		}
		
		// request Title 추출
		String requestTitle = stringRequest[0].substring(10, stringRequest[0].length()-1);
		
		// EmailList를 돌면서 email과 request Title 전송
		for(int i = 0; i < userEmailList.length;i ++) {
			requestService.sendRequestEmailService(userEmailList[i], requestTitle);
		}
		
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
	
	@PostMapping("/notifyByTextProc")
	public ResponseDto<Integer> notifyByText(@RequestParam(value = "stringUserList") String[] stringUserList, @RequestParam(value = "stringRequest") String[] stringRequest) {
		// userPhone 추출
		String[] userPhoneList = new String[stringUserList.length/24];  
		for(int i = 0; i < userPhoneList.length; i++) { 
			String userPhone = stringUserList[i * 24 + 6].substring(13, stringUserList[i * 24 + 6].length()-1);
			userPhoneList[i] = userPhone;
		}
		
		// request Title 추출
		String requestTitle = stringRequest[0].substring(10, stringRequest[0].length()-1);
		
		// 중복 번호 제거(다른 계정 같은 전번일 시)
		userPhoneList = new HashSet<String>(Arrays.asList(userPhoneList)).toArray(new String[0]);
		
		// PhoneList를 돌면서 phone number과 request Title 전송
		for(int i = 0; i < userPhoneList.length; i ++) {
			requestService.sendTextService(userPhoneList[i], requestTitle);
		}
		
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
	
	// 기존 request update
	@PostMapping("/requestUpdateProc")
	public ResponseDto<Integer> requestUpdate(@RequestBody Request request) {
		requestService.updateRequest(request);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);		
	}
	
	// 기존 request update
	@PostMapping(value="/requestItemUpdateProc")
	public ResponseDto<Integer> requestItemUpdate(@RequestBody RequestItem requestItem) {
		requestService.updateItem(requestItem);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);		
	}
	
	@GetMapping("user/deleteRequest")
	public ResponseDto<Integer> deleteRequest(Model model, @RequestParam("id") String id, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		Request request = requestService.getRequest(Integer.parseInt(id));
		requestService.requestDelete(request);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);		
	}

	// 기존 request update : myrequest에서 사용
	@PostMapping(value="/requestItemSaveProc_myrequest")
	public ResponseDto<Integer> saveRequestItem_myrequest(@RequestBody RequestItem requestItem) {		
		requestItem.setRequest(requestService.getRequest(requestItem.getReceivedNum()));
		requestItem.setReceivedNum(0);
		requestService.saveRequestItem(requestItem);
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
	
	// 새로운 요청 아이템 등록
	@PostMapping("/requestItemSaveProc")
	public ResponseDto<Integer> saveRequestItem(@RequestBody RequestItem requestItem) {
		requestService.saveRequestItem(requestItem);
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
	
	// 새로운 요청 등록
	@PostMapping("/requestSaveProc")
	public ResponseDto<Request> requestSave(@RequestBody Request request, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		Request newRequest = requestService.saveRequest(request, principalDetails);
		
		if( principalDetails == null  )
			return new ResponseDto<Request> ( HttpStatus.INTERNAL_SERVER_ERROR.value() , null);
		
		return new ResponseDto<Request> (HttpStatus.OK.value(), newRequest);
	}
	
	
	//new
	@PostMapping("/requestItemAddProc")
	public ResponseDto<Integer> addRequestItem(@RequestParam(value = "id") int id, @RequestParam(value = "addNum") int addNum) {
		RequestItem requestItem = requestService.getRequestItem(id);
		int returnValue = requestService.addRequestItem(requestItem, addNum);
		if(returnValue == 1) {
			return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
		} else {
			return null;
		}
	}
	
	
	@GetMapping("manager/ManagerViewRequest")
	public RequestDto ManagerViewRequest(Model model, @RequestParam("id") String id, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		Request request = requestService.getRequest(Integer.parseInt(id));
		return new RequestDto (request);
	}
	
	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	public FileUploadDto uploadSummernoteImageFile(HttpServletRequest request, @RequestParam("file") MultipartFile multipartFile) {
		
		FileUploadDto fileuploadDto = new FileUploadDto();
		
		String localRoot = uploadFilePath;
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
				
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File( localRoot + savedFileName);
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장

			fileuploadDto.setUrl("/image/summernote/"+savedFileName);
			fileuploadDto.setResponseCode("success");
	
		}catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			fileuploadDto.setResponseCode("error");
			e.printStackTrace();
		}
		
		return fileuploadDto;
	}
}
