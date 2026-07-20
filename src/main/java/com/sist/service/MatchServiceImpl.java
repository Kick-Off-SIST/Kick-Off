package com.sist.service;

import java.util.List;

import com.sist.dao.MatchDAO;
import com.sist.vo.MatchVO;

public class MatchServiceImpl implements MatchService {
	private MatchDAO dao=new MatchDAO();
	@Override
	public List<MatchVO> matchListData(String searchDate) {
		return dao.matchListData(searchDate);
	}
	@Override
	public List<MatchVO> matchRecentData(String currentDate) {
		return dao.matchRecentData(currentDate);
	}
	@Override
	public MatchVO matchCloseData() {
		return dao.matchCloseData();
	}

}
