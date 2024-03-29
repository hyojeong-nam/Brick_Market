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
input[type=file]::file-selector-button {
  float:right;
  width: 80px;
  height: 30px;
  background: #fff;
  border: 1px solid rgb(77,77,77);
  border-radius: 10px;
  cursor: pointer;
  font-family: inherit;
  }
}
.td1{
	text-align: center;
}
#h {
	font-size: 30px;
	margin-top: 0px;
	margin-bottom: 30px;
}

t1 {
	text-align: center;
	margin: 0px auto;
}

t2{
	text-align: center;
	margin: 0px auto;
}
t3{
	margin: 4px;
	border:2px;
	padding: 5px;
}

.profile_img {
	border:1px solid rgba(243,114,62,1);
	height: 150px;
	width: 150px;
	object-fit: cover;
}
.textbox {
	width: 200px;
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
.idbox{
	width: 200px;
	height:10px;
	margin-bottom: 3px;
	margin-top: 4px;
	padding: 13px;
	border: none;
	border-radius: 3px
	font-family: inherit;
}
.idbox:focus{
	outline: none;
}

.box {
	width: 110px;
	padding: .7em .2em;
	font-family: inherit;
	border-radius: 3px;
}
#wrap{
  display: flex;
  justify-content: center;
  align-items:center;
  min-height: 70vh;
}
#go {
	width: 80px;
	background-color: rgb(245,147,109);
	border-color: transparent;
	color: white;
	padding: 8px;
	margin-top: 30px;
	margin-bottom: 5px;
	border-radius: 10px 10px 10px 10px;
	font-family: inherit;
}
#go2 {
	width: 50px;
	background-color: rgb(245,147,109);
	border-color: transparent;
	color: white;
	padding: 8px;
	margin-top: 3px;
	margin-bottom: 5px;
	border-radius: 10px 10px 10px 10px;
	font-family: inherit;
}
#re {
	width: 80px;
	background-color: lightgrey;
	border-color: transparent;
	color: black;
	padding: 8px;
	border-radius: 10px 10px 10px 10px;
	font-family: inherit;
}
#re2 {
	width: 50px;
	background-color: lightgrey;
	border-color: transparent;
	color: black;
	padding: 8px;
	border-radius: 10px 10px 10px 10px;
	font-family: inherit;
}
.typeHidden{
	text-align:right
}
#rejoin{
	border:10px solid;
	border-color:rgba(243,114,62,0.3);
	border-radius: 15px;
	width: 600px;
	margin-bottom: 80px;
	padding-left: 10%;
}
table{
	padding-left:-10%;
	padding-bottom: 10px;
}
tbody tr td h2{
	padding-top: 10%
}
#t3_bottom{
	padding-bottom: 10%
}

summary::marker{
	font-size:0;
    font-family: inherit;
    width: 120px;
    margin-top: 5px;
    margin-botton: 5px;
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
	
	function noticePwd() {
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
	
	function closeDetails() {
	    document.getElementById("details").removeAttribute("open");
	    window.location = "#details";
	}
</script>
<script>
	function pwdChange(){
		var pwd1 = document.getElementById('pwd1').value;
		var pwd2 = document.getElementById('pwd2').value;
		if(pwd1 != pwd2){
			alert("입력한 비밀번호가 다릅니다. 다시 확인해 주세요.");
			return false;
		} if else{
		}
		
		else{
		document.rejoin.action="reJoinPwd.jsp";
		document.rejoin.submit();
		}	
	}
</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<article id="wrap">
		<form name="rejoin" id="rejoin" method="post" action="/brick_market/member/reJoin_ok.jsp" enctype="multipart/form-data">
			<table id="t1">
			<tr>
			<td colspan="3"><h2 id="h">회원 정보</h2></td>
			</tr>
			<tr>
			<td class="td1">
			<img class="profile_img" alt="profile" src="<%=dto.getMember_img()%>"><br> 
			<input type="file" id="file" accept="image/png, image/jpeg, image/jpg" name="member_img"/>
			</td>
			<td colspan="2">
			<%=dto.getMember_nick()%>님은 <%=result%>입니다.
			<br>가입일: <%=joindate %></td>
			</tr>
			</table>
			<br>
			<table id="t2">
			<tr>
			<td width="120" class="td1">이름</td>
			<td width="300"><input type="text" name="member_name" value="<%=dto.getMember_name()%>" class="textbox" required></td>
			</tr>
			
			<tr>
			<td class="td1">아이디</td>
			<td><input type="text" name="member_id" value="<%=dto.getMember_id()%>" class="idbox" readonly required></td>
			</tr>
			
			<tr>
			
			<td width="120">
			비밀번호
			</td>
			
			<td class="td1">
			<details id="details">
    			<summary>비밀번호 변경하기</summary>
   	 		<p>
   	 		변경할 비밀번호<br><input type="password" name="member_pwd" id="pwd1" onchange="noticePwd()" class="textbox"> 
			<br>
			변경할 비밀번호 확인<br>
			<input type="password" name="member_pwd2" id="pwd2" onchange="noticePwd()" class="textbox">
			<br>
			<span id="check"></span>
			<br>
			<input type="button" value="변경" id="go2" onclick="pwdChange()"> 
			<input type="button" value="취소" id="re2" onclick="closeDetails()">
   	 		</p>
			</details>
			</td>
			</tr>
			
			<tr>
			<td class="td1"> 닉네임 </td>
			<td><input type="text" name="member_nick" value="<%=dto.getMember_nick()%>" class="textbox" required></td>
			</tr>
			</table>
			
			<table id="t3">
			<tr>
			<td width="120" class="td1" >이메일</td>
			<td colspan="2" width="400"><input type="text" name="member_email" id="email1" value="<%=email_id%>" class="textbox2" required> 
					@ <input type="text" name="email2" id="email2" class="textbox2" value="<%=email2%>" required>
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
			<td colspan="2" id="t3_bottom"><input type="submit" value="수정하기" id="go"> 
			<input type="button" value="취소하기" id="re" onclick="history.back();">
			</td>
			</tr>	
			</table>
		  </form>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>