<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>
<%@page import="com.team4.member.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css"
	href="/brick_market/css/maincss.css">
<style>
h3 {
	text-align: center;
}

table {
	text-align: center;
	margin: 0px auto;
}

section article table img {
	width: 50px;
	height: 50px;
}
</style>
<%
int user_idx = 0;
if (session.getAttribute("midx") == null 
	|| session.getAttribute("midx").equals("")
	|| session.getAttribute("midx").equals("0")) {
%>
<script>
window.alert('로그인 후 이용 가능합니다.');	
window.location.href='/brick_market/member/login.jsp';
</script>	
<%
	return;
} else {
	user_idx = (Integer) session.getAttribute("midx");
}
%>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<h3>상품등록</h3>
		<article>
			<form name="imgUpload" 
				action="/brick_market/bbs/write_ok.jsp"method="post" enctype="multipart/form-data">
				<table border="0">
					<tr>
						<th colspan="3">작성자</th>
						<td><input type="text" name="writer_idx" value="<%=mdao.searchIdx(user_idx).getMember_nick()%>" readonly="readonly"></td>
					</tr>
					<tr>
						<th colspan="3">거래장소</th>
						<td><input type="text" name="bbs_place" placeholder="거래장소를 입력하세요." 
						required></td>
					</tr>
					<tr>
						<th colspan="3">거래방법</th>
						<td><input type="radio" name="bbs_how" value="0" checked>자유
						<input type="radio" name="bbs_how" value="1">직거래
						<input type="radio" name="bbs_how" value="2">택배
						</td>
					</tr>
					<tr>
						<th colspan="3">판매상태</th>
						<td><input type="radio" name="bbs_status" value="0" checked>판매중
							<input type="radio" name="bbs_status" value="1">예약중 <input
							type="radio" name="bbs_status" value="2">판매완료</td>
					</tr>
					<tr>
						<th colspan="3">카테고리</th>
						<td><select name="bbs_category">
								<option>카테고리 목록</option>
								<option value="0"><%=bdao.stringCategory(0) %></option>
								<option value="1"><%=bdao.stringCategory(1) %></option>
								<option value="2"><%=bdao.stringCategory(2) %></option>
								<option value="3"><%=bdao.stringCategory(3) %></option>
								<option value="4"><%=bdao.stringCategory(4) %></option>
						</select></td>
						<td colspan="4" rowspan="3"><img
							src="/brick_market/img/disk.png" alt="이미지 첨부">
							<div>이미지 첨부하기</div>
							<div>(jpg,png 파일만 가능)</div></td>
					</tr>
					<tr>
						<th>상품명</th>
						<td colspan="3"><input type="text" name="bbs_subject"
							placeholder="상품명을 입력하세요." required></td>
					</tr>
					<tr>
						<th>상품가격</th>
						<td colspan="3"><input type="text" name="bbs_price"
							placeholder="상품의 가격을 숫자로 적어주세요" required></td>
					</tr>
					<tr>
						<th rowspan="4">상품 내용</th>
						<td colspan="4" rowspan="4"><textarea rows="12" cols="22"
								name="bbs_content" placeholder="내용을 입력해주세요" required></textarea></td>
					</tr>
					<tr colspan="3">
						<td colspan="4"><input type="file" name="bbs_img"
							value="이미지 첨부하기"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="등록하기"></td>
						<td colspan="2"><input type="button" value="취소하기"
							onclick="location.href='/brick_market/index.jsp'"></td>
					</tr>
				</table>
			</form>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>