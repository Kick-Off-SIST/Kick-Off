package com.sist.service;

import java.util.List;

import com.sist.vo.MatchVO;

public interface MatchService {
	public List<MatchVO> matchListData(String searchDate);
}
