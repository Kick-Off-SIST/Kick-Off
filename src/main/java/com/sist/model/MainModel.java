package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.service.MatchService;
import com.sist.service.MatchServiceImpl;
import com.sist.service.TeamService;
import com.sist.service.TeamServiceImpl;
import com.sist.vo.*;

import java.util.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MainModel {
	TeamService tService=new TeamServiceImpl();
	MatchService mService=new MatchServiceImpl();
	@RequestMapping("main/main.do")
	public String main_main(HttpServletRequest request,HttpServletResponse response) {
		List<TeamVO> rlist=tService.teamRankData();
		
//		String currentDate=java.time.LocalDate.now().toString();
		String currentDate="2026-06-30";
		List<MatchVO> mlist=mService.matchRecentData(currentDate);
		
		request.setAttribute("mList", mlist);
		request.setAttribute("rList", rlist);
		request.setAttribute("main_jsp", "../main/home.jsp");
		return "../main/main.jsp";
	}
}
