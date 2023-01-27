<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="css/maincss.css">
<style type="text/css">
body {
	width: 1200px;
	margin: 0px auto;
}
section {
	width: 1200px;
	
}
section table img {
	width: 200px;
	margin: 10px;
}
section table {
	text-align: center;
	border: 0px;
	margin: auto;
}
section fieldset{
	border: 0px;

}
section legend{
	text-align: center;
}

</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<article>
			<fieldset>
				<legend>최신글 보기</legend>
				<table>
					<tr>
						<td><img src="/brick_market/img/test.png"></td>
						<td><img src="/brick_market/img/test.png"></td>
						<td><img src="/brick_market/img/test.png"></td>
						<td><img src="/brick_market/img/test.png"></td>
					</tr>
					<tr>
						<td>제목1</td>
						<td>제목2</td>
						<td>제목3</td>
						<td>제목4</td>
					</tr>
					<tr>
						<td>0원</td>
						<td>0원</td>
						<td>0원</td>
						<td>0원</td>
					</tr>

				</table>
			</fieldset>
		</article>

	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>