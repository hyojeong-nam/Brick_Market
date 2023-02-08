<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="/brick_market/css/maincss.css">
<style>
.textbox {
	width: 250px;
	height:10px;
	margin-bottom: 3px;
	margin-top: 4px;
	padding: 13px;
	border: 1px solid lightgray;
	border-radius: 3px;
	font-family: inherit;
}
.textbox2 {
	width: 85px;
	height:10px;
	margin-bottom: 3px;
	padding: 13px;
	border: 1px solid lightgray;
	border-radius: 3px;
	font-family: inherit;
}
.re {
	width: 80px;
	background-color: lightgrey;
	border-color: transparent;
	color: black;
	padding: 8px;
	border-radius: 10px 10px 10px 10px;
	font-family: inherit;
}
.box {
	width: 110px;
	padding: .7em .2em;
	font-family: inherit;
	border-radius: 3px;
}
article form div{
text-align:left;
text-weight :bold;
margin-bottom: 10px;
}
.but{
text-align:Center;
}
#h {
	font-size: 30px;
	margin-top: 0px;
	margin-bottom: 30px;
}
#go {
	width: 80px;
	background-color: rgb(245,147,109);
	border-color: transparent;
	color: white;
	padding: 8px;
	margin-bottom: 5px;
	border-radius: 10px 10px 10px 10px;
	font-family: inherit;
	margin-top: 13px;
}
#wrap{
  display: flex;
  justify-content: center;
  align-items:center;
  min-height: 50vh;
}
</style>
<script>
	function open_idcheck() {
		var option="width=450, height=150, top=100, left=120";
		window.open('idCheck.jsp', 'idCheck',option)
	}
</script>
<script>
	function checkMail() {
		if (join.email_select.value == 'write') {
			join.email2.readonly = false;
			join.email2.value = '';
			join.email2.focus();
		} else {
			join.email2.readonly = true;
			join.email2.value = join.email_select.value;
		}
	}
</script>

<script>
	function check_pwd() {
		var pwd1 = document.getElementById('pwd1').value;
		var pwd2 = document.getElementById('pwd2').value;

		if (pwd1 != '' && pwd2 != '') {
			if (pwd1 == pwd2) {
				document.getElementById('check').innerHTML = '비밀번호가 일치합니다.'
				document.getElementById('check').style.color = 'blue';
				return true;
			} else {
				document.getElementById('check').innerHTML = '비밀번호가 일치하지 않습니다.';
				document.getElementById('check').style.color = 'red';
				return false;
			}
		}
	}

	function join_check() {
		var pwd1 = document.getElementById('pwd1').value;
		var pwd2 = document.getElementById('pwd2').value;

		if (document.getElementById('name').value == null
				|| document.getElementById('name').value == "") {

			alert("이름을 입력해주세요.");
			return false;
		}

		if (document.getElementById('id').value == null
				|| document.getElementById('id').value == "") {

			alert("아이디를 입력해주세요.");
			return false;
		}
		if (document.getElementById('pwd1').value == null
				|| document.getElementById('pwd1').value == "") {

			alert("비밀번호를 입력해주세요.");
			return false;
		}
		if (pwd1 != pwd2) {
			alert("비밀번호를 확인해 주세요.");
			return false;
		}

		if (document.getElementById('nick').value == null
				|| document.getElementById('nick').value == "") {

			alert("닉네임을 입력해주세요.");
			return false;
		}

		if (document.getElementById('email1').value == null
				|| document.getElementById('email1').value == "") {

			alert("이메일을 입력해주세요.");
			return false;
		}
		if (document.getElementById('email2').value == null
				|| document.getElementById('email2').value == "") {

			alert("도메인을 선택해주세요.");
			return false;
		}
		join.action = "join_ok.jsp";
		join.method = "post";
		join.submit();
	}
</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<article id="wrap">
			<form name="join" id="join">
				<p>
				<h2 id="h">회원가입</h2>
				<div>
					이름<br> <input type="text" name="member_name" id="name" placeholder="Name" class="textbox">
				</div>

				<div>
					아이디<br> <input type="text" name="member_id" id="id"
						class="textbox" placeholder="Id" readonly onclick="open_idcheck();">
						<input type="button" value="중복 확인" class="re" onclick="open_idcheck();" >
				</div>
				<div>
					비밀번호<br> <input type="password" name="member_pwd" id="pwd1"
						class="textbox" placeholder="Password" onchange="check_pwd()">
				</div>
				<div>
					비밀번호 확인<br>
					<input type="password" name="member_pwd2" id="pwd2" class="textbox"
						onChange="check_pwd()" placeholder="Password"> <br> <span id="check"></span>
				</div>

				<div>
					닉네임<br> <input type="text" name="member_nick" id="nick"
						placeholder="Nickname" class="textbox">
				</div>

				<div class="box_domain">
					이메일<br>
					<input type="text" name="member_email" placeholder="Email" id="email1" class="textbox2"> 
						@ 
						<input type="text" name="email2" id="email2" class="textbox2"> 
					<select name="email_select" id="email_select" onChange="checkMail();" class="box">
						<option value="" selected>선택해 주세요</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="kakao.com">kakao.com</option>
						<option value="nate.com">nate.com</option>
						<option value="write">직접 입력</option>
					</select>
				</div>

				<div class="but">
					<input type="button" value="가입하기" id="go" onclick="join_check();">
					<input type="reset" value="다시 작성" class="re"> 
					<input type="button" value="취소하기" class="re" onclick="history.back();">
				</div>

			</form>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>