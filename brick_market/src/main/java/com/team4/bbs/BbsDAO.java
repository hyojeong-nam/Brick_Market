package com.team4.bbs;
import java.util.*;
import java.sql.*;
import com.team4.member.*;
import com.oreilly.servlet.*;
import java.io.*;

public class BbsDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	/**글쓰기*/
	public int bbsWrite(MultipartRequest mr, int writer_idx) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "insert into bbs_table values (bbs_table_idx.nextval,?,?,?,?,sysdate,0,?,?,0,?,?)";
			ps = conn.prepareStatement(sql);
			String subject = mr.getParameter("bbs_subject");
			ps.setString(1, subject);
			String content = mr.getParameter("bbs_content");
			ps.setString(2, content);
			String price_s = mr.getParameter("bbs_price");
			int price = 0;
			if (price_s != null && price_s.length() != 0) {
				price = Integer.parseInt(price_s);
			}
			ps.setInt(3, price);
			String imgname = mr.getFilesystemName("bbs_img");
			String img = "/brick_market/bbs/img/"+imgname;
			if(imgname == null){
				img = "/brick_market/bbs/img/test.png";
			}
			ps.setString(4,img);
			ps.setInt(5, writer_idx);
			String category_s = mr.getParameter("bbs_category");
			int category = -1;
			if (category_s != null && category_s.length() != 0) {
				category = Integer.parseInt(category_s);
			}
			ps.setInt(6, category);
			String place = mr.getParameter("bbs_place");
			ps.setString(7, place);
			String how_s = mr.getParameter("bbs_how");
			int how = -1;
			if (how_s != null && how_s.length() != 0) {
				how = Integer.parseInt(how_s);
			}
			ps.setInt(8, how);
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
	
	/**글수정*/
	public int bbsReWrite(MultipartRequest mr, int bbs_idx, String realpath) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			
			String imgname = mr.getFilesystemName("bbs_img");
			String img = "/brick_market/bbs/img/"+imgname;
			String imgsql = "bbs_img = '"+img+"' , ";
			if(imgname == null){
				imgsql = "";
			}else {
				deleteBbsBeforeImg(realpath, bbs_idx);
			}
			
			String sql = "update bbs_table set bbs_subject = ?, bbs_content = ?, bbs_price = ?,"+imgsql+"bbs_category = ?, bbs_place = ?, bbs_how = ? where bbs_idx = ?";
			ps = conn.prepareStatement(sql);
			
			
			String subject = mr.getParameter("bbs_subject");
			ps.setString(1, subject);
			String content = mr.getParameter("bbs_content");
			ps.setString(2, content);
			String price_s = mr.getParameter("bbs_price");
			int price = 0;
			if (price_s != null && price_s.length() != 0) {
				price = Integer.parseInt(price_s);
			}
			ps.setInt(3, price);
			String category_s = mr.getParameter("bbs_category");
			int category = -1;
			if (category_s != null && category_s.length() != 0) {
				category = Integer.parseInt(category_s);
			}
			ps.setInt(4, category);
			String place = mr.getParameter("bbs_place");
			ps.setString(5, place);
			String how_s = mr.getParameter("bbs_how");
			int how = -1;
			if (how_s != null && how_s.length() != 0) {
				how = Integer.parseInt(how_s);
			}
			ps.setInt(6, how);
			ps.setInt(7, bbs_idx);

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
	
	/**이전 파일 삭제 메소드 (수정 시 사용)*/
	public void deleteBbsBeforeImg(String realpath,int bbs_idx) {
		try {
			
			String sql = "select * from bbs_table where bbs_idx = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bbs_idx);
			rs = ps.executeQuery();
			if(rs.next()) {
				String img = rs.getString("bbs_img");
				img = img.replaceAll("/brick_market/bbs/img/", "");
				String realimg = realpath + img;
				File old = new File(realimg);
				if(old.exists() && old.isFile() && !(img.equals("test.png"))) {
					old.delete();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**총페이지수 구하기*/
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
	 
	 /**검색 결과에서 총페이지수 구하기*/
	 public int getTotalCnt(String keyword, int category, int status) {
		 try {
			String keywordsql1 = "";
			String keywordsql2 = "";
			if(!(keyword.equals("") || keyword.length() == 0)) {
				keywordsql1 = ", instr(bbs_subject,'"
				+keyword+"') as result "; 
				keywordsql2 = " and result > 0 ";
			}
			String categorysql = "";
			if(category != -1) {
				categorysql = " and bbs_category = "+String.valueOf(category);
			}
			String statussql = "";
			if(status != -1) {
				statussql = " and bbs_status = "+String.valueOf(status);
			}
			conn=com.team4.db.Team4DB.getConn();
			String sql = "select count(*) from "
					 + "(select rownum as rnum, a.* "+keywordsql1+" from "
					 + "(select * from bbs_table where bbs_idx > 0 "+categorysql+statussql
					 + " order by bbs_idx desc)a)b "
					 + "where rnum > 0"+keywordsql2;
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
				String bbs_date_s = rs.getString("bbs_date");
				java.sql.Date bbs_date=rs.getDate("bbs_date");
				int bbs_readnum = rs.getInt("bbs_readnum");
				int bbs_writer_idx = rs.getInt("bbs_writer_idx");
				int bbs_category = rs.getInt("bbs_category");
				int bbs_status = rs.getInt("bbs_status");
				String bbs_place = rs.getString("bbs_place");
				int bbs_how = rs.getInt("bbs_how");
				BbsDTO dto = new BbsDTO(bbs_idx, bbs_subject, bbs_content, bbs_price, bbs_img, bbs_date, bbs_readnum, bbs_writer_idx, bbs_category, bbs_status, bbs_place, bbs_how,bbs_date_s);
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
	public ArrayList<BbsDTO> bbsList(int page,int useridx){
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from (select rownum as rnum, a.* from "
					+ "(select * from bbs_table,like_table where bbs_idx=like_bbs_idx and like_user_idx=? "
					+ "and like_check=1 order by bbs_idx desc)a)b where rnum >= 1 and rnum <= ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, useridx);
			ps.setInt(2, 5*page);
			rs = ps.executeQuery();
			ArrayList<BbsDTO> arr = new ArrayList<BbsDTO>();
			while(rs.next()) {
				int bbs_idx = rs.getInt("bbs_idx");
				String bbs_subject = rs.getString("bbs_subject");
				String bbs_content = rs.getString("bbs_content");
				int bbs_price = rs.getInt("bbs_price");
				String bbs_img = rs.getString("bbs_img");
				String bbs_date_s = rs.getString("bbs_date");
				java.sql.Date bbs_date=rs.getDate("bbs_date");
				int bbs_readnum = rs.getInt("bbs_readnum");
				int bbs_writer_idx = rs.getInt("bbs_writer_idx");
				int bbs_category = rs.getInt("bbs_category");
				int bbs_status = rs.getInt("bbs_status");
				String bbs_place = rs.getString("bbs_place");
				int bbs_how = rs.getInt("bbs_how");
				BbsDTO dto = new BbsDTO(bbs_idx, bbs_subject, bbs_content, bbs_price, bbs_img, bbs_date, bbs_readnum, bbs_writer_idx, bbs_category, bbs_status, bbs_place, bbs_how,bbs_date_s);
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
	
	/**글 검색 후 보기 (페이징)*/
	public ArrayList<BbsDTO> bbsList(int size, int page, int extra, String keyword, int category, int status){
		try {
			String keywordsql1 = "";
			String keywordsql2 = "";
			if(!(keyword.equals("") || keyword.length() == 0)) {
				keywordsql1 = ", instr(bbs_subject,'"
			+keyword+"') as result "; 
				keywordsql2 = " and result > 0";
			}
			String categorysql = "";
			if(category != -1) {
				categorysql = " and bbs_category = "+String.valueOf(category);
			}
			String statussql = "";
			if(status != -1) {
				statussql = " and bbs_status = "+String.valueOf(status);
			}
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from "
					+ "(select rownum as rnum, a.* "+keywordsql1+" from "
					+ "(select * from bbs_table where bbs_idx > 0 " +categorysql+statussql
					+ " order by bbs_idx desc)a)b "
					+ "where rnum >= ? and rnum <= ?"+keywordsql2;
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
				String bbs_date_s = rs.getString("bbs_date");
				java.sql.Date bbs_date=rs.getDate("bbs_date");
				int bbs_readnum = rs.getInt("bbs_readnum");
				int bbs_writer_idx = rs.getInt("bbs_writer_idx");
				int bbs_category = rs.getInt("bbs_category");
				int bbs_status = rs.getInt("bbs_status");
				String bbs_place = rs.getString("bbs_place");
				int bbs_how = rs.getInt("bbs_how");
				BbsDTO dto = new BbsDTO(bbs_idx, bbs_subject, bbs_content, bbs_price, bbs_img, bbs_date, bbs_readnum, bbs_writer_idx, bbs_category, bbs_status, bbs_place, bbs_how,bbs_date_s);
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
	
	/**글 삭제*/
	public int bbsDelete(int bbs_idx, int bbs_writer_idx, String pwd) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			MemberDAO mdao = new MemberDAO();
			boolean result = mdao.checkPwd(bbs_writer_idx, pwd);
			int count = -1;
			if (result) {
				String sql = "delete bbs_table where bbs_idx = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, bbs_idx);
				count = ps.executeUpdate();
			}else {
				count=0;
			}
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
	
	
	/**카테고리 이름 불러오기*/
	public String stringCategory(int category) {
		switch (category) {
		case -1:
			return "전체";
		case 0:
			return "디지털 기기";
		case 1:
			return "의류";
		case 2:
			return "생활 잡화";
		case 3:
			return "뷰티 / 미용";
		case 4:
			return "취미 / 게임 / 음반";
		default:
			return "등록된 카테고리가 아닙니다";
		}
	}
	
}
