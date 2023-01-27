<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="css/maincss.css">
<script>
function openImgUpload(){
	window.open('imgUpload.jsp','imgupload','width=450,height=350');
}
</script>
<style>
h3{
	text-align: center;
}
table{
	text-align: center;
	margin: 0px auto;
}
</style>
</head>
<body>
	<%@include file="/header.jsp" %>
	<h3>상품등록</h3>
	<section>
		<article>
			<form name="pdAdd" action="list.jsp">
				<table border="0">
					<tr>
						<th colspan="3">카테고리</th>
						<td><select name="category">
								<option>카테고리 목록</option>
								<option value="디지털기기">디지털기기</option>
								<option value="의류">의류</option>
								<option value="생활잡화">생활잡화</option>
								<option value="뷰티/미용">뷰티/미용</option>
								<option value="취미/게임/음반">취미/게임/음반</option></td>
						</select>
						<td colspan="4" rowspan="3">
						<img src="img/disk.png" alt="이미지 첨부">
						<div>이미지 첨부하기</div>
						<div>(jpg,png 파일만 가능)</div>
						</td>
					</tr>
					<tr>
						<th>상품명</th>
						<td colspan="3"><input type="text" placeholder="상품명을 입력하세요."></td>
					</tr>
					<tr>
						<th>상품가격</th>
						<td colspan="3"><input type="" placeholder="상품의 가격을 적어주세요"></td>
					</tr>
					<tr>
						<th rowspan="4">상품 내용</th>
						<td colspan="4" rowspan="4"><textarea rows="12" cols="22"
								placeholder="내용을 입력해주세요"></textarea></td>
					</tr>
					<tr colspan="3">
						<td colspan="4"><input type="button" value="이미지 첨부하기" onclick="openImgUpload();"></td>
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
	<%@include file="/footer.jsp" %>
</body>
</html>