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
int a = rdao.replyWrite(bbs_idx, write_idx, reply_content,1);
int ref=Integer.parseInt(request.getParameter("ref"));
int cp=Integer.parseInt(request.getParameter("cp"));
if(a==-1){
	%><script>document.alert('댓글 작성 실패');
	</script><%
}%>
<script>
location.href='content.jsp?bbs_idx=<%=bbs_idx%>&cp=<%=cp%>&ref=<%=ref%>';
</script>