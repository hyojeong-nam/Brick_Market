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
table {
	text-align: center;
	margin: 0px auto;
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
			<table>
			<tr>
			<td><h1>로그인</h1></td>
			</tr>
				<tr>
					<td>그림 <input type="text" name="userid" placeholder="ID" value="<%=saveid %>" required>
					</td>
				</tr>
				<tr>
					<td>열쇠 <input type="password" name="userpwd" placeholder="PASSWORD" required>
					</td>
				</tr>
				<tr>
					<td><input type = "checkbox" name = "saveid" value ="on" <%=saveid.equals("")?"":"checked" %>>ID 기억하기
					</td>
				</tr>
				<tr>
				<td><input type="submit" value="로그인"></td>
				</tr>
				<tr>
				<td><input type="button" value="아이디/비밀번호 찾기"></td>				
				</tr>
			</table>
		</form>
	</section>
		<%@include file="/footer.jsp"%>
</body>
</html>