package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.PlayerVO;

public interface PlayerService {
	public List<PlayerVO> playerListData(Map map);
	public int playerTotalPage(Map map);
	public PlayerVO playerDetailData(int player_id);
	public void updatePlayerLikeCount(int player_id);
}
