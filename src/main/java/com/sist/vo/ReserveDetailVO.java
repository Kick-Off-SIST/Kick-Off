package com.sist.vo;
/*
RESERVE_DETAIL_ID NOT NULL NUMBER 
SEAT_COUNT                 NUMBER 
RESERVE_ID                 NUMBER 
MATCH_SEAT_ID              NUMBER
 */

import lombok.Data;

@Data
public class ReserveDetailVO {
	private int reserve_detail_id,reserve_id,match_seat_id,seat_col,amount;
	private String seat_row,grade_name,isexpired;
	private ReserveVO rvo=new ReserveVO();
}
