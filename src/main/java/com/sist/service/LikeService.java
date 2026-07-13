package com.sist.service;

import com.sist.vo.LikeVO;

public interface LikeService {
	public int likeCount(LikeVO vo);
	public void likeOn(LikeVO vo);
	public void likeOff(LikeVO vo);
	public int isLiked(LikeVO vo);
}
