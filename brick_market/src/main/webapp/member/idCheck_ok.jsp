<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"></jsp:useBean>
<%
String userid=request.getParameter("userid");
boolean result=mdao.idCheck(userid);

if(result){
	%>
<script>
window.alert('<%=userid%>는 이미 가입된 아이디입니다.');
location.href='idCheck.jsp';
</script>
<%
} else{
	%>
	<script>
	window.alert('<%=userid%>는 사용 가능한 아이디입니다.');
	opener.document.join.member_id.value='<%=userid%>';
	self.close();
	</script>
	<%
}
%>