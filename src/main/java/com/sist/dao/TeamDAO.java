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
//	<select id="teamListData" resultMap="TeamMap">
//		SELECT team_id,team_name,emblem,s.name
//		FROM KLeague_team t JOIN KLeague_Stadium s
//		ON t.stadium_id=s.stadium_id
//	</select>
	public List<TeamVO> teamListData(){
		SqlSession session=ssf.openSession();
		List<TeamVO> list=session.selectList("teamListData");
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
//	<select id="teamRankData" resultType="TeamVO">
//		SELECT 
//		    RANK() OVER(ORDER BY SUM(u.win_count) DESC) AS rank,
//		    t.team_id,
//		    t.team_name,
//		    SUM(u.win_count) AS wins
//		FROM (
//		    SELECT home_team_id AS team_id, home_win AS win_count
//		    FROM kleague_schedule
//		    WHERE game_date&gt;=TO_DATE('20260101','YYYYMMDD')
//		    
//		    UNION ALL
//		    
//		    SELECT away_team_id AS team_id, away_win AS win_count
//		    FROM kleague_schedule
//		    WHERE game_date&gt;=TO_DATE('20260101','YYYYMMDD')
//		) u
//		JOIN kleague_team t ON u.team_id = t.team_id
//		GROUP BY t.team_name, t.team_id
//		ORDER BY rank ASC
//	</select>
	public List<TeamVO> teamRankData() {
		SqlSession session=ssf.openSession();
		List<TeamVO> list=session.selectList("teamRankData");
		session.close();
		return list;
	}
}
