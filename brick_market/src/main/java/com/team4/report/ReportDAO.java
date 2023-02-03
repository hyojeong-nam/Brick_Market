package com.team4.report;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import javax.naming.*;

public class ReportDAO {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	// 신고 등록
	public int addReport(ReportDTO dto,int report_idx) {
		try {
			conn=com.team4.db.Team4DB.getConn();
			String sql="";
			ps=conn.prepareStatement(sql);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {

			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}
}
