package com.sist.model;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.commons.Commons;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import java.util.*;
import java.io.*;
import com.sist.vo.*;
import com.sist.dao.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class GoodsModel {
	@RequestMapping("goods/list.do")
	public String goods_list(HttpServletRequest request,
			   HttpServletResponse response)
	{
		    return "../goods/list.jsp";  // ← 여기서 포워드할 때 위 데이터 같이 넘어감
	}
	@RequestMapping("goods/list_vue.do")
	public void goods_list_vue(HttpServletRequest request,
			   HttpServletResponse response)
	{
		try
		{
			String page=request.getParameter("page");
			int curpage=Integer.parseInt(page);
			int start=(curpage*12)-12;
			List<GoodsVO> list=GoodsDAO.goodsListData(start);
			int totalpage=GoodsDAO.goodsTotalPage();
			
			final int BLOCK=10;
			int startPage=((curpage-1)/BLOCK*BLOCK)+1;
			int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
			
			if(endPage>totalpage)
				endPage=totalpage;
			
			Map map=new HashMap();
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("curpage", curpage);
			map.put("totalpage", totalpage);
			map.put("goods_list", list);
			
			ObjectMapper mapper=new ObjectMapper();
			String json=mapper.writeValueAsString(map);
			
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(json);
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}	
		
	
		@RequestMapping("goods/find.do")
		public String goods_find(HttpServletRequest request,
				   HttpServletResponse response)
		{
			request.setAttribute("main_jsp", "../goods/find.jsp");
		    return "../main/main.jsp";
		}
		
		@RequestMapping("goods/find_vue.do")
		public void goods_find_vue(HttpServletRequest request,
				   HttpServletResponse response)
		{
			String page=request.getParameter("page");
		    String category=request.getParameter("category");
		    String ss=request.getParameter("ss");
		    
		 // JSP => 서버 => 새로운 JSP 출력 (기존에 있는 JSP 자동으로 메모리 해제)
		    // Vue / Ajax ==> 화면 변경이 없이 그자리에서 처리 (JSP를 그대로 유지)
		    int curpage=Integer.parseInt(page);
		    int start=(curpage*12)-12;
		    Map map=new HashMap();
		    map.put("start", start);
		    map.put("category", category);
		    map.put("ss", ss);
		    List<GoodsVO> list=GoodsDAO.goodsFindListData(map);
		    int totalpage=GoodsDAO.goodsFindTotalPage(map);
		    
		      final int BLOCK=10;
			  int startPage=((curpage-1)/BLOCK*BLOCK)+1;
			  int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
			  
			  if(endPage>totalpage)
				  endPage=totalpage;
			  
			  map=new HashMap();
			  map.put("startPage", startPage);
			  map.put("endPage", endPage);
			  map.put("curpage", curpage);
			  map.put("totalpage", totalpage);
			  map.put("goods_list", list);
			  
			 try
			 {
			  ObjectMapper mapper=new ObjectMapper();
			  String json=mapper.writeValueAsString(map);
			  
			  Commons.sendData(response, "text/plain", json);
			 }catch(Exception ex)
			 {
				 ex.printStackTrace();
			 }
		}
		@RequestMapping("goods/detail.do")
		public String goods_detail(HttpServletRequest request,
				   HttpServletResponse response)
		{
			String no=request.getParameter("no");
			request.setAttribute("no", no);
			request.setAttribute("main_jsp", "../goods/detail.jsp");
		    return "../main/main.jsp";
		}
		@RequestMapping("goods/detail_vue.do")
		public void goods_detail_vue(HttpServletRequest request,
				   HttpServletResponse response)
		{
			try
			{
				String no=request.getParameter("no");
				GoodsVO vo=GoodsDAO.goodsDetailData(Integer.parseInt(no));
				ObjectMapper mapper=new ObjectMapper();
				String json=mapper.writeValueAsString(vo);
				
				Commons.sendData(response, "text/plain", json);
			}catch(Exception ex)
			{
				ex.printStackTrace();
			}
		}
		
}
