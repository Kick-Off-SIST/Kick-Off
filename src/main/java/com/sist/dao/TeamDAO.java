package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.*;
import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.TeamVO;

public class TeamDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	public List<TeamVO> teamEmblemData(){
		SqlSession session=ssf.openSession();
		List<TeamVO> list=session.selectList("teamEmblemData");
		session.close();
		return list;
	}
//	<select id="teamDetailData" resultMap="TeamMap" parameterType="string">
//		SELECT team_id,team_name,t.stadium_id,emblem,s.name,s.address,s.capacity,s.latitude,s.longitude
//		FROM KLeague_Team t JOIN KLeague_Stadium s
//		ON t.stadium_id=s.stadium_id
//		WHERE team_id=#{team_id}
//	</select>
	public TeamVO teamDetailData(String team_id) {
		SqlSession session=ssf.openSession();
		TeamVO vo=session.selectOne("teamDetailData",team_id);
		session.close();
		return vo;
	}
}
