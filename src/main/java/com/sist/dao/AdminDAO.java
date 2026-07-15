package com.sist.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.commons.*;
import com.sist.vo.*;
public class AdminDAO {
	private static SqlSessionFactory ssf;
	static
	{
		ssf=CreateSqlSessionFactory.getSsf();
	}
	/*
	 * <select id="memberListData" resultType="MemberVO">
		SELECT id,name,sex,addr1,phone,grade
		FROM member
		WHERE admin!='y'
		ORDER BY regdate DESC
		OFFSET #{start} ROWS FETCH NEXT 10 ROWS ONLY
	  </select>
	*/
	public static List<MemberVO> AdmemberListData(int start)
	{
		SqlSession session=ssf.openSession();
		List<MemberVO> list=session.selectList("AdmemberListData",start);
		session.close();
		return list;
	}	
	/*
	  <select id="memberTotalPage" resultType="int">
	    SELECT CEIL(COUNT(*)/10.0)
	    FROM member
	  </select>
	*/
	public static int AdmemberTotalPage()
	{
		SqlSession session=ssf.openSession();
		int total=session.selectOne("AdmemberTotalPage");
		session.close();
		return total;
	}
	/*
	  <update id="memberGradeChange" parameterType="MemberVO">
	    UPDATE member SET
	    grade=#{grade}
	    WHERE id=#{id}
	  </update>
	 */
	public static int memberGradeChange(MemberVO vo)
	{
		SqlSession session=ssf.openSession(true);
		int count=session.update("memberGradeChange",vo);
		session.close();
		return count;
	}
	
}
