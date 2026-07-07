package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.service.TeamService;
import com.sist.service.TeamServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class TeamModel {
	private TeamService service=new TeamServiceImpl();
	@RequestMapping("team/emblem_vue.do")
	public void team_emblem_vue(HttpServletRequest request,HttpServletResponse response) {
		
	}
}
