<%
request.setCharacterEncoding("utf-8");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"></jsp:useBean>

<% 

String userpwd=request.getParameter("userpwd");
int user_idx=(int)session.getAttribute("midx");

boolean result=mdao.checkPwd(user_idx, userpwd);

if(result){
	%>
	<script>
	window.location.href='/brick_market/member/reJoin.jsp';
	</script>
	<%
} else{
	%>
	<script>
	window.alert('비밀번호가 틀렸습니다. 다시 입력해 주세요.');
	window.location.href='/brick_market/member/pwdCheck.jsp';
	</script>
	<%
}
%>