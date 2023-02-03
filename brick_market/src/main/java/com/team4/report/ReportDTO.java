package com.team4.report;

import java.sql.Date;

public class ReportDTO {
	
	private int report_idx;
	private int report_get_user_idx;
	private int report_send_user_idx;
	private Date report_date;
	private String report_content;
	
	public ReportDTO() {
		super();
	}

	public ReportDTO(int report_idx, int report_get_user_idx, int report_send_user_idx, Date report_date,
			String report_content) {
		super();
		this.report_idx = report_idx;
		this.report_get_user_idx = report_get_user_idx;
		this.report_send_user_idx = report_send_user_idx;
		this.report_date = report_date;
		this.report_content = report_content;
	}

	public int getReport_idx() {
		return report_idx;
	}

	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}

	public int getReport_get_user_idx() {
		return report_get_user_idx;
	}

	public void setReport_get_user_idx(int report_get_user_idx) {
		this.report_get_user_idx = report_get_user_idx;
	}

	public int getReport_send_user_idx() {
		return report_send_user_idx;
	}

	public void setReport_send_user_idx(int report_send_user_idx) {
		this.report_send_user_idx = report_send_user_idx;
	}

	public Date getReport_date() {
		return report_date;
	}

	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}

	public String getReport_content() {
		return report_content;
	}

	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}

	
	
}



