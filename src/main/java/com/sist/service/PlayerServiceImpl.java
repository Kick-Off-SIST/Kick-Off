package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.dao.PlayerDAO;
import com.sist.vo.PlayerVO;

public class PlayerServiceImpl implements PlayerService {
	private PlayerDAO dao=new PlayerDAO();
	@Override
	public List<PlayerVO> playerListData(Map map) {
		return dao.playerListData(map);
	}

	@Override
	public int playerTotalPage(Map map) {
		return dao.playerTotalPage(map);
	}

	@Override
	public PlayerVO playerDetailData(int player_id) {
		return dao.playerDetailData(player_id);
	}

	@Override
	public void updatePlayerLikeCount(int player_id) {
		dao.updatePlayerLikeCount(player_id);
	}

}
