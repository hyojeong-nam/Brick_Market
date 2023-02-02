<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="/brick_market/css/maincss.css">
<style>
h1{
text-align: center;
}
button {
width:40%;
font-size: 24px;
padding: 10px;
border-radius: 5px;
background-color: #2991b1;
border : none;
color : #fff;
margin-top: 30px;
}
button:hover{
cursor: pointer;
background-color: #2c778e;
}
</style>
</head>
<%
	String saveid ="";
	Cookie cks[] = request.getCookies();
	if(cks!=null){
		for(int i=0;i<cks.length;i++){
			if(cks[i].getName().equals("saveid")){
				saveid = cks[i].getValue();	
			}
		}
	}
%>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<form name="login" action="login_ok.jsp" method="post">
			<p><h1>로그인</h1>
			<div>
				<label><input type="text" name="userid" placeholder="ID" value="<%=saveid %>" required></label>
			</div>
			<div>
				<label><input type="password" name="userpwd" placeholder="PASSWORD" required></label>
			</div>
			<div>
			<label><input type = "checkbox" name = "saveid" value ="on" 
			<%=saveid.equals("")?"":"checked" %>>아이디 저장</label>
			</div>
			<div>
			<label><input type="submit" value="로그인"></label>
			</div>
			<div>
			<label><input type="button" value="아이디/비밀번호 찾기"></label>
			</div>
		</form>
	</section>
		<%@include file="/footer.jsp"%>
</body>
</html>