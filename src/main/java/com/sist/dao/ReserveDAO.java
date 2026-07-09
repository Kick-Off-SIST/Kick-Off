package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;

public class ReserveDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
/*
<select id="reserveTeamMainData" resultType="string" parameterType="string">
	SELECT emblem FROM kleague_team WHERE team_id=${id} 
</select>
 */
	public static String reserveTeamMainData(String id) {
		SqlSession session=ssf.openSession();
		String elblem=session.selectOne("reserveTeamMainData",id);
		session.close();
		return elblem;
	}
/*
<select id="reserveTeamTicketImage" resultMap="TeamMap" parameterType="string">
	SELECT image FROM kleague_team NATURAL JOIN kleague_stadium WHERE team_id=#{id}
</select>
 */
	public static String reserveTeamTicketImage(String id) {
		SqlSession session=ssf.openSession();
		String image=session.selectOne("reserveTeamTicketImage",id);
		session.close();
		return image;
	}
}
