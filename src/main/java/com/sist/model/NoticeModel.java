package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@Controller
public class NoticeModel {
	@RequestMapping("adminpage/insert.do")
	public String admin_insert(HttpServletRequest request,
			   HttpServletResponse response)
	{
		request.setAttribute("admin_jsp", "../notice/insert.jsp");
		return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("adminpage/admin_list.do")
	public String admin_list(HttpServletRequest request,
			HttpServletResponse response)
	{
		// DB연동 => 
		   String page=request.getParameter("page");
		   if(page==null)
			   page="1";
		   // 요청처리 
		   int curpage=Integer.parseInt(page);
		   final int ROWSIZE=10;
		   int start=(ROWSIZE*curpage)-ROWSIZE;
		   List<NoticeVO> list=NoticeDAO.noticeListData(start);
		   int totalpage=NoticeDAO.noticeTotalPage();
		   
		   // 요청 결과값을 JSP로 전송 
		   request.setAttribute("nList", list);
		   request.setAttribute("curpage", curpage);
		   request.setAttribute("totalpage", totalpage);
		   request.setAttribute("today", 
				   new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		   request.setAttribute("admin_jsp", "../notice/admin_list.jsp");
		   return "../adminpage/admin_main.jsp";
	  }
	@RequestMapping("notice/insert_ok.do")
	public String admin_insert_ok(HttpServletRequest request,
			   HttpServletResponse response)
	{
		String type=request.getParameter("type");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		NoticeVO vo=new NoticeVO();
		vo.setType(Integer.parseInt(type));
		vo.setTitle(title);
		vo.setContent(content);
		
		int a=NoticeDAO.noticeInsert(vo);
		if(a==0)
		{
			
		}
		else
		{
			
		}
		return "redirect:../adminpage/admin_list.do";
	}
	@RequestMapping("notice/user_list.do")
	public String user_list(HttpServletRequest request,
			   HttpServletResponse response)
	{
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		final int ROWSIZE=10;
		int start=(ROWSIZE*curpage)-ROWSIZE;
		List<NoticeVO> list=NoticeDAO.noticeListData(start);
		int totalpage=NoticeDAO.noticeTotalPage();
		
		request.setAttribute("nlist", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("today", 
				new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		request.setAttribute("main_jsp", "../notice/user_list.jsp");
		return "../main/main.jsp";
    }
	@RequestMapping("notice/delete.do")
	   public String notice_delete(HttpServletRequest request,
			   HttpServletResponse response)
	   {
		String no=request.getParameter("no");
		NoticeDAO.noticeDelete(Integer.parseInt(no));
		return "redirect:../adminpage/admin_list.do";
	   }
	@RequestMapping("notice/update.do")
	public String notice_update(HttpServletRequest request,
			   HttpServletResponse response)
	{
		String no=request.getParameter("no");
		NoticeVO vo=NoticeDAO.noticeUpdateData(Integer.parseInt(no));		
		request.setAttribute("vo", vo);
		request.setAttribute("admin_jsp", "../notice/update.jsp");
		return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("notice/update_ok.do")
	public String notice_update_ok(HttpServletRequest request,
			   HttpServletResponse response)
	{
		String no=request.getParameter("no");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String type=request.getParameter("type");
		   
		//DAO전송
		NoticeVO vo=new NoticeVO();
		vo.setNo(Integer.parseInt(no));
		vo.setTitle(title);
		vo.setContent(content);
		vo.setType(Integer.parseInt(type));
		   
		NoticeDAO.noticeUpdate(vo);
		return "redirect:../adminpage/admin_list.do";
	}
	@RequestMapping("notice/detail.do")
	public String notice_detail(HttpServletRequest request,
			   HttpServletResponse response)
	{
		String no=request.getParameter("no");
		NoticeVO vo=NoticeDAO.noticeDetailData(Integer.parseInt(no));
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../notice/user_detail.jsp");
		return "../main/main.jsp";
	}
}
