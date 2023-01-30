<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"></jsp:useBean>
<%
String userid = request.getParameter("userid");
String userpwd = request.getParameter("userpwd");
String saveid = request.getParameter("saveid");
int result=mdao.checkLogin(userid, userpwd);

if(result != -1) {
	
	session.setAttribute("sid",userid);
	session.setAttribute("midx",result);
		
		if (saveid!=null){
			Cookie ck = new Cookie("saveid",userid);
			ck.setMaxAge(60*60*24*30);
			response.addCookie(ck);
		}else{
			Cookie ck = new Cookie("saveid",userid);
			ck.setMaxAge(0);
			response.addCookie(ck);
		}
		%>
		<script>
		location.href = '/brick_market/index.jsp';
		</script>	
		<%
}else {
	%>
	<script>
	window.alert('아이디 또는 비밀번호가 틀렸습니다.');
	location.href = 'login.jsp';
	</script>
<%
}
%>