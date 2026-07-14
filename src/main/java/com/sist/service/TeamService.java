package com.sist.service;

import java.util.List;

import com.sist.vo.TeamVO;

public interface TeamService {
	public List<TeamVO> teamEmblemData();
	public TeamVO teamDetailData(String team_id);
	public List<TeamVO> teamListData();
	public List<TeamVO> teamRankData();
}
