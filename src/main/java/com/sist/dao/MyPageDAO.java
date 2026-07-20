package com.sist.dao;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;

public class MyPageDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
/*
<select id="mypageInfoData" resultType="MemberVO" parameterType="int">
	SELECT member_id,login_id,name,sex,email,addr1,addr2,content,phone,
		TO_CHAR(regdate,'yyyy-mm-dd') as dbday, grade, birthday
	FROM Member
	WHERE member_id=#{member_id}
</select>
 */
	public static MemberVO mypageInfoData(int member_id) {
		SqlSession session=ssf.openSession();
		MemberVO vo=session.selectOne("mypageInfoData",member_id);
		session.close();
		return vo;
	}
	
	public static int mypageReserveCount(int member_id) {
		SqlSession session=ssf.openSession();
		int count=session.selectOne("mypageReserveCount",member_id);
		session.close();
		return count;
	}
	
/*
<select id="cartGoodsDetailData" resultMap="CartMap" parameterType="int">
	SELECT c.goods_no,cart_id,count,goods_name, price, image_url
	FROM cart c JOIN goods g ON c.goods_no = g.goods_no
	WHERE member_id=#{member_id}
</select>
 */
	public static List<CartVO> cartGoodsDetailData(int member_id) {
		SqlSession session=ssf.openSession();
		List<CartVO> list=session.selectList("cartGoodsDetailData",member_id);
		session.close();
		return list;
	}
/*
<select id="mypageReserveListData" resultMap="rMap" parameterType="int" >
	SELECT d.reserve_id, r.schedule_id, t1.team_name as home, t2.team_name as away,
	TO_CHAR(game_date,'yyyy-mm-dd') as gday, game_time, 
	grade_name, seat_row, seat_col, TO_CHAR(reserve_time,'yyyy-mm-dd') as rday, total_amount
	FROM reservation_detail d JOIN reservation r ON r.reserve_id=d.reserve_id
	JOIN kleague_schedule s ON r.schedule_id=s.schedule_id
	JOIN kleague_team t1 ON s.home_team_id=t1.team_id
	JOIN kleague_team t2 ON s.away_team_id=t2.team_id
	WHERE member_id=#{member_id}
	ORDER BY reserve_id DESC
</select>
 */
	public static List<ReserveDetailVO> mypageReserveListData(int member_id) {
		SqlSession session=ssf.openSession();
		List<ReserveDetailVO> list=session.selectList("mypageReserveListData",member_id);
		session.close();
		return list;
	}
}
