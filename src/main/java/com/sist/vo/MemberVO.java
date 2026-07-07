package com.sist.vo;
//MEMBER_ID NOT NULL NUMBER        
//LOGIN_ID  NOT NULL VARCHAR2(50)  
//PWD       NOT NULL VARCHAR2(100) 
//NAME      NOT NULL VARCHAR2(50)  
//EMAIL     NOT NULL VARCHAR2(100) 
//PHONE     NOT NULL VARCHAR2(20)  
//ISADMIN   NOT NULL VARCHAR2(1)   
//REGDATE            DATE    
import java.util.*;

import lombok.Data;
@Data
public class MemberVO {
	private int member_id;
	private String login_id,pwd,name,sex,birthday,email,post,addr1,addr2,content,phone,isAdmin,status,dbday,msg;
	private Date regdate;
}
