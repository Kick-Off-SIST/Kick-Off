package com.sist.vo;

import lombok.Data;
/*
SEAT_ID    NOT NULL NUMBER       
SEAT_ROW   NOT NULL VARCHAR2(50) 
SEAT_COL   NOT NULL NUMBER       
STADIUM_ID NOT NULL NUMBER       
AMOUNT     NOT NULL NUMBER
 */
@Data
public class StadiumSeatVO {
	private int seat_id,seat_col,stadium_id,grade_id;
	private String seat_row;
	private StadiumVO svo=new StadiumVO();
	private SeatGradeVO gvo=new SeatGradeVO();
}
