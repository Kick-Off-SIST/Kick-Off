package com.sist.service;
import java.util.*;
import com.sist.vo.MemberVO;
public interface MemberService {
	public List<MemberVO> memberListData(int start);
	public int memberTotalPage();
	public MemberVO isLogin(String id,String pwd);
	public void memberInsert(MemberVO vo);
	public void memberUpdate(MemberVO vo);
	public void memberDisable(MemberVO vo);
	public int memberIdCount(String id);
}
