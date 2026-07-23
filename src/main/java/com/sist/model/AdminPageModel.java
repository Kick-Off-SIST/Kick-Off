package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.sist.dao.*;
import com.sist.vo.*;
import java.io.*;
import java.text.DecimalFormat;
import java.util.*;
@Controller
public class AdminPageModel {
	@RequestMapping("adminpage/admin_main.do")
	public String admin_main(HttpServletRequest request,
			   HttpServletResponse response)
	{
		List<MemberVO> rList=AdminDAO.adminRecentMemberList();
		int mTotal=AdminDAO.adminMemberCount();
		int rTotal=AdminDAO.adminReservationCount();
		request.setAttribute("mTotal", mTotal);
		request.setAttribute("rList", rList);
		request.setAttribute("rTotal", rTotal);
		request.setAttribute("activeMenu", "1");
		request.setAttribute("admin_jsp", "../adminpage/admin_home.jsp");
		return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("adminpage/member_list.do")
	public String admin_member(HttpServletRequest request,
			   HttpServletResponse response)
	{
		String page=request.getParameter("page");
		if(page==null)
			   page="1";
		   // 요청처리 
		int curpage=Integer.parseInt(page);
		final int ROWSIZE=10;
		int start=(ROWSIZE*curpage)-ROWSIZE;
		List<MemberVO> list=AdminDAO.AdmemberListData(start);
		int totalpage=AdminDAO.AdmemberTotalPage();
		   
		// 30 => 
		// 요청 결과값을 JSP로 전송 
		request.setAttribute("mList", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("activeMenu", "2");
		request.setAttribute("admin_jsp", "../adminpage/member_list.jsp");
		return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("adminpage/admin_reserve.do")
	public String admin_reserve(HttpServletRequest request,
			   HttpServletResponse response)
	{
		String page=request.getParameter("page");

		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);

		final int ROWSIZE=10;
		int start=(ROWSIZE*curpage)-ROWSIZE;
		List<ReserveDetailVO> list =
				AdminDAO.adminReserveListData(start);
		int totalpage =
				AdminDAO.adminReservationTotalPage();
		request.setAttribute("rList", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);

		request.setAttribute("activeMenu", "3");
		request.setAttribute("admin_jsp", "../adminpage/admin_reserve.jsp");

		return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("adminpage/member_update.do")
	  public void member_update(HttpServletRequest request,
			   HttpServletResponse response)
	  {
		String Login_id=request.getParameter("login_id");
		String type=request.getParameter("type");
		
		MemberVO vo=new MemberVO();
		vo.setLogin_id(Login_id);
		vo.setGrade(Integer.parseInt(type));
		
		int count=AdminDAO.memberGradeChange(vo);
		
		try
		{
			response.setContentType("text/html;charset=UTF-8");
			  PrintWriter out=response.getWriter();
			  out.write(String.valueOf(count));
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	  }
	@RequestMapping("adminpage/reserve_cancel.do")
	public void reserve_cancel(HttpServletRequest request,
			HttpServletResponse response)
	{
		int reserve_id=Integer.parseInt(request.getParameter("reserve_id"));
		int match_seat_id=Integer.parseInt(request.getParameter("match_seat_id"));

		AdminDAO.adminReserveCancel(reserve_id, match_seat_id);

		try
		{
			response.sendRedirect("../adminpage/admin_reserve.do");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
}
