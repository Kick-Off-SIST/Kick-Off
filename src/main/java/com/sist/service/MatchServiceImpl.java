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

}
