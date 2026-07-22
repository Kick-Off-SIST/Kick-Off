package com.sist.vo;

import java.util.*;
import lombok.Data;
/*
ORDERS_ID   NOT NULL NUMBER 
MEMBER_ID            NUMBER 
TOTAL_PRICE          NUMBER 
ORDERS_DATE          DATE
 */
@Data
public class OrderVO {
	private int orders_id,member_id,total_price;
	private String dbday;
	private Date orders_date;
	private MemberVO mvo=new MemberVO();
}
