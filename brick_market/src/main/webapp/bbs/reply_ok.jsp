<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="rdto" class="com.team4.reply.ReplyDTO" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="rdto" />
<jsp:useBean id="rdao" class="com.team4.reply.ReplyDAO" scope="session"></jsp:useBean>
<%
int bbs_idx = rdto.getReply_bbs_idx();
int write_idx = rdto.getReply_write_idx();
String reply_content = rdto.getReply_content();
int a = rdao.replyWrite(bbs_idx, write_idx, reply_content);
%>
<script>document.write('<%=a%>');
</script>