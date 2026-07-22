package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.OrderDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.*;

@Controller
public class OrderModel {
	@RequestMapping("order/insert.do")
	public void order_insert(HttpServletRequest request, HttpServletResponse response) {
		String gno=request.getParameter("goods_no");
		String cnt=request.getParameter("count");
		String pr=request.getParameter("price");
		String goods_name=request.getParameter("goods_name");
		int goods_no=Integer.parseInt(gno);
		int count=Integer.parseInt(cnt);
		int price=Integer.parseInt(pr);
		int total=count*price;
		// 한 주문에 하나의 상품만 주문시
		int total_price=total;
		
		HttpSession session=request.getSession();
		int member_id=(int)session.getAttribute("member_id");
		
		Map map=new HashMap();
		map.put("goods_no", goods_no);
		map.put("count", count);
		map.put("price", price);
		map.put("total", total);
		map.put("total_price", total_price);
		map.put("member_id", member_id);
		map.put("goods_name", goods_name);
		
		OrderDAO.orderInsert(map);
		
		//return "redirect:../mypage/mypage.do";
	}
}
