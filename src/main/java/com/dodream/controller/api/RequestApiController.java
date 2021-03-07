package com.dodream.controller.api;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
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
import com.dodream.model.UserInterest;
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
//	
	
	@PostMapping("/requestSaveProc")
	public ResponseDto<Request> requestSave(@RequestBody Request request, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		Request newRequest = requestService.saveRequest(request, principalDetails);
		System.out.println(newRequest.getId());
		return new ResponseDto<Request> (HttpStatus.OK.value(), newRequest);
	}
	
	@PostMapping("/requestItemSaveProc")
	public ResponseDto<Integer> saveRequestItem(@RequestBody RequestItem requestItem) {
		System.out.println(requestItem);
		requestService.saveRequestItem(requestItem);
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
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
