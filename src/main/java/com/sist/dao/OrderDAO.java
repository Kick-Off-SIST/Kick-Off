package com.sist.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;

public class OrderDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
/*
<update id="stockUpdate" parameterType="int">
	UPDATE goods SET stock=stock-1 WHERE goods_no=#{goods_no}
</update>
<insert id="orderInsert" parameterType="hashmap">
	<selectKey keyProperty="oid" resultType="long" order="BEFORE">
        SELECT orders_oid_seq.nextval FROM dual
    </selectKey>
	INSERT INTO orders(orders_id,member_id,total_price)
	VALUES(#{oid},#{member_id},#{total_price})
</insert>
<insert id="orderDetailInsert" parameterType="hashmap">
	INSERT INTO orders_detail
	VALUES(od_did_seq.nextval,#{orders_id},#{goods_no},#{count},#{price},#{total})
</insert>
 */
	public static void orderInsert(Map map) {
		SqlSession session=ssf.openSession();
		session.insert("orderInsert",map);
		session.insert("orderDetailInsert",map);
		session.update("stockUpdate",map);
		session.commit();
		session.close();
	}
}
