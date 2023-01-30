<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="/brick_market/css/maincss.css">
<style>
th {
  text-align: right;
}
</style>
<script>
function open_idcheck(){
window.open('idCheck.jsp','idCheck','width=450, height=150')
}
</script>

<script>
function test() {   
	var pwd1 = document.getElementById('member_pwd1').value;
    var pwd2 = document.getElementById('member_pwd2').value;
    
    /*if(pwd1.length < 4) {
            alert('입력한 글자가 4글자 이상이어야 합니다.');
            return false;
        }*/
        
        if( pwd1 != pwd2 ) {
          alert("비밀번호 불일치");
          return false;
        } else{
          alert("비밀번호 일치");
          return true;
        }
      }

 function checkMail(){
	 if (join.email_select.value=='write'){
		 join.email2.readonly=false;
		 join.email2.value='';
		 join.email2.focus();
	 } else {
		 join.email2.readonly=true;
		 join.email2.value=join.email_select.value;
	 }
	 
 }
 </script>
</head>
<body >
	<%@include file="/header.jsp"%>
	<section>
		<form name="join" action="join_ok.jsp" method="post">
			<table>
			<tr>
			<td><h2>회원가입</h2></td>
			</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="member_name" required></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="member_id" required readonly onclick="open_idcheck()"> 
					<input type="button" value="중복확인" onclick="open_idcheck()">
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="member_pwd" id="member_pwd1" required></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="member_pwd2" id="member_pwd2">
					<input type="button" value="확인" required onclick="test()"></td>
				</tr>

				<tr>
					<th>닉네임</th>
					<td><input type="text" name="member_nick" required></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
					<input type="text" name="member_email" id="email1" class="box"> @
					<input type="text" name="email2" id="email2" class="box">
					
					<select name="email_select" class="box" id="email_select" onChange="checkMail();">
					<option value="" selected>선택해 주세요</option>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="kakao.com">kakao.com</option>
					<option value="nate.com">nate.com</option>
					<option value="write">직접 입력</option>
					
					</select>
					</td>
				</tr>
				<tr>
				<td colspan="3" style="text-align:center"> <input type="submit" value="가입하기">
				<input type="reset" value="다시 작성">
				<input type="button" value="취소하기" onclick="history.back()">
				</td>
				</tr>
			</table>
		</form>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>