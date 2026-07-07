package com.sist.commons;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import lombok.Getter;

import java.io.*;
public class CreateSqlSessionFactory {
	@Getter
	private static SqlSessionFactory ssf;
	static {
		try {
		Reader reader=Resources.getResourceAsReader("config.xml");
		ssf=new SqlSessionFactoryBuilder().build(reader);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}
