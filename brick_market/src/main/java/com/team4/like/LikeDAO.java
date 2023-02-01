package com.team4.like;

import java.sql.*;
import java.util.*;

public class LikeDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

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
	
}
