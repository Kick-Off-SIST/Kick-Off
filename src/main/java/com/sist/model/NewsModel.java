package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class NewsModel {
	@RequestMapping("news/find.do")
	public String news_find(HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("main_jsp", "../news/news.jsp");
		return "../main/main.jsp";
	}
}
