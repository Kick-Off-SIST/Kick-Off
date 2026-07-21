package com.sist.vo;
/*
 *  NO       NOT NULL NUMBER         
	LOGIN_ID NOT NULL VARCHAR2(50)   
	TITLE    NOT NULL VARCHAR2(2000) 
	CONTENT  NOT NULL CLOB           
	HIT               NUMBER         
	GROUP_ID          NUMBER         
	STEP              NUMBER         
	INDENT            NUMBER         
	REGDATE           DATE   
 */
import java.util.*;
import lombok.Data;

@Data
public class QnaVO {
	private int no,hit,group_id,step,indent,state;
	private String login_id,title,content,pwd,dbday;
	private Date regdate;
}
