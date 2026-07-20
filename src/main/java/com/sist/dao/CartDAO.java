package com.sist.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;

public class CartDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	
/*
<!-- 장바구니 담기 -->
<insert id="cartInsert" parameterType="hashmap">
	INSERT INTO cart
	VALUES(cart_cid_seq.val, #{member_id}, #{goods_no}, 1)
</insert>
*/
	public static void cartInsert(Map map) {
		SqlSession session=ssf.openSession(true);
		try {
			session.insert("cartInsert",map);
		} catch (Exception e) {
			System.err.println("오류1: "+e.getMessage());
		}
		session.close();
	}
/*
<!-- 중복된 상품 장바구니 담을 시 count만 증가 -->
<select id="cartGoodsCheck" resultType="int" parameterType="hashmap">
	SELECT COUNT(*) FROM cart WHERE member_id=#{member_id} AND goods_no=#{goods_no}
</select>
*/
	public static int cartGoodsCheck(Map map) {
		SqlSession session=ssf.openSession();
		int count=0;
		try {
			count=session.selectOne("cartGoodsCheck",map);
		} catch (Exception e) {
			System.err.println("오류2: "+e.getMessage());
		}
		session.close();
		return count;
	}
/*
<update id="cartGoodsCountUpdate" parameterType="hashmap">
	UPDATE cart SET count=count+1 WHERE member_id=#{member_id} AND goods_no=#{goods_no}
</update>
 */
	
	public static void cartGoodsCountUpdate(Map map) {
		SqlSession session=ssf.openSession(true);
		
		try {
			session.update("cartGoodsCountUpdate",map);
		} catch (Exception e) {
			System.err.println("오류3: "+e.getMessage());	
		}
		session.close();
	}
}
