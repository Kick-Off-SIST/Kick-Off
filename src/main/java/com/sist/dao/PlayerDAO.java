package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.*;
import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.PlayerVO;

public class PlayerDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
//	<select id="playerListData" resultMap="PlayerMap" parameterType="hashmap">
//	SELECT player_id,name,position,back_number,img_url,t.team_name,t.emblem
//	FROM KLeague_Player p 
//	JOIN KLeague_Team t ON p.team_id=t.team_id
//	<where>
//		<if test="team_id!=null and team_id!=''">p.team_id=#{team_id}</if>
//		<if test="position!=null and position!=''">AND position=#{position}</if>
//	</where>
//	ORDER BY ${column}
//	OFFSET #{start} ROWS FETCH NEXT 20 ROWS ONLY
//	</select>
	public List<PlayerVO> playerListData(Map map){
		List<PlayerVO> list=new ArrayList<PlayerVO>();
		try(SqlSession session=ssf.openSession()){
			list=session.selectList("playerListData",map);
			session.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return list;
	}
//	<select id="playerTotalPage" resultType="int" parameterType="hashmap">
//		SELECT CEIL(COUNT(*)/20.0)
//		FROM KLeague_Player p 
//		JOIN KLeague_Team t ON p.team_id=t.team_id
//		<where>
//			<if test="team_id!=null and team_id!=''">p.team_id=#{team_id}</if>
//			<if test="position!=null and position!=''">AND position=#{position}</if>
//		</where>
//	</select>
	public int playerTotalPage(Map map) {
		int total=0;
		try(SqlSession session=ssf.openSession()){
			total=session.selectOne("playerTotalPage",map);
			session.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return total;
	}
}
