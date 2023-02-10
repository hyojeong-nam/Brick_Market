package com.team4.reply;

import java.util.*;
import java.sql.*;

public class ReplyDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	/** 
	 * 댓글조회 
	 * @param 게시글idx
	 * @param 보여줄 게시글수
	 * @param 유저 위치
	 * @return ArrList<ReplyDTO> 댓글
	 * */
	public ArrayList<ReplyDTO> replyList(int bbs_idx ,int ls ,int cp) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			int start = (cp - 1) * ls + 1;
			int end = cp * ls;
			String sql = "select * from (select rownum as rnum, a.* from (select * from reply_table where reply_bbs_idx=? and reply_lev=0 order by reply_ref desc)a)b where rnum >= ? and rnum <= ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			ArrayList<ReplyDTO> arr = new ArrayList<ReplyDTO>();
			while (rs.next()) {
				int reply_idx = rs.getInt("reply_idx");
				int reply_bbs_idx = rs.getInt("reply_bbs_idx");
				int reply_write_idx = rs.getInt("reply_write_idx");
				String reply_content = rs.getString("reply_content");
				java.sql.Date reply_date = rs.getDate("reply_date");
				int reply_ref = rs.getInt("reply_ref");
				int reply_lev = rs.getInt("reply_lev");
				int reply_sunbun = rs.getInt("reply_sunbun");
				String reply_date_s = rs.getString("reply_date");
				ReplyDTO dto = new ReplyDTO(reply_idx, reply_bbs_idx, reply_write_idx, reply_content, reply_date,
						reply_ref, reply_lev, reply_sunbun, reply_date_s);
				arr.add(dto);
			}
			return arr;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
			// TODO: handle exception
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();

			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
		/**
		 * @return  댓글 테이플의 ref max수치
		 * */

	public int getMaxRef() {
		try {
			String sql = "select max(reply_ref) from reply_table";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			int max = 0;
			if (rs.next()) {
				max = rs.getInt(1);
			}
			return max;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	/**
	 * @param 댓글의 ref값
	 * @return 해당 댓글의 sunbun최대값*/
	public int getMaxSunbun(int ref) {
		try {
			String sql="select max(reply_sunbun) from reply_table where reply_ref=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, ref);
			rs=ps.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
			
		}finally {
		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
		} catch (Exception e2) {
			// TODO: handle exception
		}
		}
	}
	/**
	 * @param 게시글 idx
	 * @param 게시자 idx
	 * @param 댓글내용
	 * @param 본댓글인지 여부
	 * @param 본댓글인지 여부
	 * @return 성공여부
	 * */
	public int replyWrite(int bbs_idx, int write_idx, String reply_content,int lev,int ref) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			int maxref=getMaxRef();
			int maxsunbun=0;
			if(lev==0) {
				maxref++;
			}else {
				maxref=ref;
				maxsunbun=getMaxSunbun(ref)+1;
			}
			
			String sql = "insert into reply_table values (reply_table_idx.nextval,?,?,?,sysdate,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			ps.setInt(2, write_idx);
			ps.setString(3, reply_content);
			ps.setInt(4, maxref);
			ps.setInt(5, lev);
			ps.setInt(6, maxsunbun);
			return ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		} finally {
			try {

				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();

			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}

	/**
	 * @param 게시글 idx
	 * @return 게시글의 본댓글수
	 * */
	public int totalRef(int bbs_idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select count(*) from reply_table where reply_lev=0 and reply_bbs_idx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();

			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	/**
	 * @param 변경할 댓글내용 
	 * @param  변경할 댓글의 idx
	 * @return 성공여부
	 * */
	public int updateReply(String content,int idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql="update reply_table set reply_content =? where reply_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, content);
			ps.setInt(2, idx);
			return ps.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return-1;
		}finally {
			try {
				
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
				
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	/**
	 * @param 해당 본댓글의 ref값
	 * @param 게시글idx
	 * */
	public int dedleteReply(int ref, int bbs_idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql="delete from reply_table where reply_ref=? and reply_bbs_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, ref);
			ps.setInt(2, bbs_idx);
			return ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
			
		}finally {
			try {
				
				
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	/** 대댓글조회
	 * @param 게시글 idx
	 * @param 본댓글의 위치
	 * @return 대댓내용
	 *  */
	public ArrayList<ReplyDTO> rereplyList(int bbs_idx,int ref) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from reply_table ,member_table where reply_table.reply_write_idx=member_table.member_idx and "
					+ "reply_bbs_idx=? and reply_ref=? and reply_lev=1 order by reply_sunbun asc";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			ps.setInt(2, ref);
			rs = ps.executeQuery();
			ArrayList<ReplyDTO> arr = new ArrayList<ReplyDTO>();
			while (rs.next()) {
				int reply_idx = rs.getInt("reply_idx");
				int reply_bbs_idx = rs.getInt("reply_bbs_idx");
				int reply_write_idx = rs.getInt("reply_write_idx");
				String reply_content = rs.getString("reply_content");
				java.sql.Date reply_date = rs.getDate("reply_date");
				int reply_ref = rs.getInt("reply_ref");
				int reply_lev = rs.getInt("reply_lev");
				int reply_sunbun = rs.getInt("reply_sunbun");
				String reply_date_s = rs.getString("reply_date");
				String member_nick=rs.getString("member_nick");
				String member_img=rs.getString("member_img");
				ReplyDTO dto = new ReplyDTO(reply_idx, reply_bbs_idx, reply_write_idx, reply_content, reply_date,
						reply_ref, reply_lev, reply_sunbun, reply_date_s,member_nick,member_img);
				arr.add(dto);
			}
			return arr;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
			// TODO: handle exception
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();

			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}


}
