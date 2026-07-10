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
//		JSONArray dateArr=new JSONArray();
//		LocalDate today=LocalDate.now();
//		for(int i=0;i<14;i++) {
//			LocalDate day=today.plusDays(i);
//			JSONObject obj=new JSONObject();
//			obj.put("fullDate", day.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
//			obj.put("dayNum", String.valueOf(day.getDayOfMonth()));
//			obj.put("dayName", day.getDayOfWeek().getDisplayName(TextStyle.FULL,Locale.KOREAN));
//			dateArr.add(obj);
//		}
//		request.setAttribute("dList", dateArr.toJSONString());
//		
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
}
