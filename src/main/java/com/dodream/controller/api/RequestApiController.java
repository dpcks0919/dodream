package com.dodream.controller.api;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.FileUploadDto;
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
			requestService.sendEmailService(userEmailList[i], requestTitle);
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
		
		// PhoneList를 돌면서 phone number과 request Title 전송
		for(int i = 0; i < userPhoneList.length; i ++) {
			requestService.sendTextService(userPhoneList[i], requestTitle);
		}
		
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
	}
	
//	@PostMapping("/heart")
//	public ResponseDto<Integer> heartSave(@RequestBody UserInterest userInterest, @AuthenticationPrincipal PrincipalDetails principalDetails) {
//		requestService.saveHeart(userInterest, principalDetails);
//		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
//	}
	
	
//	@ResponseBody
//	@RequestMapping(value="/requestUpdateProc", method = RequestMethod.GET)
//	public ResponseDto<Integer> requestUpdate(@RequestBody Request request, HttpServletRequest httpServletRequest, @AuthenticationPrincipal PrincipalDetails principalDetails) {
//		
//		Request _request = requestService.getRequest(id);
//		
//		requestService.update(request);
//		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);		
//	}
	
	// 기존 request item update
	@PostMapping("/requestUpdateProc")
	public ResponseDto<Integer> requestUpdate(@RequestBody Request request) {
		System.out.println("요청 업데이트");
		requestService.updateRequest(request);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);		
	}
	
	// 기존 request update
	@PostMapping(value="/requestItemUpdateProc")
	public ResponseDto<Integer> requestItemUpdate(@RequestBody RequestItem requestItem) {
		System.out.println("기존 아이템 업데이트");
		requestService.updateItem(requestItem);
		return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);		
	}

	// 기존 request update : myrequest에서 사용
	@PostMapping(value="/requestItemSaveProc_myrequest")
	public ResponseDto<Integer> saveRequestItem_myrequest(@RequestBody RequestItem requestItem) {		
		// request id를 받아와서, requestItem.request에 입력해야하기때문에 임시로 ReceivedNum에 값을 입력받아와서
		// setRequest를 설정하고, ReceivedNum은 다시 0으로 초기화시켜주었다.
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
	
	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	public FileUploadDto uploadSummernoteImageFile(HttpServletRequest request, @RequestParam("file") MultipartFile multipartFile) {
		
		//JsonObject jsonObject = new JsonObject();
		FileUploadDto fileuploadDto = new FileUploadDto();
		
		//String root_path = request.getSession().getServletContext().getRealPath("/"); 
		//String fileRoot = "../resources/static/image/request/";	//저장될 외부 파일 경로
		String localRoot = uploadFilePath;
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
				
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		//File targetFile = new File(root_path + fileRoot + savedFileName);	
		File targetFile = new File( localRoot + savedFileName);
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장

			fileuploadDto.setUrl("/image/summernote/"+savedFileName);
			fileuploadDto.setResponseCode("success");
			//jsonObject.addProperty("url", "/image/request/"+savedFileName);
			//jsonObject.addProperty("responseCode", "success");		
		}catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			fileuploadDto.setResponseCode("error");
			//jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		
		return fileuploadDto;
	}
	


}
