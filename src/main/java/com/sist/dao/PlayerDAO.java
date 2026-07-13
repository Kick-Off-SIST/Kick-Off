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
//	<select id="playerDetailData" resultMap="PlayerMap" parameterType="int">
//		SELECT player_id,p.team_id,name,name_eng,position,nationality,height,weight,TO_CHAR(birth_date,'yyyy-mm-dd') AS dbday,back_number,img_url,t.team_name,t.emblem
//		FROM KLeague_Player p 
//		JOIN KLeague_Team t ON p.team_id=t.team_id
//		WHERE player_id=#{player_id}
//	</select>
	public PlayerVO playerDetailData(int player_id) {
		PlayerVO vo=new PlayerVO();
		try(SqlSession session=ssf.openSession()){
			vo=session.selectOne("playerDetailData",player_id);
			session.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return vo;
	}
//	<update id="updatePlayerLikeCount" parameterType="int">
//		UPDATE KLeague_Player SET
//		likecount=(SELECT COUNT(*)
//					FROM myLike
//					WHERE player_id=#{player_id})
//		WHERE player_id=#{player_id}
//	</update>
	public void updatePlayerLikeCount(int player_id) {
		try(SqlSession session=ssf.openSession()){
			session.update("updatePlayerLikeCount",player_id);
			session.commit();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}
