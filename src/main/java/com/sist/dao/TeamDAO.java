package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.*;
import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.TeamVO;

public class TeamDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	public List<TeamVO> teamEmblemData(){
		SqlSession session=ssf.openSession();
		List<TeamVO> list=session.selectList("teamEmblemData");
		session.close();
		return list;
	}
}
