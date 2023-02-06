package com.team4.report;

import java.sql.*;
import com.team4.member.*;
import com.oreilly.servlet.*;

public class ReportDAO {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	// 신고 등록
	public int addReport(int report_idx,int midx,String content) {
		try {
			conn=com.team4.db.Team4DB.getConn();
			String sql="insert into report_table values (report_table_idx.nextval,?,?,sysdate,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, report_idx);
			ps.setInt(2, midx);
			ps.setString(3, content);
			
			int count=ps.executeUpdate();
			return count;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

	}
}
