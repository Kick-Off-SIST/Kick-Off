package com.sist.model;

import com.sist.commons.Commons;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.service.*;
import com.sist.vo.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberModel {
	MemberService service=new MemberServiceImpl();
	@RequestMapping("member/login.do")
	public void member_login_vue(HttpServletRequest request,HttpServletResponse response) {
		String login_id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		
		MemberVO vo=service.isLogin(login_id, pwd);
		if("OK".equals(vo.getMsg())) {
			HttpSession session=request.getSession();
			session.setAttribute("user", vo);
		}
		try {
			Commons.sendData(response, "text/html", vo.getMsg());
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	@RequestMapping("member/logout.do")
	public void member_logout(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session=request.getSession();
		session.invalidate();
	}
	@RequestMapping("member/join.do")
	public String member_join(HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("main_jsp", "../member/join.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("member/join_ok.do")
	public void member_join_ok(HttpServletRequest request,HttpServletResponse response) {
		
	}
}
