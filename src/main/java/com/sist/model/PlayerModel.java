package com.sist.model;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.commons.Commons;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.service.PlayerService;
import com.sist.service.PlayerServiceImpl;
import com.sist.vo.PlayerVO;

import java.util.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class PlayerModel {
	private PlayerService service=new PlayerServiceImpl();
	@RequestMapping("player/list.do")
	public String player_list(HttpServletRequest request,HttpServletResponse response) {

		request.setAttribute("main_jsp", "../player/list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("player/list_vue.do")
	public void player_list_vue(HttpServletRequest request,HttpServletResponse response) {
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		int start=(curpage*24)-24;
		String column=request.getParameter("column");
		String team_id=request.getParameter("team_id");
		String position=request.getParameter("position");
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("column", column);
		map.put("team_id", team_id);
		map.put("position", position);
		map.put("start", start);
		
		List<PlayerVO> list=service.playerListData(map);
		int totalpage=service.playerTotalPage(map);
		final int BLOCK=10;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage) 
			endPage=totalpage;
		
		Map<String,Object> lmap=new HashMap<String,Object>();
		lmap.put("list", list);
		lmap.put("curpage", curpage);
		lmap.put("totalpage", totalpage);
		lmap.put("startPage", startPage);
		lmap.put("endPage", endPage);
		
		try {
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(lmap);
		Commons.sendData(response, "text/plain", json);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}
