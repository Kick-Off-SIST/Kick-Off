package com.sist.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.*;

public class ReserveDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}

/*
<select id="reserveTeam" resultMap="TeamMap" parameterType="string">
	SELECT t.team_name, t.emblem, s.name
	FROM kleague_team t NATURAL JOIN kleague_stadium s
	ORDER BY ${col} ASC;
</select>
 */
	public static List<TeamVO> reserveTeam(String col) {
		SqlSession session=ssf.openSession();
		List<TeamVO> list=session.selectList("reserveTeam",col);
		session.close();
		return list;
	}
	
/*
<select id="reserveTeamMainData" resultType="string" parameterType="string">
	SELECT emblem FROM kleague_team WHERE team_id=${id} 
</select>
 */
	public static TeamVO reserveTeamMainData(String id) {
		SqlSession session=ssf.openSession();
		TeamVO vo=session.selectOne("reserveTeamMainData",id);
		session.close();
		return vo;
	}
/*
<select id="reserveTeamTicketImage" resultMap="TeamMap" parameterType="string">
	SELECT image FROM kleague_team NATURAL JOIN kleague_stadium WHERE team_id=#{id}
</select>
 */
	public static TeamVO reserveTeamTicketImage(String id) {
		SqlSession session=ssf.openSession();
		TeamVO image=session.selectOne("reserveTeamTicketImage",id);
		session.close();
		return image;
	}
/*
<select id="reserveTeamScheduleData" resultMap="MatchMap" parameterType="string">
	select s.schedule_id,s.game_date,s.game_time,t.team_name,t.emblem
	FRIN kleague_schedule s INNER JOIN kleague_team t
	ON s.away_team_id=t.team_id
	WHERE (s.game_date BETWEEN SYSDATE AND SYSDATE+31)
	AND home_team_id=#{id}
	ORDER BY s.game_date ASC;
</select>
 */
	public static List<MatchVO> reserveTeamScheduleData(String id) {
		SqlSession session=ssf.openSession();
		List<MatchVO> list=session.selectList("reserveTeamScheduleData",id);
		session.close();
		return list;
	}
}
