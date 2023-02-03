<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="rdao" class="com.team4.reply.ReplyDAO" scope="session"></jsp:useBean>
<%
request.getParameter("reply_idx");
request.getParameter("bbs_idx");
request.getParameter("content");
if(request.getParameter("reply_idx")!=null&&request.getParameter("bbs_idx")!=null&&request.getParameter("content")!=null){
	int reply_idx=Integer.parseInt(request.getParameter("reply_idx"));
	int bbs_idx=Integer.parseInt(request.getParameter("bbs_idx"));
	int cp=Integer.parseInt(request.getParameter("cp"));
	String content=request.getParameter("content");
	int resert= rdao.updateReply(content, reply_idx);
	if(resert==1){
		%>
		<script>
		window.location.href = 'content.jsp?bbs_idx='+<%=bbs_idx%>+'&cp='+<%=cp%>;
		</script>
		<%
	}else{
		%>
		<script>window.alert('수정실패');
		window.location.href = 'content.jsp?bbs_idx='+<%=bbs_idx%>+'&cp='+<%=cp%>;
		</script>
		<%
	}
}else{
	%>
	<script>
	alert(<%=request.getParameter("reply_idx")%>);
	alert(<%=request.getParameter("bbs_idx")%>);
	alert(<%=request.getParameter("content")%>);
	window.alert('잘못된 접근입니다');
	window.location.href = '/brick_market/index.jsp';
	</script>
	<%
}
%>