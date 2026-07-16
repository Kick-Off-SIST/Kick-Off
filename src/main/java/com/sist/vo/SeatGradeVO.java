package com.sist.vo;

import lombok.Data;

/*
GRADE_ID   NOT NULL NUMBER        
GRADE_NAME NOT NULL VARCHAR2(100) 
AMOUNT     NOT NULL NUMBER        
STADIUM_ID          NUMBER
 */
@Data
public class SeatGradeVO {
	private int grade_id,amount,stadium_id,totalseat,max_row,max_col;
	private String grade_name;
}
