package com.sist.dao;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import java.util.*;
import java.io.*;
import com.sist.vo.*;
import com.sist.commons.CreateSqlSessionFactory;
import com.sist.dao.*;
public class GoodsDAO {
	private static SqlSessionFactory ssf;
	 
	   static 
	   {
		   ssf=CreateSqlSessionFactory.getSsf();
	   }
	
	public static List<GoodsVO> goodsListData(int start)
	{
		SqlSession session=ssf.openSession();
		List<GoodsVO> list=session.selectList("goodsListData", start);
		session.close();
		return list;
	}
	public static int goodsTotalPage()
	{
		SqlSession session=ssf.openSession();
		int total=session.selectOne("goodsTotalPage");
		session.close();
		return total;
	}
	/*
	 * <select id="teamListData" resultType="TeamVO">
	    SELECT team_id, team_name,emblem
	    FROM kleague_team
	    ORDER BY team_name
	  </select>
	 */
	public static List<TeamVO> goodsteamListData()
	{
		SqlSession session=ssf.openSession();
		List<TeamVO> list=session.selectList("goodsteamListData");
		session.close();
		return list;
	}
	public static GoodsVO goodsDetailData(int no)
	{
		SqlSession session=ssf.openSession();
		GoodsVO vo=session.selectOne("goodsDetailData",no);
		session.close();
		return vo;
	}
	
	public static List<GoodsVO> goodsFindListData(Map map)
	{
		SqlSession session=ssf.openSession();
		List<GoodsVO> list=session.selectList("goodsFindListData", map);
		session.close();
		return list;
	}
	
	public static int goodsFindTotalPage(Map map)
	{
		SqlSession session=ssf.openSession();
		int total=session.selectOne("goodsFindTotalPage",map);
		session.close();
		return total;
	}
}
