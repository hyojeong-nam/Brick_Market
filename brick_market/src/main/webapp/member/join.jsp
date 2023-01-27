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
	<section>
		<h2>회원가입</h2>
		<form name="join">
			<table>
				<tr>
					<th>이름</th>
					<td><input type="text"></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text"> 
					<input type="submit" value="중복확인"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="text"></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="text"> <input type="submit" value="확인"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
					<input type="text"> @
					<input type="text" readonly>
					<select>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="kakao.com">kakao.com</option>
					<option value="nate.com">nate.com</option>
					<option value="type">직접 입력</option>
					</select>
					</td>
				</tr>
				<tr>
				<td colspan="3"> <input type="submit" value="가입하기">
				<input type="reset" value="다시 작성">
				<input type="button" value="취소하기" onclick="history.back();">
				</td>
				</tr>
			</table>
		</form>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>