package com.team4.bbs;
import java.sql.*;

public class BbsDTO {
	
	private int bbs_idx;
	private String bbs_subject;
	private String bbs_content;
	private int bbs_price;
	private String bbs_img;
	private Date bbs_date;
	private int bbs_readnum;
	private int bbs_writer_idx;
	private int bbs_category;
	private int bbs_status;
	private String bbs_place;
	private int bbs_how;
	private String bbs_date_s;
	public BbsDTO() {
		super();
	}
	public BbsDTO(int bbs_idx, String bbs_subject, String bbs_content, int bbs_price, String bbs_img, Date bbs_date,
			int bbs_readnum, int bbs_writer_idx, int bbs_category, int bbs_status, String bbs_place, int bbs_how) {
		super();
		this.bbs_idx = bbs_idx;
		this.bbs_subject = bbs_subject;
		this.bbs_content = bbs_content;
		this.bbs_price = bbs_price;
		this.bbs_img = bbs_img;
		this.bbs_date = bbs_date;
		this.bbs_readnum = bbs_readnum;
		this.bbs_writer_idx = bbs_writer_idx;
		this.bbs_category = bbs_category;
		this.bbs_status = bbs_status;
		this.bbs_place = bbs_place;
		this.bbs_how = bbs_how;
	}
	public BbsDTO(int bbs_idx, String bbs_subject, String bbs_content, int bbs_price, String bbs_img, Date bbs_date,
			int bbs_readnum, int bbs_writer_idx, int bbs_category, int bbs_status, String bbs_place, int bbs_how,
			String bbs_date_s) {
		super();
		this.bbs_idx = bbs_idx;
		this.bbs_subject = bbs_subject;
		this.bbs_content = bbs_content;
		this.bbs_price = bbs_price;
		this.bbs_img = bbs_img;
		this.bbs_date = bbs_date;
		this.bbs_readnum = bbs_readnum;
		this.bbs_writer_idx = bbs_writer_idx;
		this.bbs_category = bbs_category;
		this.bbs_status = bbs_status;
		this.bbs_place = bbs_place;
		this.bbs_how = bbs_how;
		this.bbs_date_s = bbs_date_s;
	}
	public String getBbs_date_s() {
		return bbs_date_s;
	}
	public void setBbs_date_s(String bbs_date_s) {
		this.bbs_date_s = bbs_date_s;
	}
	public int getBbs_idx() {
		return bbs_idx;
	}
	public void setBbs_idx(int bbs_idx) {
		this.bbs_idx = bbs_idx;
	}
	public String getBbs_subject() {
		return bbs_subject;
	}
	public void setBbs_subject(String bbs_subject) {
		this.bbs_subject = bbs_subject;
	}
	public String getBbs_content() {
		return bbs_content;
	}
	public void setBbs_content(String bbs_content) {
		this.bbs_content = bbs_content;
	}
	public int getBbs_price() {
		return bbs_price;
	}
	public void setBbs_price(int bbs_price) {
		this.bbs_price = bbs_price;
	}
	public String getBbs_img() {
		return bbs_img;
	}
	public void setBbs_img(String bbs_img) {
		this.bbs_img = bbs_img;
	}
	public Date getBbs_date() {
		return bbs_date;
	}
	public void setBbs_date(Date bbs_date) {
		this.bbs_date = bbs_date;
	}
	public int getBbs_readnum() {
		return bbs_readnum;
	}
	public void setBbs_readnum(int bbs_readnum) {
		this.bbs_readnum = bbs_readnum;
	}
	public int getBbs_writer_idx() {
		return bbs_writer_idx;
	}
	public void setBbs_writer_idx(int bbs_writer_idx) {
		this.bbs_writer_idx = bbs_writer_idx;
	}
	public int getBbs_category() {
		return bbs_category;
	}
	public void setBbs_category(int bbs_category) {
		this.bbs_category = bbs_category;
	}
	public int getBbs_status() {
		return bbs_status;
	}
	public void setBbs_status(int bbs_status) {
		this.bbs_status = bbs_status;
	}
	public String getBbs_place() {
		return bbs_place;
	}
	public void setBbs_place(String bbs_place) {
		this.bbs_place = bbs_place;
	}
	public int getBbs_how() {
		return bbs_how;
	}
	public void setBbs_how(int bbs_how) {
		this.bbs_how = bbs_how;
	}
	
	
}
