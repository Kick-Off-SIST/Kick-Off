package com.sist.dao;

import java.util.List;
import java.util.Map;

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
/*
<select id="seatGradeListData" resultType="com.sist.vo.SeatGradeVO" parameterType="int">
	SELECT * FROM seat_grade WHERE stadium_id=#{id}
</select>
 */
	public static List<MatchSeatVO> seatGradeListData(int schedule_id) {
		SqlSession session=ssf.openSession();
		List<MatchSeatVO> list=session.selectList("seatGradeListData",schedule_id);
		session.close();
		return list;
	}
/*
<select id="scheduleDetailData" resultType="MatchVO" parameterType="int">
	SELECT stadium_id
	FROM kleague_schedule
	WHERE schedule_id=#{id}
</select>
 */
	public static MatchVO scheduleDetailData(int id) {
		SqlSession session=ssf.openSession();
		MatchVO vo=session.selectOne("scheduleDetailData",id);
		session.close();
		return vo;
	}
/*
<select id="maxSeatData" resultType="com.sist.vo.SeatGradeVO" parameterType="int">
	SELECT max_row, max_col
	FROM seat_grade
	WHERE grade_id=#{grade_id}
</select>
 */
	public static SeatGradeVO maxSeatData(int id) {
		SqlSession session=ssf.openSession();
		SeatGradeVO vo=session.selectOne("maxSeatData",id);
		session.close();
		return vo;
	}
/*
<select id="seatInfoListData" resultMap="MatchSeatMap" parameterType="hashmap">
	SELECT match_seat_id, seat_status, seat_row, seat_col, amount
	FROM match_seat m JOIN stadium_seat s ON s.seat_id=m.seat_id
	JOIN seat_grade g ON s.grade_id=g.grade_id
	AND schedule_id=#{schedule_id} AND s.grade_id=#{grade_id}
</select>
 */
	public static List<MatchSeatVO> seatInfoListData(Map map) {
		SqlSession session=ssf.openSession();
		List<MatchSeatVO> list=session.selectList("seatInfoListData",map);
		session.close();
		return list;
	}
/*
<insert id="reserveInsert" parameterType="hashmap">
	INSERT INTO reservation
	VALUES(res_rid_seq.nextval,SYSDATE,#{total_amount},#{member_id})
</insert>
<insert id="reserveDetailInsert" parameterType="hashmap">
	INSERT INTO reservation
	VALUES(resd_rdid_seq.nextval,#{rid},#{match_seat_id})
</insert>
 */
	public static void reserveInsert(Map map) {
		SqlSession session=ssf.openSession();
		session.insert("reserveInsert",map);
		// 한 예매에 여러 좌석을 예매한다면 for문으로 처리
		session.insert("reserveDetailInsert",map);
		session.update("matchSeatStatusUpdate",map);
		session.commit();
		session.close();
	}

/*
<update id="matchSeatStatusRemove">
	UPDATE match_seat SET seat_status='Y' WHERE match_seat_id=#{match_seat_id};
</update>
<delete id="reserveDetailDelete" parameterType="int">
	DELETE FROM reservation_detail WHERE reserve_id=#{reserve_id}
</delete>
<delete id="reserveDelete" parameterType="int">
	DELETE FROM reservation WHERE reserve_id=#{reserve_id}
</delete>
 */
		public static void reserveDelete(Map map) {
			SqlSession session=ssf.openSession();
			session.update("matchSeatStatusRemove",map);
			session.delete("reserveDetailDelete",map);
			session.delete("reserveDelete",map);
			session.commit();
			session.close();
		}
/*
<select id="matchSeatCount" resultType="int" parameterType="int">
	SELECT count(*)
	FROM kleague_schedule s JOIN match_seat m ON s.schedule_id=m.schedule_id
	AND s.schedule_id=#{schedule_id}
</select>
 */
		public static int matchSeatCount(int schedule_id){
			SqlSession session=ssf.openSession();
			int count=session.selectOne("matchSeatCount",schedule_id);
			session.close();
			return count;
		}	
/*
<select id="matchInfo" resultMap="mMap" parameterType="int">
	SELECT s.schedule_id, 
	t1.emblem as home_em, t1.team_name as home,
	t2.emblem as away_em, t2.team_name as away,
	TO_CHAR(game_date,'yyyy-mm-dd') as dbday, game_time, name
	FROM kleague_schedule s JOIN kleague_team t1 ON s.home_team_id=t1.team_id
	JOIN kleague_team t2 ON s.away_team_id=t2.team_id
    JOIN kleague_stadium g ON s.stadium_id=g.stadium_id
    WHERE s.schedule_id=#{schedule_id}
</select>
 */
		public static MatchVO matchInfo(int schedule_id) {
			SqlSession session=ssf.openSession();
			MatchVO vo=session.selectOne("matchInfo",schedule_id);
			session.close();
			return vo;
		}
}
