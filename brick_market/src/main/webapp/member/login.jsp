<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="/header.jsp"%>
	<h1>로그인</h1>
	<section>
		<form>
			<table>
				<tr>
					<td>그림 <input type="text" placeholder="ID">
					</td>
				</tr>
				<tr>
					<td>열쇠 <input type="text" placeholder="PASSWORD">
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