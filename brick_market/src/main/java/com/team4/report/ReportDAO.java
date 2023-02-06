package com.team4.report;

import java.sql.*;
import com.team4.member.*;
import com.oreilly.servlet.*;

public class ReportDAO {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	/**신고 등록 메서드
	 * @param report_idx 신고 받은 유저 인덱스
	 * @param midx 현재 접속 중이며 신고한 유저 인덱스
	 * @param content 신고 내용
	 * @return 1이면 정상 등록, -1이면 등록 실패
	 * */
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
