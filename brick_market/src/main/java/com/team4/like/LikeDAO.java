package com.team4.like;

import java.sql.*;
import java.util.*;

public class LikeDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	/**첫관심글등록
	 * @param 댓글 idx
	 * @param 유저 idx
	 * @return 성공여부
	 * */
	public int insertLike(int bbs_idx,int user_idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql="insert into like_table values(like_table_idx.nextval,?,?,1)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			ps.setInt(2, user_idx);
			
			return ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
	}
	/**관심여부 변경
	 * @param 관심글 등록 여부 1이면 0으로 0이면 1로 ok페이지에서 변환되서 들어옴 
	 *  @param 게시글 idx
	 *  @param 유저 idx
	 *  @return 성공여부
	 * */

	public int updateLike(int check,int bbs_idx,int user_idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql="update like_table set like_check=? where like_bbs_idx=? and like_user_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, check);
			ps.setInt(2, bbs_idx);
			ps.setInt(3, user_idx);
			
			return ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
	}
	/**관심글 등록 여부
	 * @param 게시글 idx
	 * @param 유저 idx
	 * @return 1이면 등록중 0이면 등록취소 상태 -1 에러 2 등록한적 없음
	 * */
	public int checkLike(int bbs_idx,int user_idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql="select like_check from like_table where like_bbs_idx=? and like_user_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			ps.setInt(2, user_idx);
			rs=ps.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}else {
				return 2;
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(rs!=null)rs.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	/**좋아요 중인 페이지 
	 * @param 유저의 idx
	 * @return 좋아요 중인 페이지 수
	 * */
	public int totalCnt(int user_idx) {
		try {
			conn=com.team4.db.Team4DB.getConn();
			String sql="select count(*) from like_table where like_user_idx=? and like_check=1";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, user_idx);
			rs=ps.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			// TODO: handle exception
			return -1;
			
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	
}
