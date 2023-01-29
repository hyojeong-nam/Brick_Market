<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="mdto" class="com.team4.member.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"></jsp:useBean>
<%
String email="@"+request.getParameter("email2");

int result=mdao.joinMember(mdto, email);

String msg=result>0?"회원가입을 축하합니다.":"회원가입에 실패하였습니다.";
%>
<script>
window.alert('<%=msg %>');
window.location.href='/brick_market/index.jsp';
</script>