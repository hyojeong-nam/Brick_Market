<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%@ page import = "com.oreilly.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdto" class="com.team4.member.MemberDTO" scope="session"></jsp:useBean>
<%
int user_idx = (int) session.getAttribute("midx");
mdto = mdao.searchIdx(user_idx);
String nick = mdto.getMember_nick();
session.setAttribute("mnick",nick);
//mdto.setMember_email(mdto.getMember_email()+email2);

String savepath = request.getRealPath("/member/img");
int size = 1024*1024*15;
MultipartRequest mr = new MultipartRequest(request,savepath,size,"UTF-8",new DefaultFileRenamePolicy());

String email2="@"+mr.getParameter("email2");
int result=mdao.joinUpdate(mr, user_idx, email2, savepath+"\\");

String msg=result>0?"회원 정보가 수정되었습니다.":"회원 정보 수정 실패했습니다.";
%>
<script>
window.alert('<%=msg %>');
window.location.href='/brick_market/member/reJoin.jsp';
</script>