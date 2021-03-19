package com.dodream.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.model.Request;
import com.dodream.service.RequestService;

@Controller
public class RequestController {
	
	@Autowired
	private RequestService requestService;
	
	//	요청 페이지 지도
	@GetMapping("requestMap")
	public String requestMap(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		if(principalDetails != null)
			model.addAttribute("user", principalDetails.getUser());
		return "request/request_map";
	}
	
	//	요청 페이지 목록
	@GetMapping("requestList")
	public String requestList(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		//model.addAttribute("requests", requestService.readRequestList(pageable));
		if(principalDetails != null)
			model.addAttribute("user", principalDetails.getUser());
		return "request/request_list";
	}
	
	//	요청 목록 불러오기
	@GetMapping("requestTable")
	public String requestTable(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readRequestList(pageable));
		if(principalDetails != null)
			model.addAttribute("user", principalDetails.getUser());
		return "request/request_table";
	}
	
	//	찜한 목록 불러오기
	@GetMapping("user/interestedRequestTable")
	public String interestedRequestTable(Model model, @PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		model.addAttribute("requests", requestService.readInterestedRequestList(principalDetails.getUser().getId(), pageable));
		model.addAttribute("user", principalDetails.getUser());
		return "request/request_table";
	}
	
	//	검색된 요청 목록 불러오기
	@GetMapping("searchRequestTable")
	public String searchRequestTable(Model model, 
									@RequestParam("clientType") String clientType,
									@RequestParam("urgentLevel") int urgentLevel,
									@RequestParam("searchItem") String searchItem,
									@RequestParam("searchText") String searchText,
									@PageableDefault(size=5, sort="id", direction = Sort.Direction.DESC) Pageable pageable, 
									@AuthenticationPrincipal PrincipalDetails principalDetails) {
		

		Page<Request> searchList = null;
						
		if( clientType.compareTo("all") == 0) {
			if(urgentLevel == 0) {
				if(searchItem.compareTo("id") == 0) {
					// 등록번호로만 검색
					searchList = requestService.searchRequestById(searchText, pageable);
				}else if(searchItem.compareTo("title") == 0){
					// 제목으로만 검색
					searchList = requestService.searchRequestByTitle(searchText, pageable);
				}else if(searchItem.compareTo("address") == 0) {
					// 위치로만 검색
					searchList = requestService.searchRequestByAddress(searchText, pageable);
				}else {
					searchList = requestService.readRequestList(pageable);
				}
			}else {
				if(searchItem.compareTo("id") == 0) {
					// 기간과 등록번호로 검색
					searchList = requestService.searchRequestByUrgentLevelAndId(urgentLevel, searchText, pageable);
				}else if(searchItem.compareTo("title") == 0){
					// 기간과 제목으로 검색
					searchList = requestService.searchRequestByUrgentLevelAndTitle(urgentLevel, searchText, pageable);
				}else if(searchItem.compareTo("address") == 0) {
					// 기간과 위치로 검색
					searchList = requestService.searchRequestByUrgentLevelAndAddress(urgentLevel, searchText, pageable);
				}else {
					// 기간으로만 검색
					searchList = requestService.searchRequestByUrgentLevel(urgentLevel, pageable);
				}
			}
		}else {
			if(urgentLevel == 0) {
				if(searchItem.compareTo("id") == 0) {
					// 도움받는 대상과 등록번호로 검색
					searchList = requestService.searchRequestByClientTypeAndId(clientType, searchText, pageable);
				}else if(searchItem.compareTo("title") == 0){
					// 도움받는 대상과 제목으로 검색
					searchList = requestService.searchRequestByClientTypeAndTitle(clientType, searchText, pageable);					
				}else if(searchItem.compareTo("address") == 0) {
					// 도움받는 대상과 위치로 검색
					searchList = requestService.searchRequestByClientTypeAndAddress(clientType, searchText, pageable);					
				}else {
					// 도움받는 대상으로만 검색
					searchList = requestService.searchRequestByClientType(clientType, pageable);
				}
			}else {
				if(searchItem.compareTo("id") == 0) {
					// 도움받는 대상과 기간과 등록번호로 검색
					searchList = requestService.searchRequestByClientTypeAndUrgentLevelAndId(clientType, urgentLevel, searchText, pageable);
				}else if(searchItem.compareTo("title") == 0){
					// 도움받는 대상과 기간과 제목으로 검색
					searchList = requestService.searchRequestByClientTypeAndUrgentLevelAndTitle(clientType, urgentLevel, searchText, pageable);
				}else if(searchItem.compareTo("address") == 0) {
					// 도움받는 대상과 기간과 위치로 검색
					searchList = requestService.searchRequestByClientTypeAndUrgentLevelAndAddress(clientType, urgentLevel, searchText, pageable);
				}else {
					// 도움받는 대상과 기간으로만 검색
					searchList = requestService.searchRequestByClientTypeAndUrgentLevel(clientType, urgentLevel, pageable);
				}
			}
		}

		model.addAttribute("requests", searchList);
		if(principalDetails != null)
			model.addAttribute("user", principalDetails.getUser());
		return "request/request_table";
	}
	
	//	요청하기 페이지 
	@GetMapping("social/request")
	public String requestForm() {
		return "request/request";
	}
	
	@RequestMapping(value="/jusoPopup_request")
	public String jusoPopup() {
		return "join/jusoPopup";
	}

}
