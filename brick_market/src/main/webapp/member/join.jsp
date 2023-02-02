<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="/brick_market/css/maincss.css">
<style>

</style>
<script>
function open_idcheck(){
window.open('idCheck.jsp','idCheck','width=450, height=150')
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

<script>
function check_pwd() { 
	var pwd1 = document.getElementById('pwd1').value;
    var pwd2 = document.getElementById('pwd2').value;

if(pwd1 !='' && pwd2 !=''){
    if(pwd1 == pwd2) {
        document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
        document.getElementById('check').style.color='blue';
        return true;
    }
    else{
        document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
        document.getElementById('check').style.color='red';
        return false;
   	 }
	}
}

function join_check(){
	var pwd1 = document.getElementById('pwd1').value;
    var pwd2 = document.getElementById('pwd2').value;
    
    if(document.getElementById('name').value==null||document.getElementById('name').value==""){
    	
    	alert("이름을 입력해주세요.");
    	return false;
    }
    
	if(document.getElementById('id').value==null||document.getElementById('id').value==""){
    	
    	alert("아이디를 입력해주세요.");
    	return false;
    }
	if(document.getElementById('pwd1').value==null||document.getElementById('pwd1').value==""){
    	
    	alert("비밀번호를 입력해주세요.");
    	return false;
    }    
	if( pwd1 != pwd2 ) {
		alert("비밀번호를 확인해 주세요.");
		return false;
		} 
		
	
	if(document.getElementById('nick').value==null||document.getElementById('nick').value==""){
			
			alert("닉네임을 입력해주세요.");
			return false;
		}	
		
	if(document.getElementById('email1').value==null||document.getElementById('email1').value==""){
		
		alert("이메일을 입력해주세요.");
		return false;
	}
	if(document.getElementById('email2').value==null||document.getElementById('email2').value==""){
		
		alert("도메인을 선택해주세요.");
		return false;
	}
	join.action = "join_ok.jsp";
	join.method = "post";
	join.submit();
}


</script>
</head>
<body >
	<%@include file="/header.jsp"%>
	<section class="mid">
		<form name="join" id="join">
			<p><h2>회원가입</h2>
			<div>
			이름 <input type="text" name="member_name" id="name">
			</div>
			<div>
			아이디 <input type="text" name="member_id" id="id" readonly onclick="open_idcheck();"> 
			<input type="button" value="중복확인" onclick="open_idcheck();">
			</div>
			<div>비밀번호<input type="password" name="member_pwd" id="pwd1" onchange="check_pwd()"></div>
			<div>
			비밀번호 확인<input type="password" name="member_pwd2" id="pwd2" onChange="check_pwd()">
					<br>
					<span id="check"></span>
				</div>
				<div>
				닉네임<input type="text" name="member_nick" id="nick"></td>
				</div>
				<div>
				이메일<input type="text" name="member_email" id="email1" class="box"> @
					<input type="text" name="email2" id="email2" class="box">
					
					<select name="email_select" id="email_select" onChange="checkMail();">
					<option value="" selected>선택해 주세요</option>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="kakao.com">kakao.com</option>
					<option value="nate.com">nate.com</option>
					<option value="write">직접 입력</option>
					</select>
				</div>
				<div>
				<input type="button" value="가입하기" onclick="join_check();">
				<input type="reset" value="다시 작성">
				<input type="button" value="취소하기" onclick="history.back();">
				</div>
		</form>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>