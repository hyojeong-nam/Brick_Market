
<%
request.setCharacterEncoding("utf-8");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mdto" class="com.team4.member.MemberDTO" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>
<%
String email2="@"+request.getParameter("email2");
int user_idx = (int) session.getAttribute("midx");
int result=mdao.joinUpdate(mdto,user_idx,email2);

String msg=result>0?"회원 정보가 수정되었습니다.":"회원 정보 수정 실패했습니다.";
%>
<script>
window.alert('<%=msg %>');
window.location.href='/brick_market/member/reJoin.jsp';
</script>