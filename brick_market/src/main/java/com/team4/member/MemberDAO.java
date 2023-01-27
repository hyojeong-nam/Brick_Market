package com.team4.member;

import java.sql.*;
import java.util.*;

public class MemberDAO {
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	/**회원 가입*/
	public int joinMember(MemberDTO dto) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "insert into member_table values (member_table_idx.nextval,?,?,?,?,?,sysdate,'img',0)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getMember_id());
			ps.setString(2, dto.getMember_pwd());
			ps.setString(3, dto.getMember_name());
			ps.setString(4, dto.getMember_nick());
			ps.setString(5, dto.getMember_email());
			int count = ps.executeUpdate();
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
	
	/**로그인*/
	public boolean checkLogin(String id, String pwd) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from member_table where id = ?, pwd = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			
			boolean result = rs.next();
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
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
	
	/**idx로 검색*/
	public MemberDTO searchIdx(int idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from idx = ?";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				
				String member_id = rs.getString("member_id");
				String member_pwd = rs.getString("member_pwd");
				String member_name = rs.getString("member_name");
				String member_nick = rs.getString("member_nick");
				String memeber_email = rs.getString("member_email");
				java.sql.Date member_date = rs.getDate("member_date");
				String member_img = rs.getString("member_img");
				int memeber_class = rs.getInt("member_class");
				
				MemberDTO dto = new MemberDTO(idx, member_id, member_pwd, member_name, member_nick, memeber_email, member_date, member_img, memeber_class);
				return dto;
			}else {
				return null;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
