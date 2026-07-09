package com.sist.model;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.commons.Commons;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.service.TeamService;
import com.sist.service.TeamServiceImpl;
import com.sist.vo.TeamVO;

import java.io.InputStream;
import java.util.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class TeamModel {
	private TeamService service=new TeamServiceImpl();
	@RequestMapping("team/emblem_vue.do")
	public void team_emblem_vue(HttpServletRequest request,HttpServletResponse response) {
		List<TeamVO> list=service.teamEmblemData();
		try {
			ObjectMapper mapper=new ObjectMapper();
			String json=mapper.writeValueAsString(list);
			Commons.sendData(response, "text/plain", json);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	@RequestMapping("team/list.do")
	public String team_list(HttpServletRequest request,HttpServletResponse response) {
		List<TeamVO> list=service.teamListData();
		request.setAttribute("list", list);
		request.setAttribute("main_jsp", "../team/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("team/detail.do")
	public String team_detail(HttpServletRequest request,HttpServletResponse response) {
		String team_id=request.getParameter("team_id");
		TeamVO vo=service.teamDetailData(team_id);
		Properties prop=new Properties();
		try(InputStream is=Thread.currentThread().getContextClassLoader().getResourceAsStream("api.properties")){
			if(is!=null) {
				prop.load(is);
				String kakaoAPI=prop.getProperty("kakao.mapAPI");
				request.setAttribute("kakaoAPI", kakaoAPI);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../team/detail.jsp");
		return "../main/main.jsp";
	}
}
