package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.CartDAO;
import java.util.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class CartModel {
	@RequestMapping("cart/insert.do")
	public void cart_insert_vue(HttpServletRequest request, HttpServletResponse response) {
		String no=request.getParameter("no");
		int goods_no=Integer.parseInt(no);
		//System.out.println("상품명: "+goods_no);
		HttpSession session=request.getSession();
		int member_id=(int)session.getAttribute("member_id");
		//System.out.println("유저: "+member_id);
		Map map=new HashMap();
		map.put("member_id", member_id);
		map.put("goods_no", goods_no);
		int count=CartDAO.cartGoodsCheck(map);
		if(count>0) {
			CartDAO.cartGoodsCountUpdate(map);
		}
		else {
			CartDAO.cartInsert(map);
		}
	}
	
	@RequestMapping("cart/delete.do")
	public void cart_delete(HttpServletRequest request, HttpServletResponse response) {
		String cid=request.getParameter("cart_id");
		int cart_id=Integer.parseInt(cid);
		CartDAO.cartDelete(cart_id);
	}
	
}
