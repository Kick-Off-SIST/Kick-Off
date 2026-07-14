package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;
public class BoardDAO {
	private static SqlSessionFactory ssf;
	static
	{
		ssf=CreateSqlSessionFactory.getSsf();
	}
	/*
	 * <select id="boardListData" resultType="BoardVO" parameterType="int">
	  	SELECT no,title,content,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit,
	  	m.login_id as loginId
	  	FROM board
	  	JOIN member m ON b.member_id = m.member_id
	  	ORDER BY no DESC
	  	OFFSET #{start} ROWS FETCH NEXT 10 ROWS ONLY
	  </select>
	  */
	public static List<BoardVO> boardListData(int start)
	{
		SqlSession session=ssf.openSession();
		List<BoardVO> list=session.selectList("boardListData",start);
		session.close();
		return list;
	}	
	/*
	  <select id="boardTotalPage" resultType="int">
	    SELECT COUNT(*)
	    FROM board
	  </select>
	 */
	public static int boardTotalPage()
	{
		SqlSession session=ssf.openSession();
		int total=session.selectOne("boardTotalPage");
		session.close();
		return total;
	}
	/*
	 * <insert id="boardInsert" parameterType="BoardVO">
	    INSERT INTO board(no,name,title,content,pwd) VALUES(
	    board_no_seq.nextval
	      #{name},
	      #{title},
	      #{content},
	      #{pwd}
	    )
	  </insert>
	*/
	public static void boardInsert(BoardVO vo)
	{
		SqlSession session=ssf.openSession(true);
		session.insert("boardInsert",vo);  
		session.close();		
	}
	/*
	  <update id="hitIncrement" parameterType="int">
	    UPDATE board SET
	    hit=hit+1
	    WHERE no=#{no}
	  </update>
	  <select id="boardDetailData" resultType="BoardVO">
	    SELECT b.no, b.title, b.content,
	           TO_CHAR(b.regdate,'YYYY-MM-DD') as dbday,
	           b.hit, b.pwd,
	           m.login_id as loginId
	    FROM board b
	    JOIN member m ON b.member_id = m.member_id
	    WHERE b.no = #{no}
	  </select>
	  */
	public static BoardVO boardDetailData(int no)
	{
		SqlSession session=ssf.openSession(true);
		session.update("hitIncrement",no);
		BoardVO vo=session.selectOne("boardDetailData",no);
		session.close();
		return vo;
	}
	/*
	  <select id="boardGetPassword" resultType="string" parameterType="int">
	    SELECT pwd
	    FROM board
	    WHERE no = #{no}
	  </select>
	  <delete id="boardDelete" parameterType="int">
	    DELETE FROM board
	    WHERE no=#{no}
	  </delete>
	 */
	public static String boardDelete(int no,String pwd)
	{	
		String result="no";		
		SqlSession session=ssf.openSession();		
		String db_pwd=session.selectOne("boardGetPassword",no);
		if(db_pwd.equals(pwd))
		{			
			session.delete("boardDelete",no);
			session.commit();
			result="yes";
		}
		session.close();
		return result;
	}
	public static BoardVO boardUpdateData(int no)
	{
		SqlSession session=ssf.openSession();
		BoardVO vo=session.selectOne("boardDetailData",no);
		session.close();
		return vo;
	}
	public static String boardUpdate(BoardVO vo)
	{
		String result="no";		
		SqlSession session=ssf.openSession();		
		String db_pwd=session.selectOne("boardGetPassword",vo.getNo());
		if(db_pwd.equals(vo.getPwd()))
		{			
			session.update("boardUpdate",vo);
			session.commit();
			result="yes";
		}
		session.close();
		return result;
	}
}
