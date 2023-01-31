<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"></jsp:useBean>

<% 
String userpwd=request.getParameter("userpwd");
int user_idx=(int)session.getAttribute("midx");

boolean result=mdao.checkPwd(user_idx, userpwd);
if(true){
	%>
	<script>
	window.alert('<%=msg %>');
	window.location.href='/brick_market/index.jsp';
	</script>
	
} else{
	
}
%>