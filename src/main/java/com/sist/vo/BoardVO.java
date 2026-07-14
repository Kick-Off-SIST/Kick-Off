package com.sist.vo;
import java.util.*;

import lombok.Data;
@Data
public class BoardVO {
	private int no,hit ,member_id,replycount;
	private String title,content,pwd,dbday, loginId;
	private Date regdate;
}
