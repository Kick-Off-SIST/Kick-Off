package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import java.util.*;
import com.sist.commons.*;
import com.sist.vo.*;
public class ReplyDAO {
	private static SqlSessionFactory ssf;
	static 
	{
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	public static List<ReplyVO> replyListData(int bno)
	{
		SqlSession session=ssf.openSession();
		   List<ReplyVO> list=session.selectList("replyListData",bno);
		   session.close();
		   return list;
	}
	public static void replyInsert(ReplyVO vo)
	   {
		   SqlSession session=ssf.openSession(true);
		   session.insert("replyInsert",vo);
		   session.close();
	   }
	public static void replyUpdate(Map map)
	   {
		   SqlSession session=ssf.openSession(true);// autoCommit
		   session.update("replyUpdate",map);
		   session.close();
	   }
	public static void replyDelete(int no)
	   {
		   SqlSession session=ssf.openSession(true);// autoCommit
		   session.delete("replyDelete",no);
		   session.close();
	   }
}
