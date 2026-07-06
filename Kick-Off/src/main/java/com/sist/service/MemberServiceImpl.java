package com.sist.service;

import java.util.*;

import com.sist.dao.MemberDAO;
import com.sist.vo.MemberVO;

public class MemberServiceImpl implements MemberService {
	private MemberDAO dao=new MemberDAO();
	@Override
	public List<MemberVO> memberListData(int start) {
		// TODO Auto-generated method stub
		return dao.memberListData(start);
	}

	@Override
	public int memberTotalPage() {
		// TODO Auto-generated method stub
		return dao.memberTotalPage();
	}

	@Override
	public MemberVO isLogin(String id, String pwd) {
		// TODO Auto-generated method stub
		return dao.isLogin(id, pwd);
	}

	@Override
	public void memberInsert(MemberVO vo) {
		// TODO Auto-generated method stub
		dao.memberInsert(vo);
	}

	@Override
	public void memberUpdate(MemberVO vo) {
		// TODO Auto-generated method stub
		dao.memberUpdate(vo);
	}

	@Override
	public void memberDisable(MemberVO vo) {
		// TODO Auto-generated method stub
		dao.memberDisable(vo);
	}

}
