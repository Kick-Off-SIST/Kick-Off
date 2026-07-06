package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.MemberVO;
public class MemberDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
//	<select id="memberListData" resultType="MemberVO" parameterType="int">
//	SELECT member_id,login_id,name,email,phone,isadmin,TO_CHAR(regdate,'yyyy-mm-dd') AS dbday
//	FROM MemberTest
//	ORDER BY member_id
//	OFFSET #{start} ROWS FETCH NEXT 20 ROWS ONLY
//</select>
	public List<MemberVO> memberListData(int start){
		SqlSession session=ssf.openSession();
		List<MemberVO> list=session.selectList("memberListData",start);
		session.close();
		return list;
	}

//<select id="memberTotalPage" resultType="int">
//	SELECT CEIL(COUNT(*)/20.0)
//	FROM MemberTest
//</select>
	public int memberTotalPage() {
		SqlSession session=ssf.openSession();
		int total=session.selectOne("memberTotalPage");
		session.close();
		return total;
	}
//<insert id="memberInsert" parameterType="MemberVO">
//	INSERT INTO MemberTest VALUES(
//		DEFAULT,#{login_id},#{pwd},#{name},#{email},#{phone},#{isadmin},DEFAULT
//	)
//</insert>
	public void memberInsert(MemberVO vo) {
		SqlSession session=ssf.openSession();
		session.insert("memberInsert",vo);
		session.commit();
		session.close();
	}
//<update id="memberUpdate" parameterType="MemberVO">
//	UPDATE MemberTest SET
//	pwd=#{pwd}, name=#{name}
//	WHERE member_id=#{member_id}
//</update>
	public void memberUpdate(MemberVO vo) {
		SqlSession session=ssf.openSession();
		session.update("memberUpdate",vo);
		session.commit();
		session.close();
	}
//<update id="memberDisable" parameterType="MemberVO">
//	UPDATE MemberTest SET
//	status='N'
//	WHERE member_id=#{member_id}
//</update>
	public void memberDisable(MemberVO vo) {
		SqlSession session=ssf.openSession();
		session.update("memberDisable",vo);
		session.commit();
		session.close();
	}
//<select id="memberIdCount" resultType="int" parameterType="string">
//	SELECT COUNT(*)
//	FROM MemberTest
//	WHERE login_id=#{login_id}
//</select>
//<select id="memberInfoData" resultType="MemberVO" parameterType="string">
//	SELECT login_id,name,isadmin,pwd
//	FROM MemberTest
//	WHERE login_id=#{login_id}
//</select>
	public MemberVO isLogin(String id,String pwd) {
		SqlSession session=ssf.openSession();
		MemberVO vo=new MemberVO();
		int count=session.selectOne("memberIdCount",id);
		if(count==0) {
			vo.setMsg("NOID");
		}
		else {
			MemberVO dbVO=session.selectOne("memberInfoData",id);
			if(dbVO.getStatus()==null||"N".equals(dbVO.getStatus())) {
				vo.setMsg("DIS");
			}
			else if(pwd.equals(dbVO.getPwd())) {
				vo.setMsg("OK");
				vo.setMember_id(dbVO.getMember_id());
				vo.setLogin_id(dbVO.getLogin_id());
				vo.setName(dbVO.getName());
				vo.setIsAdmin(dbVO.getIsAdmin());
			}else {
				vo.setMsg("NOPWD");
			}
		}
		session.close();
		return vo;
	}
}
