<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mdao" class = "com.team4.member.MemberDAO"></jsp:useBean>
<%
String userid = request.getParameter("userid");
String userpwd = request.getParameter("userpwd");
String saveid = request.getParameter("saveid");

boolean result = mdao.checkLogin(userid, userpwd);

if(result) {
	
	/*session.setAttribute("sid",userid);
	
		if (saveid==null){
			Cookie ck = new Cookie("saveid",userid);
			ck.setMaxAge(0);
			response.addCookie(ck);
			
		}else{
			Cookie ck = new Cookie("saveid",userid);
			ck.setMaxAge(60*60*24*30);
			response.addCookie(ck);
		}*/
		%>
		<script>
		window.alert('로그인 완료');
		opener.location.reload();
		window.self.close();
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