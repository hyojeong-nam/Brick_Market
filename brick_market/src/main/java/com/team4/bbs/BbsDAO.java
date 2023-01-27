package com.team4.bbs;
import java.util.*;
import java.sql.*;
import com.team4.member.*;

public class BbsDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	/**글쓰기*/
	public int bbsWrite(BbsDTO dto) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "insert into bbs_table values (bbs_table_idx.nextval,?,?,?,?,sysdate,0,?,?,0,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getBbs_subject());
			ps.setString(2, dto.getBbs_content());
			ps.setInt(3, dto.getBbs_price());
			ps.setString(4, dto.getBbs_img());
			ps.setInt(5, dto.getBbs_writer_idx());
			ps.setInt(6, dto.getBbs_category());
			ps.setString(7, dto.getBbs_place());
			ps.setInt(8, dto.getBbs_how());
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
	 public int getTotalCnt() {
		 try {
			 conn=com.team4.db.Team4DB.getConn();
			 String sql="select count(*) from bbs_table";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
			// TODO: handle exception
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
	
	/**글 보기 (페이징)*/
	public ArrayList<BbsDTO> bbsList(int size, int page, int extra){
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from "
					+ "(select rownum as rnum, a.* from "
					+ "(select * from bbs_table order by bbs_idx desc)a)b "
					+ "where rnum >= ? and rnum <= ?";
			ps = conn.prepareStatement(sql);
			int start = (page - 1) * size + 1;
			int end = page * size + extra;
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			ArrayList<BbsDTO> arr = new ArrayList<BbsDTO>();
			while(rs.next()) {
				int bbs_idx = rs.getInt("bbs_idx");
				String bbs_subject = rs.getString("bbs_subject");
				String bbs_content = rs.getString("bbs_content");
				int bbs_price = rs.getInt("bbs_price");
				String bbs_img = rs.getString("bbs_img");
				java.sql.Date bbs_date = rs.getDate("bbs_date");
				int bbs_readnum = rs.getInt("bbs_readnum");
				int bbs_writer_idx = rs.getInt("bbs_writer_idx");
				int bbs_category = rs.getInt("bbs_category");
				int bbs_status = rs.getInt("bbs_status");
				String bbs_place = rs.getString("bbs_place");
				int bbs_how = rs.getInt("bbs_how");
				BbsDTO dto = new BbsDTO(bbs_idx, bbs_subject, bbs_content, bbs_price, bbs_img, bbs_date, bbs_readnum, bbs_writer_idx, bbs_category, bbs_status, bbs_place, bbs_how);
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
	
	/**글 하나보기*/
	public BbsDTO bbsContent(int idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			bbsReadnum(idx); //조회수 증가
			String sql = "select * from bbs_table where bbs_idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs = ps.executeQuery();
			if(rs.next()) {
				String bbs_subject = rs.getString("bbs_subject");
				String bbs_content = rs.getString("bbs_content");
				int bbs_price = rs.getInt("bbs_price");
				String bbs_img = rs.getString("bbs_img");
				java.sql.Date bbs_date = rs.getDate("bbs_date");
				int bbs_readnum = rs.getInt("bbs_readnum");
				int bbs_writer_idx = rs.getInt("bbs_writer_idx");
				int bbs_category = rs.getInt("bbs_category");
				int bbs_status = rs.getInt("bbs_status");
				String bbs_place = rs.getString("bbs_place");
				int bbs_how = rs.getInt("bbs_how");
				BbsDTO dto = new BbsDTO(idx, bbs_subject, bbs_content, bbs_price, bbs_img, bbs_date, bbs_readnum, bbs_writer_idx, bbs_category, bbs_status, bbs_place, bbs_how);
				return dto;
			}else {
				return null;
			}
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
	
	
	/**글 조회수*/
	public void bbsReadnum(int idx) {
		try {
//			conn = com.team4.db.Team4DB.getConn();
			String sql = "update bbs_table set bbs_readnum = bbs_readnum+1 where bbs_idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			int count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			try {
				if(ps!=null)ps.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**글 수정*/
	
	
	
	/**글 삭제*/
	public int bbsDelete(int bbs_idx, int bbs_writer_idx, String pwd) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			MemberDAO mdao = new MemberDAO();
			boolean result = mdao.checkPwd(bbs_writer_idx, pwd);
			int count = -1;
			if (result) {
				String sql = "delete bbs_table where idx = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, bbs_idx);
				count = ps.executeUpdate();
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				
			} catch (Exception e2) {
				e2.printStackTrace();
			} 
		}
	}
	
}
