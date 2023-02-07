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
<script>
	function check_pwd() {
		var pwd1 = document.getElementById('pwd1').value;
		var pwd2 = document.getElementById('pwd2').value;
		var member_pwd= document.getElementById('member_pwd').value;

		if (pwd1 != '' && pwd2 != '' && member_pwd!='') {
			if (pwd1 == pwd2) {
				document.getElementById('check').innerHTML = '비밀번호가 일치합니다.'
				document.getElementById('check').style.color = 'blue';
				return true;
			
			} else if (pwd1 !=  pwd2) {
				document.getElementById('check').innerHTML = '비밀번호가 일치하지 않습니다.';
				document.getElementById('check').style.color = 'red';
				return false;
			} else if(member_pwd==pwd1==pwd2){
				document.getElementById('check').innerHTML = '현재 비밀번호와 똑같은 비밀번호입니다.';
				document.getElementById('check').style.color = 'red';
				return false;		
				}
		}	
}
</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<article>
		<form name="rejoin" action="reJoin_ok.jsp" method="post" enctype="multipart/form-data">
	<div><h2>회원 정보</h2></div>
	<div><img class="profile_img" alt="profile" src="<%=dto.getMember_img()%>"><br> 
			<input type="file" name="member_img"/></div>
			<div><%=dto.getMember_nick()%>님은 <%=result%>입니다.<br> 가입일: <%=joindate %></div>

			<div>이름 | <input type="text" name="member_name" value="<%=dto.getMember_name()%>" required></div>

			<div>아이디 | <input type="text" name="member_id" value="<%=dto.getMember_id()%>" readonly></div>

			<div>현재 비밀번호 | <input type="password" name="member_pwd" id="member_pwd" onchange="check_pwd()" value="<%=dto.getMember_pwd()%>"  required></div>
			
			<div>변경할 비밀번호 | <input type="password" name="pwd1" id="pwd1" onchange="check_pwd()" required> </div>
			
			<div>변경할 비밀번호 확인 | <input type="password" name="pwd2" id="pwd2" onchange="check_pwd()" required>
			<br> <span id="check"></span></div>
			
			
			<div>닉네임 | <input type="text" name="member_nick" value="<%=dto.getMember_nick()%>" required></div>

			<div>이메일 | <input type="text" name="member_email" id="email1" class="box" value="<%=email_id%>" required> 
					@ <input type="text" name="email2" id="email2" class="box" value="<%=email2%>" required>

					<select name="email_select" class="box" id="email_select" onChange="checkMail();">
							<option value="" selected>선택해 주세요</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="kakao.com">kakao.com</option>
							<option value="nate.com">nate.com</option>
							<option value="write">직접 입력</option>
						</select>
			</div>
				<input type="submit" value="수정하기"> 
				<input type="button" value="취소하기" onclick="history.back()">
		  </form>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>