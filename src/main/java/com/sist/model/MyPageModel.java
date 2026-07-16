package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
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
		int rcount=MyPageDAO.mypageReserveCount(member_id);
		request.setAttribute("menu", 1);
		request.setAttribute("vo", vo);
		request.setAttribute("rcount", rcount);
		request.setAttribute("mypage_jsp", "../mypage/mypage_home.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("mypage/mypage_reserve.do")
	public String mypage_reserve(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		int member_id=(int)session.getAttribute("member_id");
		List<ReserveDetailVO> list=ReserveDAO.reservemyPageListDetailData(member_id);
		//System.out.println(list);
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
		System.out.println("리절트맵"+map);
		ReserveDAO.reserveDelete(map);
	}
}
