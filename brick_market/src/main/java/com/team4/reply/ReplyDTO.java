package com.team4.reply;

import java.sql.Date;

public class ReplyDTO {
	private int reply_idx;
	private int reply_bbs_idx;
	private int reply_write_idx;
	private String reply_content;
	private java.sql.Date reply_date;
	private int reply_ref;
	private int reply_lev;
	private int reply_sunbun;
	private String reply_date_s;
	private String member_nick;
	
	private String member_img;

	public ReplyDTO() {
		// TODO Auto-generated constructor stub
	}

	public ReplyDTO(int reply_idx, int reply_bbs_idx, int reply_write_idx, String reply_content, Date reply_date,
			int reply_ref, int reply_lev, int reply_sunbun, String reply_date_s) {
		super();
		this.reply_idx = reply_idx;
		this.reply_bbs_idx = reply_bbs_idx;
		this.reply_write_idx = reply_write_idx;
		this.reply_content = reply_content;
		this.reply_date = reply_date;
		this.reply_ref = reply_ref;
		this.reply_lev = reply_lev;
		this.reply_sunbun = reply_sunbun;
		this.reply_date_s = reply_date_s;
	}
	
	public ReplyDTO(int reply_idx, int reply_bbs_idx, int reply_write_idx, String reply_content, Date reply_date,
			int reply_ref, int reply_lev, int reply_sunbun, String reply_date_s, String member_nick,
			String member_img) {
		super();
		this.reply_idx = reply_idx;
		this.reply_bbs_idx = reply_bbs_idx;
		this.reply_write_idx = reply_write_idx;
		this.reply_content = reply_content;
		this.reply_date = reply_date;
		this.reply_ref = reply_ref;
		this.reply_lev = reply_lev;
		this.reply_sunbun = reply_sunbun;
		this.reply_date_s = reply_date_s;
		this.member_nick = member_nick;
		this.member_img = member_img;
	}

	public String getMember_nick() {
		return member_nick;
	}

	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}

	public String getMember_img() {
		return member_img;
	}

	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}

	public String getReply_date_s() {
		return reply_date_s;
	}

	public void setReply_date_s(String reply_date_s) {
		this.reply_date_s = reply_date_s;
	}

	public int getReply_idx() {
		return reply_idx;
	}

	public void setReply_idx(int reply_idx) {
		this.reply_idx = reply_idx;
	}

	public int getReply_bbs_idx() {
		return reply_bbs_idx;
	}

	public void setReply_bbs_idx(int reply_bbs_idx) {
		this.reply_bbs_idx = reply_bbs_idx;
	}

	public int getReply_write_idx() {
		return reply_write_idx;
	}

	public void setReply_write_idx(int reply_write_idx) {
		this.reply_write_idx = reply_write_idx;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public java.sql.Date getReply_date() {
		return reply_date;
	}

	public void setReply_date(java.sql.Date reply_date) {
		this.reply_date = reply_date;
	}

	public int getReply_ref() {
		return reply_ref;
	}

	public void setReply_ref(int reply_ref) {
		this.reply_ref = reply_ref;
	}

	public int getReply_lev() {
		return reply_lev;
	}

	public void setReply_lev(int reply_lev) {
		this.reply_lev = reply_lev;
	}

	public int getReply_sunbun() {
		return reply_sunbun;
	}

	public void setReply_sunbun(int reply_sunbun) {
		this.reply_sunbun = reply_sunbun;
	}
}
