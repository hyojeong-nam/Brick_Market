package com.team4.member;

import java.sql.Date;

public class MemberDTO {
	private int member_idx;
	private String member_id;
	private String member_pwd;
	private String member_name;
	private String member_nick;
	private String member_email;
	private Date member_date;
	private String member_img;
	private int member_class;
	public MemberDTO() {
		super();
	}
	public MemberDTO(int member_idx, String member_id, String member_pwd, String member_name, String member_nick,
			String member_email, Date member_date, String member_img, int member_class) {
		super();
		this.member_idx = member_idx;
		this.member_id = member_id;
		this.member_pwd = member_pwd;
		this.member_name = member_name;
		this.member_nick = member_nick;
		this.member_email = member_email;
		this.member_date = member_date;
		this.member_img = member_img;
		this.member_class = member_class;
	}
	public int getMember_idx() {
		return member_idx;
	}
	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pwd() {
		return member_pwd;
	}
	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public Date getMember_date() {
		return member_date;
	}
	public void setMember_date(Date member_date) {
		this.member_date = member_date;
	}
	public String getMember_img() {
		return member_img;
	}
	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}
	public int getMember_class() {
		return member_class;
	}
	public void setMember_class(int member_class) {
		this.member_class = member_class;
	}
	
	
}
