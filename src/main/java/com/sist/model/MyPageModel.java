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
		switch (vo.getGrade()) {
			case 1->vo.setSgrade("축린이");
			case 2->vo.setSgrade("아마추어");
			case 3->vo.setSgrade("프로");
			case 4->vo.setSgrade("월드클래스");
			case 5->vo.setSgrade("GOAT");
		}
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
