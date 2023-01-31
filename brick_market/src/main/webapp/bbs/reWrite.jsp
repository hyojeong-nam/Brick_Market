<%@page import="com.team4.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"
	scope="session"></jsp:useBean>
<%@page import="com.team4.bbs.BbsDTO"%>
<%@page import="com.team4.member.MemberDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="/brick_market/css/maincss.css">
<style>
.container {
	text-align: center;
	margin: 0px auto;
	width: 800px;
	display: grid;
	grid-template-columns: 50% 10% 40%;
	grid-template-rows: 40px 40px 40px 40px 240px auto;
	grid-template-areas: "item  title  title" "item  price  price"
		"item  proimg  nick" "item  proimg  star" "item   text   text";
}

.item_img {
	height: 400px;
	width: 400px;
	object-fit: cover;
	grid-area: item;
}

.title_text {
	grid-area: title;
	margin: 0px 0px;
}

.price_text {
	grid-area: price;
	margin: 10px 10px;
	text-align: right;
	color: red;
}

.profile_img {
	height: 80px;
	width: 80px;
	object-fit: cover;
	grid-area: proimg;
}

.profile_nick {
	grid-area: nick;
	text-align: left;
}

.profile_star {
	grid-area: star;
	text-align: left;
}

.item_text {
	grid-area: text;
	text-align: left;
}

.modify_button {
	text-align: right;
}
</style>
<%
String bbs_idx_s = request.getParameter("bbs_idx");
int bbs_idx = 0;
if (bbs_idx_s != null && bbs_idx_s.length() != 0) {
	bbs_idx = Integer.parseInt(bbs_idx_s);
}
if (bbs_idx == 0) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	window.location.href = '/brick_market/index.jsp';
</script>
<%
return;
}
BbsDTO bdto = bdao.bbsContent(bbs_idx);

if (bdto.equals(null)) {
%>
<script>
	window.alert('존재하지 않는 게시글입니다.');
	window.location.href = '/brick_market/index.jsp';
</script>
<%
return;
}
int user_idx = bdto.getBbs_writer_idx();
System.out.println(user_idx);
MemberDTO mdto = mdao.searchIdx(user_idx);
%>
</head>
<body>
	<%@include file="/header.jsp"%>
	<h3>상품등록 정보수정</h3>

	<form name="reWrite" action="/brick_market/bbs/reWrite_ok.jsp"
		method="post" enctype="multipart/form-data">
		<table border="0">
			<tr>
				<th colspan="3">작성자</th>
				<td><%=mdao.searchIdx(user_idx).getMember_nick()%></td>
			</tr>
			<tr>
				<th colspan="3">거래장소</th>
				<td><input type="text" name="bbs_place"
					value="<%=bdto.getBbs_place()%>"></td>
			</tr>
			<tr>
				<th colspan="3">거래방법</th>
				<td><input type="radio" name="bbs_how" value="0">자유 <input
					type="radio" name="bbs_how" value="1">직거래 <input
					type="radio" name="bbs_how" value="2">택배</td>
			</tr>
			<tr>
				<th colspan="3">판매상태</th>
				<td><input type="radio" name="bbs_status" value="0">판매중
					<input type="radio" name="bbs_status" value="1">예약중 <input
					type="radio" name="bbs_status" value="2">판매완료</td>
			</tr>
			<tr>
				<th colspan="3">카테고리</th>
				<td><select name="bbs_category">
						<option>카테고리 목록</option>
						<option value="0"><%=bdao.stringCategory(0)%></option>
						<option value="1"><%=bdao.stringCategory(1)%></option>
						<option value="2"><%=bdao.stringCategory(2)%></option>
						<option value="3"><%=bdao.stringCategory(3)%></option>
						<option value="4"><%=bdao.stringCategory(4)%></option>
				</select></td>
				<td colspan="4" rowspan="3"><img src=<%=bdto.getBbs_img()%>
					alt="이미지 첨부">
					<div>이미지 첨부하기</div>
					<div>(jpg,png 파일만 가능)</div></td>
			</tr>
			<tr>
				<th>상품명</th>
				<td colspan="3"><input type="text" name="bbs_subject"
					value="<%=bdto.getBbs_subject()%>"></td>
			</tr>
			<tr>
				<th>상품가격</th>
				<td colspan="3"><input type="text" name="bbs_price"
					value="<%=bdto.getBbs_price()%>"></td>
			</tr>
			<tr>
				<th rowspan="4">상품 내용</th>
				<td colspan="4" rowspan="4"><textarea rows="12" cols="22"
						name="bbs_content"
						placeholder="<%=bdto.getBbs_content().replaceAll("\n", "<br>")%>"></textarea></td>
			</tr>
			<tr colspan="3">
				<td colspan="4"><input type="file" name="bbs_img"
					value="이미지 첨부하기"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="수정하기"></td>
				<td colspan="2"><input type="button" value="취소하기"
					onclick="location.href=location.href='/brick_market/index.jsp'"></td>
			</tr>
		</table>
	</form>
	<%@include file="/footer.jsp"%>
</body>
</html>