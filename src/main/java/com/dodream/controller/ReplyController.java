package com.dodream.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dodream.config.auth.PrincipalDetails;
import com.dodream.service.ReplyService;
import com.dodream.service.RequestService;

@Controller
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private RequestService requestService;
	
	//	myreuqest에서 request의 reply들의 List를 가져옴.
	//@GetMapping("user/replyTable")
	@RequestMapping(value="/user/replyTable", method = RequestMethod.GET)
	public String replyTable(Model model, HttpServletRequest httpServletRequest, @AuthenticationPrincipal PrincipalDetails principalDetails) {
		String id = httpServletRequest.getParameter("id");
		model.addAttribute("replyList", replyService.readReplyList(requestService.getRequest(Integer.parseInt(id))));
		model.addAttribute("user", principalDetails.getUser());
		return "my/reply_table";
	}

}
