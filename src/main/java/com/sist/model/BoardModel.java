package com.sist.model;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Controller
public class BoardModel {
	@RequestMapping("board/list.do")
	public String board_list(HttpServletRequest request,
			HttpServletResponse response)
	{
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		
		int curpage=Integer.parseInt(page);
		final int ROWSIZE=10;
		int start=(ROWSIZE*curpage)-ROWSIZE;
		List<BoardVO> list=BoardDAO.boardListData(start);
		int count=BoardDAO.boardTotalPage();
		int totalpage=(int)(Math.ceil(count/(double)ROWSIZE));
		count=count-((curpage*ROWSIZE)-ROWSIZE);
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		
		request.setAttribute("today", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		request.setAttribute("main_jsp", "../board/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("board/insert.do")
	public String board_insert(HttpServletRequest request,
			HttpServletResponse response)
	{
		HttpSession session = request.getSession();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    
	    
		request.setAttribute("main_jsp", "../board/insert.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("board/insert_ok.do")
	public String board_insert_ok(HttpServletRequest request,
			HttpServletResponse response)
	{
		
		// 세션에서 member_id 가져오기
	    HttpSession session = request.getSession();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    	   
	    
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String pwd=request.getParameter("pwd");	
		
		BoardVO vo=new BoardVO();
		vo.setMember_id(user.getMember_id());
		vo.setTitle(title);
		vo.setContent(content);
		vo.setPwd(pwd);
		
		BoardDAO.boardInsert(vo);
		return "redirect:../board/list.do";
	}
	@RequestMapping("board/detail.do")
	public String board_detail(HttpServletRequest request,
			HttpServletResponse response)
	{
		String no=request.getParameter("no");
		// 데이터베이스 연동
		BoardVO vo=BoardDAO.boardDetailData(Integer.parseInt(no));
		// 결과값(출력할 데이터)전송
		request.setAttribute("vo", vo);				
		request.setAttribute("main_jsp", "../board/detail.jsp");
		
		List<ReplyVO> list=ReplyDAO.replyListData(Integer.parseInt(no));
		request.setAttribute("rList", list);
		request.setAttribute("rcount", list.size());
		return "../main/main.jsp";
	}
	// 화면 변경이 없으면 void
	@RequestMapping("board/delete.do")
	public void board_delete(HttpServletRequest request,
			HttpServletResponse response)
	{
		System.out.println("===== delete 호출 =====");
		
		String no=request.getParameter("no");
		String pwd=request.getParameter("pwd");
		
		// DB연동 
		String res=BoardDAO.boardDelete(Integer.parseInt(no),pwd);
		try
		{
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(res);
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
	}
	@RequestMapping("board/update.do")
	public String board_update(HttpServletRequest request,
			HttpServletResponse response)
	{
		String no=request.getParameter("no");
		// 데이터베이스 연동
		BoardVO vo=BoardDAO.boardUpdateData(Integer.parseInt(no));
		// 결과값(출력할 데이터)전송
		request.setAttribute("vo", vo);				
		request.setAttribute("main_jsp", "../board/update.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("board/update_ok.do")
	public void board_update_ok(HttpServletRequest request,
			HttpServletResponse response)
	{
			String no=request.getParameter("no");			
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			String pwd=request.getParameter("pwd");
					
			BoardVO vo=new BoardVO();
			vo.setNo(Integer.parseInt(no));			
			vo.setTitle(title);
			vo.setContent(content);
			vo.setPwd(pwd);
						
			BoardDAO.boardUpdate(vo); 
		   // DB연동
		   String res=BoardDAO.boardUpdate(vo);
			try
			{
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.write(res);
			}catch(Exception ex)
			{
				ex.printStackTrace();
			}		
	}
}
