package com.sist.vo;
/*
 * NO      NOT NULL NUMBER         
	NAME             VARCHAR2(51)   
	TITLE   NOT NULL VARCHAR2(2000) 
	CONTENT NOT NULL CLOB           
	TYPE    NOT NULL VARCHAR2(10)   
	REGDATE          DATE           
	HIT              NUMBER   
 */
import java.util.*;

import lombok.Data;
@Data
public class NoticeVO {
	private int no,hit,type;
	private String name,title,content,dbday;
	private Date regdate;
}
