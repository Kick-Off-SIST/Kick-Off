package com.sist.model;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

import java.io.PrintWriter;
import java.util.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageModel {
	@RequestMapping("mypage/mypage.do")
	public String mypage_mypage(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		int member_id=(int)session.getAttribute("member_id");
		MemberVO vo=MyPageDAO.mypageInfoData(member_id);
		switch (vo.getGrade()) {
			case 1->vo.setSgrade("축린이");
			case 2->vo.setSgrade("아마추어");
			case 3->vo.setSgrade("프로");
			case 4->vo.setSgrade("월드클래스");
			case 5->vo.setSgrade("GOAT");
		}
		int rcount=MyPageDAO.mypageReserveCount(member_id);
		int bcount=MyPageDAO.mypageBoardCount(member_id);
		request.setAttribute("menu", 1);
		request.setAttribute("vo", vo);
		request.setAttribute("bcount", bcount);
		request.setAttribute("rcount", rcount);
		request.setAttribute("mypage_jsp", "../mypage/mypage_home.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/update.do")
	public void mypage_update(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		int member_id=(int)session.getAttribute("member_id");
		MemberVO vo=MyPageDAO.mypageUpdateListData(member_id);
		
		try {
			ObjectMapper mapper=new ObjectMapper();
			String json=mapper.writeValueAsString(vo);
			
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.print(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("mypage/update_ok.do")
	public void mypage_update_vue(HttpServletRequest request, HttpServletResponse response) {
		String pwd=request.getParameter("pwd");
		String name=request.getParameter("name");
		String sex=request.getParameter("sex");
		String email=request.getParameter("email");
		String addr1=request.getParameter("addr1");
		String content=request.getParameter("content");
		String phone=request.getParameter("phone");
		String addr2=request.getParameter("addr2");
		String birthday=request.getParameter("birthday");
		String post=request.getParameter("post");
		
		HttpSession session=request.getSession();
		int member_id=(int)session.getAttribute("member_id");
		
		MemberVO vo=new MemberVO();
		vo.setMember_id(member_id);
		vo.setPwd(pwd);
		vo.setName(name);
		vo.setSex(sex);
		vo.setEmail(email);
		vo.setAddr1(addr1);
		vo.setContent(content);
		vo.setPhone(phone);
		vo.setAddr2(addr2);
		vo.setBirthday(birthday);
		vo.setPost(post);
		
		MyPageDAO.mypageUpdate(vo);
	}

	
	@RequestMapping("mypage/mypage_reserve.do")
	public String mypage_reserve(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		int member_id=(int)session.getAttribute("member_id");

		List<ReserveDetailVO> list=MyPageDAO.mypageReserveListData(member_id);
		request.setAttribute("menu", 4);
		request.setAttribute("list", list);
		
		request.setAttribute("mypage_jsp", "../mypage/mypage_reserve.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/reserve_delete.do")
	public void reserve_delete(HttpServletRequest request, HttpServletResponse response) {
		String match_seat_id=request.getParameter("match_seat_id");
		String reserve_id=request.getParameter("reserve_id");
		Map map=new HashMap();
		map.put("match_seat_id", match_seat_id);
		map.put("reserve_id", reserve_id);
		ReserveDAO.reserveDelete(map);
	}
	
	@RequestMapping("mypage/mypage_cart.do")
	public String mypage_cart(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		int member_id=(int)session.getAttribute("member_id");
		List<CartVO> list=MyPageDAO.cartGoodsDetailData(member_id);
		request.setAttribute("menu", 3);
		request.setAttribute("list", list);
		
		request.setAttribute("mypage_jsp", "../mypage/mypage_cart.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
}
