<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"></jsp:useBean>
<jsp:useBean id="mdto" class="com.team4.member.MemberDTO"></jsp:useBean>
<%
String userid = request.getParameter("userid");
String userpwd = request.getParameter("userpwd");
String saveid = request.getParameter("saveid");
int idx=mdao.checkLogin(userid, userpwd);
mdto = mdao.searchIdx(idx);
String nick = mdto.getMember_nick();
if(idx != -1) {
	session.setAttribute("midx",idx);
	session.setAttribute("mnick",nick);
		
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