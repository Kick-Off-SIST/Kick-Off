package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.GoodsLikeDAO;
import com.sist.dao.LikeDAO;
import com.sist.vo.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Controller
public class GoodsLikeModel {
	@RequestMapping("like/goodslikeOn.do")
	public String goodslikeOn(HttpServletRequest request,
			HttpServletResponse response)
	{
		HttpSession session=request.getSession();

	    MemberVO user=(MemberVO)session.getAttribute("user");

	    String id=user.getLogin_id();

	    String gno=request.getParameter("gno");

	    GoodsLikeVO vo=new GoodsLikeVO();
	    vo.setId(id);
	    vo.setGno(Integer.parseInt(gno));
	    
	    int check=GoodsLikeDAO.goodslikeCheck(vo);
	    
	    if(check==0)
	    {
	    	// 좋아요 추가
	    	GoodsLikeDAO.goodslikeOn(vo);
	    	
	    }
	    else
	    {
	    	// 취소
	    	GoodsLikeDAO.goodslikeOff(vo);
	    	
	    }
	   
	    GoodsLikeDAO.goodsLikeUpdate(Integer.parseInt(gno));

	    return "redirect:../goods/detail.do?no="+gno;
	}
	@RequestMapping("like/goodslikeOff.do")
	  public String goodslikeOff(HttpServletRequest request,
			      HttpServletResponse resposne)
	  {
		HttpSession session=request.getSession();

	    MemberVO user=(MemberVO)session.getAttribute("user");

	    String id=user.getLogin_id();
	    String gno=request.getParameter("gno");

	    GoodsLikeVO vo=new GoodsLikeVO();
	    vo.setId(id);
	    vo.setGno(Integer.parseInt(gno));

	    GoodsLikeDAO.goodslikeOff(vo);
	    GoodsLikeDAO.goodsLikeUpdate(Integer.parseInt(gno));

	    return "redirect:../goods/detail.do?no="+gno;
	  }
}
