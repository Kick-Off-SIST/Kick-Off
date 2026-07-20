package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.GoodsLikeVO;
import com.sist.vo.LikeVO;

import java.util.*;
public class GoodsLikeDAO {
	private static SqlSessionFactory ssf;
	   static 
	   {
		   ssf=CreateSqlSessionFactory.getSsf();
	   }
	/*
	 * <insert id="likeOn" parameterType="GoodsLikeVO">
	    INSERT INTO goodslike VALUES(
	    	GOODLIKE_SEQ.nextval,
	    	#{gno},
	    	#{id}
	    )
	  </insert>
	 */
	public static void goodslikeOn(GoodsLikeVO vo)
	{
		SqlSession session=ssf.openSession(true);
		session.insert("goodslikeOn",vo);
		session.close();
	}
	/*
	  <delete id="likeOff" parameterType="GoodsLikeVO">
	    DELETE FROM goodslike
	    WHERE id=#{id} AND gno=#{gno}
	  </delete>
	*/
	public static void goodslikeOff(GoodsLikeVO vo)
	{
		SqlSession session=ssf.openSession(true);
		session.delete("goodslikeOff",vo);
		session.close();
	}
	/*
	  <select id="likeCount" resultType="int" parameterType="int">
	    SELECT COUNT(*)
	    FROM goodslike
	    WHERE gno=#{gno}
	  </select>
	*/
	public static int goodslikeCount(int gno)
	{
		SqlSession session=ssf.openSession(true);
		int count=session.selectOne("goodslikeCount",gno);
		session.close();
		return count;
	}
	/*
	  <select id="likeCheck" resultType="int" parameterType="GoodsLikeVO">
	    SELECT COUNT(*)
	    FROM goodlike
	    WHERE gno=#{gno} AND id=#{id}
	  </select>
	*/
	public static int goodslikeCheck(GoodsLikeVO vo)
    {
   	 SqlSession session=ssf.openSession(true);
   	 int count=session.selectOne("goodslikeCheck",vo);
   	 session.close();
   	 return count;
    }
	/*
	  <select id="goodsLikeUpdate" parameterType="int">
	  	UPDATE goods SET
	  	likecount=(SELECT COUNT(*)
	               FROM goodlike
	               WHERE gno=#{gno})
	    WHERE goods_no=#{gno}
	  </select>
	 */
	public static void goodsLikeUpdate(int fno)
    {
   	 SqlSession session=ssf.openSession(true);
   	 session.update("goodsLikeUpdate",fno);
   	 session.close();
    }
}
