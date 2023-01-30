package com.team4.reply;

import java.util.*;
import java.sql.*;
public class ReplyDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	/**댓글조회*/
	public ArrayList<ReplyDTO> replyList(int bbs_idx){
		try {
			conn=com.team4.db.Team4DB.getConn();
			String sql="select * from reply_table where reply_bbs_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			rs=ps.executeQuery();
			ArrayList<ReplyDTO> arr=new ArrayList<ReplyDTO>();
			while (rs.next()) {
				int reply_idx= rs.getInt("reply_idx");
				int reply_bbs_idx=rs.getInt("reply_bbs_idx");
				int reply_write_idx=rs.getInt("reply_write_idx");
				String reply_content=rs.getString("reply_content");
				java.sql.Date reply_date=rs.getDate("reply_date");
				int reply_ref= rs.getInt("reply_ref");
				int reply_lev= rs.getInt("reply_lev");
				int reply_sunbun= rs.getInt("reply_sunbun");
				String reply_date_s=rs.getString("reply_date");
				ReplyDTO dto=new ReplyDTO(reply_idx, reply_bbs_idx, reply_write_idx, reply_content, reply_date, reply_ref, reply_lev, reply_sunbun, reply_date_s);
				arr.add(dto);
			}
			return arr;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
			// TODO: handle exception
		}finally {
			try {
				
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	public int replyWrite(int bbs_idx,int write_idx,String reply_content) {
		try {
			conn=com.team4.db.Team4DB.getConn();
			String sql="insert into reply_table values (reply_table_idx.nextval,?,?,?,sysdate,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			ps.setInt(2, write_idx);
			ps.setString(3, reply_content);
			ps.setInt(4, 0);
			ps.setInt(5, 0);
			ps.setInt(6, 0);
			return ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return-1;
		}finally {
			try {
				
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	
}
