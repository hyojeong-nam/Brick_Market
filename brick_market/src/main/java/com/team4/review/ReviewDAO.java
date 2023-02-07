package com.team4.review;

import java.sql.*;
import java.sql.Date;
import java.util.*;

public class ReviewDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	/**리뷰쓰기 메서드*/
	public int reviewWrite(ReviewDTO dto) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql="insert into review_table values(review_table_idx.nextval,?,?,?,?,?,sysdate)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, dto.getReview_rate());
			ps.setString(2, dto.getReview_content());
			ps.setInt(3, dto.getReview_writer_idx());
			ps.setInt(4, dto.getReview_bbs_idx());
			ps.setInt(5, dto.getReview_seller_idx());
			
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
	
	/**리뷰 조회 관련 매서드*/
	public ArrayList<ReviewDTO> selectReview(int review_seller_idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from review_table where review_seller_idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, review_seller_idx);
			rs = ps.executeQuery();
			ArrayList<ReviewDTO> arr = new ArrayList<ReviewDTO>();
			while(rs.next()) {
				int review_idx = rs.getInt("review_idx");
				int review_rate = rs.getInt("review_rate");
				String review_content = rs.getString("review_content");
				int review_bbs_idx = rs.getInt("review_bbs_idx");
				int review_writer_idx = rs.getInt("review_writer_idx");
				Date review_date = rs.getDate("review_date");
				ReviewDTO dto = new ReviewDTO(review_idx, review_rate, review_content, review_writer_idx, review_bbs_idx,review_seller_idx, review_date);
				arr.add(dto);
			}
			return arr;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}
	
}
