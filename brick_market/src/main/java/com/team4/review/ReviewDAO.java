package com.team4.review;

import java.sql.*;

public class ReviewDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	/**리뷰쓰기 메서드*/
	public int reviewWrite(ReviewDTO dto) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql="insert into review_table values(review_table_idx.nextval,?,?,?,?,sysdate)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getReview_rate());
			ps.setString(2, dto.getReview_content());
			ps.setInt(3, dto.getReview_writer_idx());
			ps.setInt(4, dto.getReview_bbs_idx());
			
			int count=ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}
}
