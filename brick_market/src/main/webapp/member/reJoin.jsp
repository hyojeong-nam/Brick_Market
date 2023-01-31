<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css"
	href="/brick_market/css/maincss.css">
<style>
h2 {
	text-align: center;
}

table {
	text-align: center;
	margin: 0px auto;
}
</style>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section class="section">
		<form name='rejoin' action='rejoin_ok.jsp'>
			<table border='1'>
				<tr>
					<td colspan="2"><h2>회원 정보</h2></td>
				</tr>
				<tr>
					<td>이미지 영역</td>
					<td rowspan="2">닉네임님은 일반 회원입니다.<br>
					가입일 2XXX년 X월 X일</td>
				</tr>
				<tr>
					<td><input type="button" value="프로필 사진 변경"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pwd"></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" name="nick"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email1"> @ <input
						type="text" name="email2" id="email2" class="box"> 
						<select name="email_select" class="box" id="email_select" onChange="checkMail();">
							<option value="" selected>선택해 주세요</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="kakao.com">kakao.com</option>
							<option value="nate.com">nate.com</option>
							<option value="write">직접 입력</option>
					</select></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="로그인"> <input type="button" value="취소하기"></td>
				</tr>
			</table>
		</form>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>