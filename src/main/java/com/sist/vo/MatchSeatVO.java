package com.sist.vo;

import lombok.Data;
import com.sist.vo.*;

/*
MATCH_SEAT_ID NOT NULL NUMBER       
SEAT_STATUS            VARCHAR2(10) 
SCHEDULE_ID            NUMBER       
SEAT_ID                NUMBER
 */
@Data
public class MatchSeatVO {
	private int match_seat_id,schedule_id,seat_id,remain;
	private String seat_status;
	private MatchVO mvo=new MatchVO();
	private StadiumSeatVO svo=new StadiumSeatVO();
}
