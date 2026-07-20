package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.sist.vo.*;
import java.util.*;
import com.sist.commons.CreateSqlSessionFactory;

public class MatchDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
//	<select id="matchListData" resultMap="MatchMap" parameterType="string">
//		SELECT m.schedule_id,TO_CHAR(game_date,'yyyy-mm-dd') AS dbday,GAME_TIME,t1.TEAM_NAME AS HOME_TEAM_NAME,
//			t2.TEAM_NAME AS AWAY_TEAM_NAME,t1.emblem AS HOME_TEAM_EMBLEM,t2.emblem AS AWAY_TEAM_EMBLEM,
//			s.NAME AS STADIUM_NAME,HOME_GOAL,AWAY_GOAL,GAME_STATUS
//		FROM kleague_schedule m 
//		JOIN kleague_team t1 ON m.home_team_id=t1.team_id
//		JOIN kleague_team t2 ON m.away_team_id=t2.team_id
//		JOIN kleague_stadium s ON m.stadium_id=s.stadium_id
//		WHERE TRUNC(game_date,'month')=TRUNC(TO_DATE(#{searchDate}),'month')
//	</select>
	public List<MatchVO> matchListData(String searchDate){
		SqlSession session=ssf.openSession();
		List<MatchVO> list=session.selectList("matchListData",searchDate);
		session.close();
		return list;
	}
//	<select id="matchRecentData" resultMap="MatchMap" parameterType="string">
//		SELECT schedule_id,dbday,GAME_TIME,HOME_TEAM_NAME,
//			AWAY_TEAM_NAME,HOME_TEAM_EMBLEM,AWAY_TEAM_EMBLEM,
//			STADIUM_NAME,HOME_GOAL,AWAY_GOAL,GAME_STATUS,HOME_TEAM_ID,AWAY_TEAM_ID,ROWNUM
//		FROM(SELECT m.schedule_id,TO_CHAR(game_date,'yyyy-mm-dd') AS dbday,GAME_TIME,t1.TEAM_NAME AS HOME_TEAM_NAME,
//				t2.TEAM_NAME AS AWAY_TEAM_NAME,t1.emblem AS HOME_TEAM_EMBLEM,t2.emblem AS AWAY_TEAM_EMBLEM,
//				s.NAME AS STADIUM_NAME,HOME_GOAL,AWAY_GOAL,GAME_STATUS,t1.team_id AS HOME_TEAM_ID,t2.team_id AS AWAY_TEAM_ID
//				FROM kleague_schedule m
//				JOIN kleague_team t1 ON m.home_team_id=t1.team_id
//				JOIN kleague_team t2 ON m.away_team_id=t2.team_id
//				JOIN kleague_stadium s ON m.stadium_id=s.stadium_id
//				WHERE game_date>TO_DATE(#{currentDate})
//				ORDER BY game_date ASC, TO_DATE(game_time,'HH24:MI') ASC
//			)
//		WHERE ROWNUM&lt;=5
//	</select>
	public List<MatchVO> matchRecentData(String currentDate){
		SqlSession session=ssf.openSession();
		List<MatchVO> list=session.selectList("matchRecentData",currentDate);
		session.close();
		return list;
	}
//	<select id="matchCloseData" resultMap="MatchMap">
//		SELECT schedule_id,dbday,GAME_TIME,HOME_TEAM_NAME,
//				AWAY_TEAM_NAME,HOME_TEAM_EMBLEM,AWAY_TEAM_EMBLEM,
//				STADIUM_NAME,HOME_GOAL,AWAY_GOAL,GAME_STATUS,HOME_TEAM_ID,AWAY_TEAM_ID
//		FROM (
//			SELECT m.schedule_id AS schedule_id,TO_CHAR(game_date,'yyyy-mm-dd') AS dbday,GAME_TIME,t1.TEAM_NAME AS HOME_TEAM_NAME,
//				t2.TEAM_NAME AS AWAY_TEAM_NAME,t1.emblem AS HOME_TEAM_EMBLEM,t2.emblem AS AWAY_TEAM_EMBLEM,
//				s.NAME AS STADIUM_NAME,HOME_GOAL,AWAY_GOAL,GAME_STATUS,t1.team_id AS HOME_TEAM_ID,t2.team_id AS AWAY_TEAM_ID
//			FROM kleague_schedule m 
//			JOIN kleague_team t1 ON m.home_team_id=t1.team_id
//			JOIN kleague_team t2 ON m.away_team_id=t2.team_id
//			JOIN kleague_stadium s ON m.stadium_id=s.stadium_id
//			WHERE game_date&gt;=SYSDATE
//			ORDER BY game_date DESC)
//		WHERE ROWNUM=1
//	</select>
	public MatchVO matchCloseData() {
		SqlSession session=ssf.openSession();
		MatchVO vo=session.selectOne("matchCloseData");
		session.close();
		return vo;
	}
}
