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
	
	/**글쓰기 관련 메서드
	 * @param mr MultipartRequest
	 * @param writer_idx 글쓴이의 고유번호
	 * @return 1이 나온다면 정상, -1이 나온다면 등록 실패
	 * */
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
	
	/**글 수정 관련 메서드
	 * @param mr MultipartRequest
	 * @param bbs_idx 수정할 게시글의 고유번호
	 * @param realpath 저장, 삭제할 이미지의 실제 경로
	 * @return 1이 나온다면 정상, -1이 나온다면 수정 실패
	 * */
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
	
	/**이전 파일 삭제 메소드
	 * @param realpath 삭제할 파일의 실제 저장 경로
	 * @param bbs_idx 이미지를 삭제할 게시글의 고유 번호
	 * @return void
	 * */
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
	
	/**총페이지수 구하기
	 * @return 총 게시글 수
	 * */
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

	 /**총페이지수 구하기
	  * @param my_idx 게시글쓴사람인덱스
	  * @return 총 게시글 수
	  * */
	 public int getTotalCnt(int my_idx) {
		 try {
			 conn=com.team4.db.Team4DB.getConn();
			 String sql="select count(*) from bbs_table where bbs_writer_idx = ?";
			 ps=conn.prepareStatement(sql);
			 ps.setInt(1, my_idx);
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
	 
	 /**검색 결과에서 총페이지수 구하기
	  * @param keyword 게시글 제목에서 키워드가 포함된 항목만 검색
	  * @param category 게시글 카테고리가 일치하는 항목만 검색 (-1일 경우 모두 검색)
	  * @param status 게시글 상태가 일치하는 항목만 검색 (-1일 경우 모두 검색)
	  * @return 검색 결과에 해당하는 게시글 수
	  * 
	  * */
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
	
	/**글 보기
	 * @param size 한 페이지 넘길 때 넘어가는 글 갯수
	 * @param page 현재 페이지 번호
	 * @param extra 한 페이지에서 추가로 보여줄 글 갯수 size + extra 값이 한 페이지에서 보여주는 게시글 수가 된다
	 * @return 찾은 게시글 정보를 Bbs_DTO에 담아 ArrayList배열로 반환
	 *  */
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
	
	/**내 글 보기
	 * @param size 한 페이지 넘길 때 넘어가는 글 갯수
	 * @param page 현재 페이지 번호
	 * @param my_idx 글쓴이 idx
	 * @return 찾은 게시글 정보를 Bbs_DTO에 담아 ArrayList배열로 반환
	 *  */
	public ArrayList<BbsDTO> bbsMyList(int page, int size, int my_idx){
		try {
			conn = com.team4.db.Team4DB.getConn();
			String sql = "select * from "
					+ "(select rownum as rnum, a.* from "
					+ "(select * from bbs_table where bbs_writer_idx = ? order by bbs_idx desc)a)b "
					+ "where rnum >= ? and rnum <= ?";
			ps = conn.prepareStatement(sql);
			int start = (page - 1) * size + 1;
			int end = page * size;
			ps.setInt(1, my_idx);
			ps.setInt(2, start);
			ps.setInt(3, end);
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
	
	/**좋아요 한 글 보기
	 * @param page 현재 페이지 번호
	 * @param useridx 좋아요를 한 유저 고유번호
	 * @return 찾은 게시글 정보를 Bbs_DTO에 담아 ArrayList배열로 반환
	 * */
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
	
	/**글 검색 후 보기
	 * @param size 한 페이지 넘길 때 넘어가는 글 갯수
	 * @param page 현재 페이지 번호
	 * @param extra 한 페이지에서 추가로 보여줄 글 갯수 size + extra 값이 한 페이지에서 보여주는 게시글 수가 된다
	 * @param keyword 게시글 제목에서 키워드가 포함된 항목만 검색
	 * @param category 게시글 카테고리가 일치하는 항목만 검색 (-1일 경우 모두 검색)
	 * @param status 게시글 상태가 일치하는 항목만 검색 (-1일 경우 모두 검색)
	 * @return 찾은 게시글 정보를 Bbs_DTO에 담아 ArrayList배열로 반환
	 *  (페이징)*/
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
	
	
	
	/**글 하나보기
	 * @param idx 게시글 고유 번호
	 * @return 게시글 정보를 BbsDTO에 담아 반환
	 * */
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
	
	
	/**글 조회수 증가 관련 메서드
	 * @param idx 조회수를 증가시킬 게시글 고유 번호
	 * @return void
	 * */
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
	
	/**글 삭제 관련 메서드
	 * @param bbs_idx 삭제할 게시글 고유번호
	 * @param bbs_writer_idx 삭제할 게시글 작성자 고유번호
	 * @param pwd 작성자 비밀번호
	 * @param realpath 삭제할 게시글 사진 파일 경로
	 * @return 1이 나오면 삭제 완료, -1이 나오면 삭제 실패
	 * */
	public int bbsDelete(int bbs_idx, int bbs_writer_idx, String pwd, String realpath) {
		try {
			conn = com.team4.db.Team4DB.getConn();
			MemberDAO mdao = new MemberDAO();
			boolean result = mdao.checkPwd(bbs_writer_idx, pwd);
			int count = -1;
			if (result) {
				deleteBbsBeforeImg(realpath, bbs_idx);

				String sql = "delete bbs_table where bbs_idx = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, bbs_idx);
				count = ps.executeUpdate();
			}else {
				count=-1;
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
	
	
	/**카테고리 이름 불러오기 관련 메서드
	 * @param category 카테고리 번호
	 * @return 카테고리 이름 문자열
	 * */
	public String stringCategory(int category) {
		switch (category) {
		case -1:
			return "전체";
		case 0:
			return "전자기기";
		case 1:
			return "의류/잡화";
		case 2:
			return "뷰티/미용";
		case 3:
			return "게임/음악";
		case 4:
			return "기타물품";
		default:
			return "등록된 카테고리가 아닙니다";
		}
	}
	
}
