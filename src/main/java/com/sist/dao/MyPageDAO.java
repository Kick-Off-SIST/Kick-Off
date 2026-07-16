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
	
}
