package com.sist.model;

import java.util.HashMap;
import java.util.Map;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Controller
public class ReplyModel {
	@RequestMapping("reply/insert.do")
	public String reply_insert(HttpServletRequest request,
			   HttpServletResponse response)
	{
		   String bno=request.getParameter("bno");
		   String msg=request.getParameter("msg");

		   HttpSession session=request.getSession();
		   // 로그인 시 세션엔 "user"라는 이름으로 MemberVO 통째로 저장되어 있음
		   MemberVO user=(MemberVO)session.getAttribute("user");

		   if(user==null){
			   // 비로그인 상태에서 댓글 등록 시도 -> 그냥 상세페이지로 돌려보냄
			   return "redirect:../board/detail.do?no="+bno;
		   }

		   ReplyVO vo=new ReplyVO();
		   vo.setBno(Integer.parseInt(bno));
		   vo.setMsg(msg);
		   vo.setId(user.getLogin_id());   // ReplyVO.id는 String -> login_id 사용 (member_id는 int라 타입 안 맞음)
		   vo.setName(user.getName());

		   ReplyDAO.replyInsert(vo);
		   return "redirect:../board/detail.do?no="+bno;
	 }
	@RequestMapping("reply/update.do")
	public String reply_update(HttpServletRequest request,
			   HttpServletResponse response)
	{
		   String bno=request.getParameter("bno");
		   String no=request.getParameter("no");
		   String msg=request.getParameter("msg");
		   
		   Map map=new HashMap();
		   map.put("no", no);
		   map.put("msg", msg);
		   ReplyDAO.replyUpdate(map);
		   return "redirect:../board/detail.do?no="+bno;
	}
	@RequestMapping("reply/delete.do")
	   public String reply_delete(HttpServletRequest request,
			   HttpServletResponse response)
	   {
		   String bno=request.getParameter("bno");
		   String no=request.getParameter("no");
		   ReplyDAO.replyDelete(Integer.parseInt(no));
		   
		   
		   return "redirect:../board/detail.do?no="+bno;
	   }
}
