package com.sist.model;

import java.io.PrintWriter;

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
	public String member_join_ok(HttpServletRequest request,HttpServletResponse response) {
		String login_id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		String name=request.getParameter("name");
		String sex=request.getParameter("sex");
		String birthday=request.getParameter("birthday");
		String email=request.getParameter("email");
		String post=request.getParameter("post");
		String addr1=request.getParameter("addr1");
		String addr2=request.getParameter("addr2");
		String phone=request.getParameter("phone1")+"-"+request.getParameter("phone2");
		String content=request.getParameter("content");
		MemberVO vo=new MemberVO();
		vo.setLogin_id(login_id);
		vo.setPwd(pwd);
		vo.setName(name);
		vo.setSex(sex);
		vo.setBirthday(birthday);
		vo.setEmail(email);
		vo.setPost(post);
		vo.setAddr1(addr1);
		vo.setAddr2(addr2);
		vo.setPhone(phone);
		vo.setContent(content);
		service.memberInsert(vo);
		return "redirect:../main/main.do";
	}
	@RequestMapping("member/idCheck.do")
	public void member_idCheck(HttpServletRequest request,HttpServletResponse response) {
		String id=request.getParameter("id");
		int count=service.memberIdCount(id);
		String msg="";
		if(count==0) {
			msg="OK";
		}
		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(msg);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}
