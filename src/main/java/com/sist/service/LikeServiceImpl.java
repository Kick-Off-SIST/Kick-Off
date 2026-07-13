package com.sist.service;

import com.sist.dao.LikeDAO;
import com.sist.vo.LikeVO;

public class LikeServiceImpl implements LikeService {
	private LikeDAO dao=new LikeDAO();
	@Override
	public int likeCount(LikeVO vo) {
		return dao.likeCount(vo);
	}

	@Override
	public void likeOn(LikeVO vo) {
		dao.likeOn(vo);
	}

	@Override
	public void likeOff(LikeVO vo) {
		dao.likeOff(vo);
	}

	@Override
	public int isLiked(LikeVO vo) {
		return dao.isLiked(vo);
	}

}
