<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
#go {
	width: 80px;
	background-color: rgb(245,147,109);
	border-color: transparent;
	color: white;
	padding: 8px;
	margin-bottom: 5px;
	border-radius: 10px 10px 10px 10px;
	font-family: inherit;
	margin-top: 13px;
}
#textbox {
	width: 175px;
	height:8px;
	margin-bottom: 3px;
	margin-top: 4px;
	padding: 12px;
	border: 1px solid lightgray;
	border-radius: 3px;
	font-family: inherit;
}
</style>
<%
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
}
%>
</head>
<body>
<%@include file="/header.jsp"%>
<section class="mid">
<form name="pwdCheck" action="pwdCheck_ok.jsp" method="post">
<table style="height: 200px; width: 600px;">
<tr>
<td><h2>비밀번호 확인</h2></td>
</tr>
<tr>
<td>개인 정보를 보호하기 위해 비밀번호를 다시 한 번 입력해 주세요.</td>
</tr>
<tr>
<td>비밀번호 <input type="password" name="userpwd" id="textbox"> <input type="submit" id="go" value="확인"></td>
</tr>
<tr> </tr>
</table>
</form>
</section>
<%@include file="/footer.jsp"%>
</body>
</html>