package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import java.io.PrintWriter;
import java.util.*;


import com.sist.vo.*;
import com.sist.dao.*;
import com.sist.service.TeamService;
import com.sist.service.TeamServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReserveModel {
	@RequestMapping("ticket/reserve_team.do")
	public String ticket_reserve_team(HttpServletRequest request, HttpServletResponse response) {
		List<TeamVO> list=ReserveDAO.reserveTeam("team_id");
		System.out.println(list);
		request.setAttribute("list", list);
		request.setAttribute("main_jsp", "../ticket/reserve_team.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("ticket/reserve_team_vue.do")
	public void ticket_reserve_team_vue(HttpServletRequest request, HttpServletResponse response) {
		
		
		try {
			response.setContentType("text/plain;charset=UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("ticket/reserve_list.do")
	public String ticket_reserve_list(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("id");
		// 해당 팀 이름, 엠블럼
		TeamVO vo=ReserveDAO.reserveTeamMainData(id);
		request.setAttribute("vo", vo);
		
		TeamVO rvo=ReserveDAO.reserveTeamTicketImage(id);
		String ticketImage= rvo.getSvo().getTicket_policy_image();
		String name=rvo.getSvo().getName();

		request.setAttribute("ticketImage", ticketImage);
		
		List<MatchVO> mList=ReserveDAO.reserveTeamScheduleData(id);

		request.setAttribute("mList", mList);
		
		
		request.setAttribute("main_jsp", "../ticket/reserve_list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("ticket/seat_count.do")
	public void seat_count(HttpServletRequest request, HttpServletResponse response) {
		// 스케쥴 id 받아서 stadium_id 알아오기
		String sid=request.getParameter("sid");
		int count=ReserveDAO.matchSeatCount(Integer.parseInt(sid));
		String msg="NO";
		if(count>0) msg="OK";
		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("ticket/reserve_ticket.do")
	public String ticket_reserve_ticket(HttpServletRequest request, HttpServletResponse response) {
		// 스케쥴 id 받아서 stadium_id 알아오기
		String sid=request.getParameter("sid");
		
		String msg="";
		HttpSession session=request.getSession();
		// 로그인 처리
		if(session.getAttribute("user")!=null) {
			MatchVO vo=ReserveDAO.scheduleDetailData(Integer.parseInt(sid));
			List<MatchSeatVO> list=ReserveDAO.seatGradeListData(vo.getSchedule_id());
			MatchVO match=ReserveDAO.matchInfo(Integer.parseInt(sid));
			request.setAttribute("sid", sid);
			request.setAttribute("list", list);
			request.setAttribute("match", match);
			request.setAttribute("main_jsp", "../ticket/reserve_ticket.jsp");
			msg="../main/main.jsp";
		}
		else {
			msg="redirect:../main/main.do";
		}
		return msg;
	}
	
	@RequestMapping("ticket/seat.do")
	public String ticket_seat(HttpServletRequest request, HttpServletResponse response) {
		// grade id 받아서 구장별 좌석 출력
		String schedule_id=request.getParameter("sid");
		String gid=request.getParameter("gid");
		SeatGradeVO vo=ReserveDAO.maxSeatData(Integer.parseInt(gid));
		//String schedule_id="1199";
		
		Map map=new HashMap();
		map.put("schedule_id", Integer.parseInt(schedule_id));
		map.put("grade_id", Integer.parseInt(gid));
		List<MatchSeatVO> list=ReserveDAO.seatInfoListData(map);
		
		request.setAttribute("gid", gid);
		request.setAttribute("max_row", vo.getMax_row());
		request.setAttribute("max_col", vo.getMax_col());
		request.setAttribute("list", list);
		return "../ticket/reserve_seat.jsp";
	}
	
	@RequestMapping("ticket/info.do")
	public String ticket_info(HttpServletRequest request, HttpServletResponse response) {
		// grade id 받아서 구장별 좌석 출력
		//String schedule_id=request.getParameter("");
		//String grade_id=request.getParameter("");
		//String schedule_id="1199";
		//String grade_id="1";
		String row=request.getParameter("row");
		String col=request.getParameter("col");
		String grade_name=request.getParameter("grade_name");
		String amount=request.getParameter("amount");
		
		//Map map=new HashMap();
		//map.put("schedule_id", Integer.parseInt(schedule_id));
		//map.put("grade_id", Integer.parseInt(grade_id));
		//List<MatchSeatVO> list=ReserveDAO.seatInfoListData(map);
		
		request.setAttribute("row", row);
		request.setAttribute("col", col);
		request.setAttribute("grade_name", grade_name);
		request.setAttribute("amount", amount);
		//request.setAttribute("list", list);
		return "../ticket/reserve_info.jsp";
	}
	
	@RequestMapping("ticket/reserve_insert.do")
	public void reserve_insert(HttpServletRequest request, HttpServletResponse response) {
		String schedule_id=request.getParameter("schedule_id");
		String total_amount=request.getParameter("total_amount");
		String match_seat_id=request.getParameter("match_seat_id");
		String seat_row=request.getParameter("seat_row");
		String seat_col=request.getParameter("seat_col");
		String amount=request.getParameter("amount");
		String grade_name=request.getParameter("grade_name");
		HttpSession session=request.getSession();
		int member_id=(int)session.getAttribute("member_id");
		
		// #{seat_row},#{seat_col},#{amount},#{grade_name}
		
		Map map=new HashMap();
		// 예시
		map.put("schedule_id", schedule_id);
		map.put("total_amount", total_amount);
		map.put("member_id", member_id);
		map.put("match_seat_id", match_seat_id);
		map.put("seat_row", seat_row);
		map.put("seat_col", seat_col);
		map.put("amount", amount);
		map.put("grade_name", grade_name);
		ReserveDAO.reserveInsert(map);
		
		// 추후 마이페이지로 이동
		//return "redirect:../mypage/mypage_reserve.do";
	}
}
