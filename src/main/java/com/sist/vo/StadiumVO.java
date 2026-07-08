package com.sist.vo;

import lombok.Data;

//STADIUM_ID          NOT NULL NUMBER        
//NAME                NOT NULL VARCHAR2(100) 
//ADDRESS             NOT NULL VARCHAR2(255) 
//LATITUDE                     NUMBER(10,7)  
//LONGITUDE                    NUMBER(10,7)  
//CAPACITY                     NUMBER(10)    
//TICKET_POLICY_IMAGE          VARCHAR2(500) 
@Data
public class StadiumVO {
	private int stadium_id,capacity;
	private double latitude,longitude;
	private String name,address,ticket_policy_image;
}
