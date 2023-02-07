<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#wrap{
  display: flex;
  justify-content: center;
  align-items:center;
  min-height: 45vh;
}
#re {
	width: 80px;
	background-color: lightgrey;
	border-color: transparent;
	color: black;
	padding: 4px;
	border-radius: 10px 10px 10px 10px;
	font-family: inherit;
}
div{
font-family: inherit;
}
</style>
</head>
<body>
	<section class="mid">
		<article id="wrap">
		<form name="idCheck" action="idCheck_ok.jsp">
		<h1>아이디 중복 검사</h1>
				<div>아이디</div>
				<div><input type="text" name="userid" required> <input
						type="submit" value="중복 검사" id="re">
				</div>
		</form>
		</article>
	</section>
</body>
</html>