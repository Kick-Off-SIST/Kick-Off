package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.dao.PlayerDAO;
import com.sist.vo.PlayerVO;

public class PlayerServiceImpl implements PlayerService {
	private PlayerDAO dao=new PlayerDAO();
	@Override
	public List<PlayerVO> playerListData(Map map) {
		// TODO Auto-generated method stub
		return dao.playerListData(map);
	}

	@Override
	public int playerTotalPage(Map map) {
		// TODO Auto-generated method stub
		return dao.playerTotalPage(map);
	}

}
