package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import java.util.*;
import com.sist.vo.*;
import com.sist.dao.*;
import com.sist.service.TeamService;
import com.sist.service.TeamServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
		
		System.out.println("mList: "+mList);

		request.setAttribute("mList", mList);
		
		
		request.setAttribute("main_jsp", "../ticket/reserve_list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("ticket/reserve_ticket.do")
	public String ticket_reserve_ticket(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("main_jsp", "../ticket/reserve_ticket.jsp");
		return "../main/main.jsp";
	}
}
