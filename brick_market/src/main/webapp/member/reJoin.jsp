<%@page import="org.apache.tomcat.websocket.Transformation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.team4.member.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="mdao" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>

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

.profile_img {
	height: 150px;
	width: 150px;
	object-fit: cover;
}
</style>
<%
int user_idx = (int) session.getAttribute("midx");

if (session.getAttribute("midx") == null || session.getAttribute("midx").equals("")
		|| session.getAttribute("midx").equals("0")) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	window.location.href = '/brick_market/index.jsp';
</script>
<%
return;
}
//멤버 idx 가져오기
MemberDTO dto = mdao.searchIdx(user_idx);

//회원 등급 판별
int level = dto.getMember_class();
String result = (level == 1) ? "관리자" : (level == 0) ? "일반회원" : "정지회원";

//이메일 아이디/주소 각각 추출하기
String email = dto.getMember_email();
int domain = email.indexOf("@");
String email_id = email.substring(0, domain);
String email2 = email.substring(domain + 1);

//가입일 date 형식 변경하기
Date original_date = dto.getMember_date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
String joindate =sdf.format(original_date);
%>

<script>
	function checkMail() {
		if (rejoin.email_select.value == 'write') {
			rejoin.email2.readonly = false;
			rejoin.email2.value = '';
			rejoin.email2.focus();
		} else {
			rejoin.email2.readonly = true;
			rejoin.email2.value = rejoin.email_select.value;
		}
	}
</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<article>
		<form name="rejoin" action="reJoin_ok.jsp" method="post" enctype="multipart/form-data">
			<table border='1'>
				<tr>
					<td colspan="2"><h2>회원 정보</h2></td>
				</tr>
				<tr>
					<td><img class="profile_img" alt="profile" src="<%=dto.getMember_img()%>"><br> 
						<input type="file" name="member_img"/>
						</td>
					<td><%=dto.getMember_nick()%>님은 <%=result%>입니다.<br> 가입일: <%=joindate %>
						</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="member_name"
						value="<%=dto.getMember_name()%>"></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="member_id"
						value="<%=dto.getMember_id()%>"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="member_pwd" id="member_pwd1"
						value="<%=dto.getMember_pwd()%>"></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" name="member_nick"
						value="<%=dto.getMember_nick()%>"></td>
				</tr>
				<tr>
					<td>이메일</td>

					<td><input type="text" name="member_email" id="email1"
						class="box" value="<%=email_id%>"> 
						@ 
						<input type="text" name="email2" id="email2" class="box"
						value="<%=email2%>">

						<select name="email_select" class="box" id="email_select"
						onChange="checkMail();">
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
					<td colspan="2"><input type="submit" value="수정하기"> <input
						type="button" value="취소하기" onclick="history.back()"></td>
				</tr>
			</table>
		  </form>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>