<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="/brick_market/css/maincss.css">
<%
int user_idx = (int) session.getAttribute("midx");

if (session.getAttribute("midx") == null || session.getAttribute("midx").equals("")
		|| session.getAttribute("midx").equals("0")) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	window.location.href = '/brick_market/index.jsp';
</script>
<%
return;
}
%>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<article>
			<h1>신고하기</h1>
			<form>
			<div>
			신고글 
			</div>
			<div>
			신고 대상
			</div>
			<div>
			신고 내용
			<textarea name="report_content"> </textarea>
			</div>
			<div>
			<input type="submit" value="등록하기">
			<input type="reset" value="다시 작성">
			<input type="button" value="취소하기" onclick="history.back();">
			</div>
			</form>
		</article>
	</section>
		<%@include file="/footer.jsp"%>
</body>
</html>