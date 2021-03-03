package com.dodream.controller.api;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.dto.FileUploadDto;
import com.dodream.dto.ResponseDto;
import com.dodream.model.Request;
import com.dodream.model.RequestItem;
import com.dodream.service.RequestService;

@RestController
public class RequestApiController {
	@Autowired
	private RequestService requestService;
	
	@Value("${summernote.upload}")
	private String uploadFilePath;
	
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
		requestService.addRequestItem(requestItem, addNum);
		return new ResponseDto<Integer> (HttpStatus.OK.value(), 1);
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
