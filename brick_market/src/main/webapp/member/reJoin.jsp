<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="/brick_market/css/maincss.css">
</head>
<body>
<%@include file="/header.jsp"%>
<section>
<form name='rejoin' action='rejoin_ok.jsp'>
<table border='1'>
<tr>
<td><h2>회원 정보</h2></td>
</tr>
<tr>
<td>프로필 사진</td>
<td>닉네임님은 일반 회원입니다.</td>
</tr>
<tr>
<td>이름</td>
<td><input type="text" name="name"></td>
</tr>

</table>
</form>
</section>
<%@include file="/footer.jsp"%>
</body>
</html>