package com.team4.like;

public class LikeDTO {
private int like_idx;
private int like_bbs_idx;
private int like_user_idx;
private int like_check;
public LikeDTO() {
	// TODO Auto-generated constructor stub
}
public LikeDTO(int like_idx, int like_bbs_idx, int like_user_idx, int like_check) {
	super();
	this.like_idx = like_idx;
	this.like_bbs_idx = like_bbs_idx;
	this.like_user_idx = like_user_idx;
	this.like_check = like_check;
}
public int getLike_idx() {
	return like_idx;
}
public void setLike_idx(int like_idx) {
	this.like_idx = like_idx;
}
public int getLike_bbs_idx() {
	return like_bbs_idx;
}
public void setLike_bbs_idx(int like_bbs_idx) {
	this.like_bbs_idx = like_bbs_idx;
}
public int getLike_user_idx() {
	return like_user_idx;
}
public void setLike_user_idx(int like_user_idx) {
	this.like_user_idx = like_user_idx;
}
public int getLike_check() {
	return like_check;
}
public void setLike_check(int like_check) {
	this.like_check = like_check;
}

}
