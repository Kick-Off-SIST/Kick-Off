package com.sist.model;

import com.sist.commons.Commons;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.service.LikeService;
import com.sist.service.LikeServiceImpl;
import com.sist.service.PlayerService;
import com.sist.service.PlayerServiceImpl;
import com.sist.vo.LikeVO;
import com.sist.vo.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class LikeModel {
	private LikeService service=new LikeServiceImpl();
	private PlayerService pService=new PlayerServiceImpl();
	@RequestMapping("like/player_like.do")
	public void like_player_like(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session=request.getSession();
		if (session.getAttribute("user")==null) {
	        Commons.sendData(response, "text/html", "NOLOGIN");
	        return;
	    }
		MemberVO user=(MemberVO)session.getAttribute("user");
		int member_id=user.getMember_id();
		String type=request.getParameter("type");
		String player_id=request.getParameter("player_id");
		String likeType=request.getParameter("likeType");
		LikeVO vo=new LikeVO();
		vo.setType(Integer.parseInt(type));
		vo.setMember_id(member_id);
		vo.setPlayer_id(Integer.parseInt(player_id));
		String result="";
		if("1".equals(likeType)) {
			try {
				service.likeOn(vo);
				result="OK";
				pService.updatePlayerLikeCount(Integer.parseInt(player_id));
			}catch(Exception ex) {
				ex.printStackTrace();
				result="NO";
			}
		}else {
			try {
				service.likeOff(vo);
				result="OK";
				pService.updatePlayerLikeCount(Integer.parseInt(player_id));
			}catch(Exception ex) {
				ex.printStackTrace();
				result="NO";
			}
		}
		Commons.sendData(response, "text/html", result);
	}
}
