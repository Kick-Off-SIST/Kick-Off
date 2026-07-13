package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.LikeVO;

public class LikeDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
//	<select id="likeCount" resultType="int" parameterType="LikeVO">
//		SELECT NVL(COUNT(*),0)
//		FROM myLike
//		<where>
//			cno=#{cno}
//			<if test="cno==1">AND player_id=#{player_id}</if>
//		</where>
//	</select>
	public int likeCount(LikeVO vo) {
		SqlSession session=ssf.openSession();
		int count=session.selectOne("likeCount",vo);
		session.close();
		return count;
	}
//	<select id="isLiked" resultType="int" parameterType="LikeVO">
//		SELECT NVL(COUNT(*),0)
//		FROM myLike
//		<where>
//			type=#{type}
//			<if test="type==1">AND player_id=#{player_id}</if>
//			AND member_id=#{member_id}
//		</where>
//	</select>
	public int isLiked(LikeVO vo) {
		SqlSession session=ssf.openSession();
		int count=session.selectOne("isLiked",vo);
		session.close();
		return count;
	}
//	<insert id="likeOn" parameterType="LikeVO">
//		INSERT INTO myLike(cno,player_id,member_id)
//		VALUES(#{cno},#{player_id},#{member_id})
//	</insert>
	public void likeOn(LikeVO vo) {
		try(SqlSession session=ssf.openSession()){
			session.insert("likeOn",vo);
			session.commit();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
//	<delete id="likeOff" parameterType="LikeVO">
//		DELETE FROM myLike
//		<where>
//			cno=#{cno}
//			<if test="cno==1">AND player_id=#{player_id}</if>
//			AND member_id=#{member_id}
//		</where>
//	</delete>
	public void likeOff(LikeVO vo) {
		try(SqlSession session=ssf.openSession()){
			session.delete("likeOff",vo);
			session.commit();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}
