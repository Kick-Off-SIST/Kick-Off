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
		TeamService ts=new TeamServiceImpl();
		List<TeamVO> list=ts.teamEmblemData();
		request.setAttribute("list", list);
		request.setAttribute("main_jsp", "../ticket/reserve_team.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("ticket/reserve_list.do")
	public String ticket_reserve_list(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("id");
		String imgSrc=ReserveDAO.reserveTeamMainData(id);
		request.setAttribute("imgSrc", imgSrc);
		
		String ticketImage=ReserveDAO.reserveTeamTicketImage(id);
		request.setAttribute("ticketImage", ticketImage);
		
		
		request.setAttribute("main_jsp", "../ticket/reserve_list.jsp");
		return "../main/main.jsp";
	}
}
