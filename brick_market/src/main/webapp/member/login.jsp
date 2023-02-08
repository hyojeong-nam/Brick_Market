<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="/brick_market/css/maincss.css">
<style>
.account {
	width: 220px;
    margin-bottom: 3px;
    padding: 13px;
    border: 1px solid lightgray;
    border-radius: 3px;
}
#h{
font-size:30px;
margin-top: 0px;
margin-bottom: 40px;
}
#wrap{
  display: flex;
  justify-content: center;
  align-items:center;
  min-height: 45vh;
}
#login {
    width: 80%;
    background-color: rgb(245,147,109);
    border-color: transparent;
    color: white;
    padding: 8px;
    margin-top: 8px;
    margin-bottom: 5px;
    border-radius:10px 10px 10px 10px;
    font-family: inherit;
}
#idk{
    width: 80%;
    background-color: lightgrey;
    border-color: transparent;
    color: black;
    padding: 8px;
    border-radius:10px 10px 10px 10px;
    font-family: inherit;
}
#saveid{
margin-top:10px;
margin-bottom: 10px;
}
</style>
</head>
<%
	String saveid ="";
	Cookie cks[] = request.getCookies();
	if(cks!=null){
		for(int i=0;i<cks.length;i++){
			if(cks[i].getName().equals("saveid")){
				saveid = cks[i].getValue();	
			}
		}
	}
%>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<article id="wrap">
		<form name="login" action="login_ok.jsp" method="post">
			<div>
			<h1 id="h">로그인</h1>
			
				<label><input type="text" name="userid" id="userid" placeholder="Id" class="account" value="<%=saveid %>" required></label>
			
				<label><br><input type="password" name="userpwd" id="userpwd" placeholder="Password" class="account" required></label>
			
			<label><br><input type = "checkbox" name = "saveid" id="saveid" value ="on" 
			<%=saveid.equals("")?"":"checked" %>>아이디 저장</label>
			
			<label><input type="submit" id="login" value="로그인"></label>
			
			<label><input type="button" id="idk" value="아이디/비밀번호 찾기"></label>
			</div>
		</form>
		</article>
	</section>
		<%@include file="/footer.jsp"%>
</body>
</html>