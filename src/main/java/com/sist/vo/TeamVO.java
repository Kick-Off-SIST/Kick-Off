package com.sist.vo;

import lombok.Data;

//TEAM_ID    NOT NULL VARCHAR2(10)  
//TEAM_NAME  NOT NULL VARCHAR2(50)  
//STADIUM_ID NOT NULL NUMBER        
//EMBLEM              VARCHAR2(500) 
@Data
public class TeamVO {
	private int stadium_id;
	private String team_id,team_name,emblem;
	private StadiumVO svo=new StadiumVO();
}
