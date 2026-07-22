package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.*;
import com.sist.vo.*;
public class QnaDAO {
	private static SqlSessionFactory ssf;
	static
	{
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	/*
	 * <select id="qnaListData" resultType="QnaVO" parameterType="int">
	    SELECT no,title,content,login_id,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,
	    hit,state
	    FROM QNA
	    WHERE step=0
	    ORDER BY no DESC , step ASC
	    OFFSET#{start} ROWS FETCH NEXT 10 ROWS ONLY
	  </select>
	 */
	public static List<QnaVO> qnaListData(int start)
	{
		SqlSession session=ssf.openSession();
		List<QnaVO> list=session.selectList("qnaListData",start);
		session.close();
		return list;
	}
	/*
	  <select id="qnaTotalPage" resultType="int">
	    SELECT CEIL(COUNT(*)/10.0)
	    FROM QNA
	    WHERE step=0
	  </select>
	 */
	public static int qnaTotalPage()
	{
		SqlSession session=ssf.openSession();
		int total=session.selectOne("qnaTotalPage");
		session.close();
		return total;
	}
	public static int qnaTotalCount()
	{
		SqlSession session=ssf.openSession();
		int total=session.selectOne("qnaTotalCount");
		session.close();
		return total;
	}
	public static void qnaInsert(QnaVO vo)
	{
		SqlSession session=ssf.openSession(true);
		session.insert("qnaInsert",vo);  
		session.close();		
	}
	public static QnaVO qnaDetailData(int no)
	{
		SqlSession session=ssf.openSession(true);
		session.update("qnahitIncrement",no);
		QnaVO vo=session.selectOne("qnaDetailData",no);
		session.close();
		return vo;
	}
	public static String qnaDelete(int no,String pwd)
	{	
		String result="no";		
		SqlSession session=ssf.openSession();		
		String db_pwd=session.selectOne("qnaGetPassword",no);
		if(db_pwd.equals(pwd))
		{			
			session.delete("qnaDelete",no);
			session.commit();
			result="yes";
		}
		session.close();
		return result;
	}
	public static QnaVO qnaUpdateData(int no)
	{
		SqlSession session=ssf.openSession();
		QnaVO vo=session.selectOne("qnaDetailData",no);
		session.close();
		return vo;
	}
	public static String qnaUpdate(QnaVO vo)
	{
		String result="no";		
		SqlSession session=ssf.openSession();		
		String db_pwd=session.selectOne("qnaGetPassword",vo.getNo());
		if(db_pwd.equals(vo.getPwd()))
		{			
			session.update("qnaUpdate",vo);
			session.commit();
			result="yes";
		}
		session.close();
		return result;
	}
	public static void qnaReply(QnaVO vo)
	{
		SqlSession session=ssf.openSession(true);
		session.insert("qnaReply",vo);
		session.close();
	}
	public static QnaVO qnaReplyData(int group_id)
	{
		SqlSession session=ssf.openSession();
		QnaVO vo=session.selectOne("qnaReplyData", group_id);
		session.close();
		return vo;				
	}
	public static void qnaStateUpdate(int no)
	{
		SqlSession session=ssf.openSession(true);
		session.update("qnaStateUpdate",no);
		session.close();
	}
}
