package com.sist.model;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sist.vo.*;
import com.sist.dao.*;
@Controller
public class QnaModel {
	@RequestMapping("qna/list.do")
	public String qna_list(HttpServletRequest request,
			HttpServletResponse response)
	{
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		
		int curpage=Integer.parseInt(page);
		final int ROWSIZE=10;
		int start=(ROWSIZE*curpage)-ROWSIZE;
		List<QnaVO> list=QnaDAO.qnaListData(start);
		int totalcount=QnaDAO.qnaTotalCount();
		int totalpage=(int)(Math.ceil(totalcount/(double)ROWSIZE));		
		int count= totalcount-((curpage*ROWSIZE)-ROWSIZE);
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		
		request.setAttribute("today", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		request.setAttribute("main_jsp", "../qna/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("qna/insert.do")
	public String qna_insert(HttpServletRequest request,
			HttpServletResponse response)
	{
		HttpSession session = request.getSession();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    
	    if(user == null) {
	        return "redirect:../member/login.do";
	    }
	    
		request.setAttribute("main_jsp", "../qna/insert.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("qna/insert_ok.do")
	public String qna_insert_ok(HttpServletRequest request,
			HttpServletResponse response)
	{
		
		// 세션에서 member_id 가져오기
	    HttpSession session = request.getSession();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    	   
	    
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String pwd=request.getParameter("pwd");	
		
		QnaVO vo=new QnaVO();
		vo.setLogin_id(user.getLogin_id());
		vo.setTitle(title);
		vo.setContent(content);
		vo.setPwd(pwd);
		
		QnaDAO.qnaInsert(vo);
		return "redirect:../qna/list.do";
	}
	@RequestMapping("qna/detail.do")
	public String qna_detail(HttpServletRequest request,
			HttpServletResponse response)
	{
		String no=request.getParameter("no");
		// 데이터베이스 연동
		QnaVO vo=QnaDAO.qnaDetailData(Integer.parseInt(no));
		QnaVO reply = QnaDAO.qnaReplyData(vo.getGroup_id());
		System.out.println("group_id: " + vo.getGroup_id());
		System.out.println("reply: " + reply);
		request.setAttribute("reply", reply);
		// 결과값(출력할 데이터)전송
		request.setAttribute("vo", vo);				
		request.setAttribute("main_jsp", "../qna/detail.jsp");

		return "../main/main.jsp";
	}
	// 화면 변경이 없으면 void
	@RequestMapping("qna/delete.do")
	public void qna_delete(HttpServletRequest request,
			HttpServletResponse response)
	{
		System.out.println("===== delete 호출 =====");
		
		String no=request.getParameter("no");
		String pwd=request.getParameter("pwd");
		
		// DB연동 
		String res=QnaDAO.qnaDelete(Integer.parseInt(no),pwd);
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
	@RequestMapping("qna/update.do")
	public String qna_update(HttpServletRequest request,
			HttpServletResponse response)
	{
		String no=request.getParameter("no");
		// 데이터베이스 연동
		QnaVO vo=QnaDAO.qnaUpdateData(Integer.parseInt(no));
		// 결과값(출력할 데이터)전송
		request.setAttribute("vo", vo);				
		request.setAttribute("main_jsp", "../qna/update.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("qna/update_ok.do")
	public void qna_update_ok(HttpServletRequest request,
			HttpServletResponse response)
	{
			String no=request.getParameter("no");			
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			String pwd=request.getParameter("pwd");
					
			QnaVO vo=new QnaVO();
			vo.setNo(Integer.parseInt(no));			
			vo.setTitle(title);
			vo.setContent(content);
			vo.setPwd(pwd);
								
		   // DB연동
		   String res=QnaDAO.qnaUpdate(vo);
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
	@RequestMapping("adminpage/qna_list.do")
	public String admin_qna_list(HttpServletRequest request,
			HttpServletResponse response)
	{
		String page = request.getParameter("page");
	    if(page == null) page = "1";

	    int curpage = Integer.parseInt(page);
	    final int ROWSIZE = 10;
	    int start = (ROWSIZE * curpage) - ROWSIZE;

	    List<QnaVO> list = QnaDAO.qnaListData(start);
	    int totalCount = QnaDAO.qnaTotalCount();
	    int totalpage = (int)(Math.ceil(totalCount/(double)ROWSIZE));
	    int count = totalCount - ((curpage*ROWSIZE)-ROWSIZE);

	    request.setAttribute("list", list);
	    request.setAttribute("curpage", curpage);
	    request.setAttribute("totalpage", totalpage);
	    request.setAttribute("count", count);
	    request.setAttribute("admin_jsp", "../qna/admin_list.jsp");
	    return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("adminpage/qna_detail.do")
	public String admin_qna_detail(HttpServletRequest request,
			HttpServletResponse response)
	{
		String no=request.getParameter("no");
		QnaVO vo=QnaDAO.qnaDetailData(Integer.parseInt(no));
		request.setAttribute("vo", vo);
		request.setAttribute("admin_jsp", "../qna/admin_detail.jsp");
	    return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("adminpage/qna_reply_ok.do")
	public String admin_qna_reply_ok(HttpServletRequest request,
	        HttpServletResponse response)
	{
		String no= request.getParameter("no");
		String group_id=request.getParameter("group_id");
		String content= request.getParameter("content");
		
		QnaVO vo=new QnaVO();
		vo.setGroup_id(Integer.parseInt(no));
		vo.setTitle("답변드립니다.");
		vo.setContent(content);
		
		QnaDAO.qnaReply(vo);
		QnaDAO.qnaStateUpdate(Integer.parseInt(no));
		
		return "redirect:../adminpage/qna_list.do";
	}
}
