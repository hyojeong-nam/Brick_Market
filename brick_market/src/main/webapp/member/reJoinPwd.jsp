<%
request.setCharacterEncoding("utf-8");
%>
<%@ page import = "com.oreilly.servlet.*"%>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdto" class="com.team4.member.MemberDTO" scope="session"></jsp:useBean>

<%
//유저 idx와 유저가 입력한 새 pwd
int user_idx = (int) session.getAttribute("midx");
String pwd=request.getParameter("member_pwd");

//현재 사용 중인 비밀번호(변경 전) 가져오기
mdto=mdao.searchIdx(user_idx);
String original=mdto.getMember_pwd();

//현재 비밀번호=바꾸는 비밀번호가 같으면 알림창
if(original.equals(pwd)){
%>
<script>
window.alert('현재와 다른 비밀번호를 입력해 주세요.');
window.location.href='/brick_market/member/reJoin.jsp';
</script>
<% 	
} else {

String savepath = request.getRealPath("/member/img");
int size = 1024*1024*15;
MultipartRequest mr = new MultipartRequest(request,savepath,size,"UTF-8");

int result=mdao.pwdUpdate(mr,user_idx, pwd);
String msg=result>0?"비밀번호가 변경되었습니다":"비밀번호 변경 실패했습니다.";
%>
<script>
window.alert('<%=msg %>');
window.location.href='/brick_market/member/reJoin.jsp';
</script>
<%
}
%>