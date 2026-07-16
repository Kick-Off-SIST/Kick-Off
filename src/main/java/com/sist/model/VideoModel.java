package com.sist.model;

import java.io.InputStream;
import java.util.Properties;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class VideoModel {
	@RequestMapping("video/highlights.do")
	public String video_highlights(HttpServletRequest request,HttpServletResponse response) {
		String youtubeAPI="";
		Properties prop=new Properties();
		try(InputStream is=Thread.currentThread().getContextClassLoader().getResourceAsStream("api.properties")){
			if(is!=null) {
				prop.load(is);
				youtubeAPI=prop.getProperty("youtube.API");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		request.setAttribute("youtubeAPI", youtubeAPI);
		request.setAttribute("main_jsp", "../video/highlights_list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("video/goal.do")
	public String video_goal(HttpServletRequest request,HttpServletResponse response) {
		String youtubeAPI="";
		Properties prop=new Properties();
		try(InputStream is=Thread.currentThread().getContextClassLoader().getResourceAsStream("api.properties")){
			if(is!=null) {
				prop.load(is);
				youtubeAPI=prop.getProperty("youtube.API");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		request.setAttribute("youtubeAPI", youtubeAPI);
		request.setAttribute("main_jsp", "../video/goal_list.jsp");
		return "../main/main.jsp";
	}
}
