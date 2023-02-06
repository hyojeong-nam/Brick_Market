package com.team4.review;

import java.sql.Date;

public class ReviewDTO {
	
	private int review_idx;
	private int review_rate;
	private String review_content;
	private int review_writer_idx;
	private int review_bbs_idx;
	private Date reivew_date;
	
	public ReviewDTO() {
		super();
	}

	public ReviewDTO(int review_idx, int review_rate, String review_content, int review_writer_idx, int review_bbs_idx,
			Date reivew_date) {
		super();
		this.review_idx = review_idx;
		this.review_rate = review_rate;
		this.review_content = review_content;
		this.review_writer_idx = review_writer_idx;
		this.review_bbs_idx = review_bbs_idx;
		this.reivew_date = reivew_date;
	}

	public int getReview_idx() {
		return review_idx;
	}

	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}

	public int getReview_rate() {
		return review_rate;
	}

	public void setReview_rate(int review_rate) {
		this.review_rate = review_rate;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public int getReview_writer_idx() {
		return review_writer_idx;
	}

	public void setReview_writer_idx(int review_writer_idx) {
		this.review_writer_idx = review_writer_idx;
	}

	public int getReview_bbs_idx() {
		return review_bbs_idx;
	}

	public void setReview_bbs_idx(int review_bbs_idx) {
		this.review_bbs_idx = review_bbs_idx;
	}

	public Date getReivew_date() {
		return reivew_date;
	}

	public void setReivew_date(Date reivew_date) {
		this.reivew_date = reivew_date;
	}
	
	
	

}
