package com.team4.member;

import java.io.File;
import java.sql.*;
import java.util.*;
import javax.sql.*;
import javax.naming.*;
import com.oreilly.servlet.MultipartRequest;

public class MemberDAO {
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	/**회원 가입 관련 메서드
	 * @param dto 멤버 정보를 담은 DTO
	 * @param email 멤버 이메일 뒷자리 정보
	 * @return 1이면 정상 가입 완료, -1이면 가입 실패
	 * */
	public int joinMember(MemberDTO dto,String email) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "insert into member_table values (member_table_idx.nextval,?,?,?,?,?,sysdate,'/brick_market/member/img/profile.png',0)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getMember_id());
			ps.setString(2, dto.getMember_pwd());
			ps.setString(3, dto.getMember_name());
			ps.setString(4, dto.getMember_nick());
			ps.setString(5, dto.getMember_email()+email);
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
	
	/**로그인 관련 메서드
	 * @param id 로그인할 유저 아이디
	 * @param pwd 로그인할 유저 비밀번호
	 * @return 로그인 유저 고유 번호를 반환, 로그인 실패 시 -1 반환
	 * */
	public int checkLogin(String id, String pwd) {
		try {
			int result=-1;
			
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from member_table where member_id = ? and member_pwd = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				result=rs.getInt("member_idx");	
			}
			
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
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
	
	/**유저 검색 관련 메서드
	 * @param idx 유저 고유 번호
	 * @return 유저 정보가 담긴 MemberDTO를 반환 검색 실패 시 null 반환
	 * */
	public MemberDTO searchIdx(int idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from member_table where member_idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
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
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
				
			}
		}
	}
	
	/**비밀번호 확인 관련 메서드
	 * @param idx 유저의 고유 번호
	 * @param pwd 유저의 비밀 번호
	 * @return 비밀번호가 맞을 경우 true, 틀렸을 경우 false를 반환
	 * */
	public boolean checkPwd(int idx, String pwd) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from member_table where member_idx = ? and member_pwd = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,idx);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			if(rs.next()) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			// TODO: handle finally clause
		}
		
	}
	
	/**아이디 중복 검사 관련 메서드
	 * @param userid 중복 검사할 아이디
	 * @return 중복된 아이디가 있을 경우 true, 아닐 경우 false를 반환함
	 * */
	public boolean idCheck(String userid) {
		try{
			conn=com.team4.db.Team4DB.getConn();
			String sql="select member_id from member_table where member_id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			
			return rs.next();
			
			}catch(Exception e) {
				return false;
			}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**회원 정보 수정 관련 메서드
	 * @param mr MultipartRequest
	 * @param idx 정보를 수정할 회원의 고유 번호
	 * @param email2 이메일 주소 뒷자리
	 * @param realpath 파일 삭제를 위한 이미지 경로
	 * @return 1이 반환될 경우 정상 수정 완료, -1이 반환된 경우 수정 실패
	 * */
	public int joinUpdate(MultipartRequest mr, int idx, String email2, String realpath) {
		try {
			conn=com.team4.db.Team4DB.getConn();

			String imgname=mr.getFilesystemName("member_img");
			String img="/brick_market/member/img/"+imgname;
			String imgsql="member_img='"+img+"',";
			
			if(imgname==null) {
				imgsql="";
			}else {
				deleteMemberBeforeImg(realpath, idx);
			}
			
			
			String sql = "update member_table set member_id =?,"
					+ "member_pwd=? , member_name=?, member_nick=?,"+imgsql+"member_email=? "
					+ "where member_idx="+idx;
			ps = conn.prepareStatement(sql);
			
			String id=mr.getParameter("member_id");
			ps.setString(1, id);
			
			String pwd=mr.getParameter("member_pwd");
			ps.setString(2, pwd);
			
			String name=mr.getParameter("member_name");
			ps.setString(3, name);
			
			String nick=mr.getParameter("member_nick");
			ps.setString(4, nick);
			
			String email=mr.getParameter("member_email")+email2;
			ps.setString(5, email);
			
			int count = ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;

		} finally {
			try {
				if (ps != null) ps.close();
				if (conn != null) conn.close();

			} catch (Exception e2) {
				e2.printStackTrace();
			}

		}
	}

	/** 이전 파일 삭제 메소드 (수정 시 사용)
	 * @param realpath 삭제할 프로필 사진의 실제 저장 경로
	 * @param member_idx 프로필 사진을 삭제할 회원의 고유 번호
	 * @return void
	 * */
	public void deleteMemberBeforeImg(String realpath, int member_idx) {
		try {

			String sql = "select * from member_table where member_idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_idx);
			rs = ps.executeQuery();
			if (rs.next()) {
				String img = rs.getString("member_img");
				img = img.replaceAll("/brick_market/member/img/", "");
				String realimg = realpath + img;
				File old = new File(realimg);
				if (old.exists() && old.isFile() && !(img.equals("profile.png"))) {
					old.delete();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	
}
