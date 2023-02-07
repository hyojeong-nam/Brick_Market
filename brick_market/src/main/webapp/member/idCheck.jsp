<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h1{
text-align:center;
}
#wrap{
  display: flex;
  justify-content: center;
  align-items:center;
  min-height: 45vh;
}
#check {
	width: 80px;
	background-color: lightgrey;
	border-color: transparent;
	color: black;
	padding: 4px;
	border-radius: 10px 10px 10px 10px;
	font-family: inherit;
}
body, div{
	font-family: inherit;
}

#textbox {
	width: 200px;
	height:10px;
	margin-bottom: 3px;
	margin-top: 4px;
	padding: 13px;
	border: 1px solid lightgray;
	border-radius: 3px;
	font-family: inherit;
}
</style>
</head>
<body>
	<section class="mid">
		<article id="wrap">
		<form name="idCheck" action="idCheck_ok.jsp">
		<h1>아이디 중복 검사</h1>
				<div>ID <input type="text" name="userid" placeholder="가입할 아이디를 입력해 주세요" id="textbox" required> <input
						type="submit" value="중복 검사" id="check">
				</div>
		</form>
		</article>
	</section>
</body>
</html>