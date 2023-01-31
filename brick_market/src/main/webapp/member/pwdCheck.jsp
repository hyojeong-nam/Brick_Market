<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="/brick_market/css/maincss.css">
<style>
h2 {
	text-align: center;
}

table {
	text-align: center;
	margin: 0px auto;
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
window.location.href='/brick_market/index.jsp';
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
<section class="section">
<form name="pwdCheck" action="pwdCheck_ok.jsp" method="post">
<table>
<tr>
<td><h2>비밀번호 확인</h2></td>
</tr>
<tr>
<td>개인 정보를 보호하기 위해 비밀번호를 다시 한 번 입력해 주세요.</td>
</tr>
<tr>
<td>비밀번호 <input type="password" name="userpwd"> <input type="submit" value="확인"></td>
</tr>
</table>
</form>
</section>
<%@include file="/footer.jsp"%>
</body>
</html>