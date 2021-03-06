package com.way.learning.controller.board.tech;


import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.way.learning.model.board.tech.vo.TechReply;
import com.way.learning.model.member.vo.Member;
import com.way.learning.service.board.tech.TechReplyService;


@Controller
@RequestMapping("/reply/tech/*")
public class TechReplyController {

	@Autowired
	TechReplyService techReplyService;
	
	
	
	
	@RequestMapping("insert")
	public void insert(TechReply rvo, HttpServletRequest request, HttpServletResponse response, HttpSession session
							) throws Exception{
		System.out.println("reply insert 컨트롤러 입성");
		Member mvo=(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		//로그인 한 상태라면
		rvo.setMember(mvo); //bvo와 mvo의 Hasing 관계가 성립된다..
		techReplyService.insertReply(rvo);
	}
	
	
	
	
	@RequestMapping("list")
	public ModelAndView list(String boardNo, ModelAndView mav, HttpSession session) {
		System.out.println("reply list 컨트롤러 입성");
		System.out.println("넘어온 boardNo:"+boardNo);
		List<TechReply> list = techReplyService.listReply(boardNo, session);
		mav.setViewName("board/tech/reply_list");
		System.out.println("컨트롤러 list:"+list);
		mav.addObject("list", list);
		
		
		
		return mav;
		
		
	}
	
	@ResponseBody
	@RequestMapping("changeLike")
	public int changeLike(int replyNo, String likeStatus)throws Exception{
		
		Member mvo=(Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		
		
		techReplyService.isReplyLike(mvo.getUserId(), replyNo,likeStatus);
		int cnt=techReplyService.selectCntReplyLike(replyNo);
		return cnt;
	}
	
	
	
	
	@ResponseBody
	@RequestMapping(value="update", produces="application/json; charset=UTF8")
	public  Map<String, Object>  update(String replyNo,String replytext, HttpServletResponse response) throws IOException {
		
		response.setCharacterEncoding("utf-8");
		
		System.out.println("replyNo:"+replyNo);
		System.out.println("replytext:"+replytext);
		System.out.println("업뎃 컨트롤러 입성!");
		techReplyService.updateReply(replyNo, replytext);
		String replyText=techReplyService.selectUpdatedReply(replyNo);
	
		HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("replyText", replyText);
			System.out.println("리플업뎃 컨트롤러:"+replyText);
		return map;	
	}
	
	@ResponseBody
	@RequestMapping("delete")
	public void delete(String replyNo, String boardNo, ModelAndView mav) {
		System.out.println("삭제 컨트롤러!");
		
		System.out.println("boardNo:"+boardNo);
		techReplyService.deleteReply(replyNo);
		
		 
		
	}
	
	
	
	
	
}
































