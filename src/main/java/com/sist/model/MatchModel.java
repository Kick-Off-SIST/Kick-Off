package com.sist.model;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.commons.Commons;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.service.*;
import com.sist.vo.MatchVO;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class MatchModel {
	private MatchService service=new MatchServiceImpl();
	@RequestMapping("match/list.do")
	public String match_list(HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("main_jsp", "../match/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("match/list_vue.do")
	public void match_list_vue(HttpServletRequest request,HttpServletResponse response) {
		String searchDate=request.getParameter("searchDate");
		List<MatchVO> list=service.matchListData(searchDate);
		try {
			ObjectMapper mapper=new ObjectMapper();
			String json=mapper.writeValueAsString(list);
			Commons.sendData(response, "text/plain", json);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	@RequestMapping("match/recent_vue.do")
	public void match_recent_vue(HttpServletRequest request,HttpServletResponse response) {
		String currentDate=request.getParameter("searchDate");
		List<MatchVO> list=service.matchRecentData(currentDate);
		try {
			ObjectMapper mapper=new ObjectMapper();
			String json=mapper.writeValueAsString(list);
			Commons.sendData(response, "text/plain", json);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}
