package com.sist.vo;

import java.util.Date;

import lombok.Data;

/*
RESERVE_ID   NOT NULL NUMBER       
RESERVE_TIME          DATE         
TOTAL_AMOUNT          NUMBER       
MEMBER_ID             VARCHAR2(20)
 */
@Data
public class ReserveVO {
	private int reserve_id,total_amount,schedule_id;
	private String member_id,dbday;
	private Date reserve_time;
	private MemberVO mvo=new MemberVO();
	private MatchVO mmvo=new MatchVO();
}
