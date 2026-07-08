package com.sist.vo;
//PLAYER_ID   NOT NULL NUMBER        
//TEAM_ID     NOT NULL VARCHAR2(10)  
//NAME        NOT NULL VARCHAR2(50)  
//NAME_ENG             VARCHAR2(100) 
//POSITION             VARCHAR2(30)  
//NATIONALITY          VARCHAR2(50)  
//HEIGHT               NUMBER(3)     
//WEIGHT               NUMBER(3)     
//BIRTH_DATE           DATE          
//BACK_NUMBER          NUMBER        
//IMG_URL              VARCHAR2(500) 
import java.util.*;

import lombok.Data;
@Data
public class PlayerVO {
	private int player_id,height,weight,back_number,likecount;
	private String team_id,name,name_eng,position,nationality,img_url,dbday;
	private Date birth_date;
	private TeamVO tvo=new TeamVO();
}
