<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class = "com.team4.member.MemberDAO"></jsp:useBean>
<%
String userid = request.getParameter("userid");
String userpwd = request.getParameter("userpwd");

boolean result = mdao.checkLogin(userid, userpwd);

if(result) {
	session.setAttribute("sid",userid);
		%>
		<script>
		location.href = '/brick_market/index.jsp';
		</script>	
	<%
}else if(result==false){
	%>
	<script>
	window.alert('아이디 또는 비밀번호가 틀렸습니다.');
	location.href = 'login.jsp';
	</script>
	<%
}else {
	out.println("고객센터에 연락 바랍니다.");
}
%>