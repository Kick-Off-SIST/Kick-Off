package com.sist.vo;
import java.util.*;

import lombok.Data;
@Data
public class MatchVO {
	private int schedule_id,stadium_id,home_goal,away_goal,count;
	private String game_time,home_team_id,away_team_id,game_status,dbday;
	private Date game_date;
	private TeamVO homeVo=new TeamVO();
	private TeamVO awayVo=new TeamVO();
	private StadiumVO svo=new StadiumVO();
}
