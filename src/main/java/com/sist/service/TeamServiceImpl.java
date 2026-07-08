package com.sist.service;

import java.util.List;

import com.sist.dao.TeamDAO;
import com.sist.vo.TeamVO;

public class TeamServiceImpl implements TeamService {
	private TeamDAO dao=new TeamDAO();
	@Override
	public List<TeamVO> teamEmblemData() {
		return dao.teamEmblemData();
	}
	@Override
	public TeamVO teamDetailData(String team_id) {
		return dao.teamDetailData(team_id);
	}

}
