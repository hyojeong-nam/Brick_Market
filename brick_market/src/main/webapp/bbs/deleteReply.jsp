<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="rdao" class="com.team4.reply.ReplyDAO" scope="session"></jsp:useBean>
<%
int bbs_idx=0;
int reply_idx=0;
request.getParameter("bbs_idx");
request.getParameter("reply_idx");
if(request.getParameter("bbs_idx")!=null||request.getParameter("bbs_idx").equals("0")){
	bbs_idx=Integer.parseInt(request.getParameter("bbs_idx"));
}else{
	%>
	<script>window.alert('잘못된 접근입니다');
	window.location.href = '/brick_market/index.jsp';
	</script>
	<%
}
if(request.getParameter("reply_idx")!=null||request.getParameter("reply_idx").equals("0")){
	reply_idx=Integer.parseInt(request.getParameter("reply_idx"));
	int resert=rdao.dedleteReply(reply_idx);
	if(resert==1){
		
	%>
	<script>
	window.location.href ='content.jsp?bbs_idx=<%=bbs_idx%>';
	</script><%
	}else{
	%><script>
	window.alert('삭제실패');
	window.location.href ='content.jsp?bbs_idx=<%=bbs_idx%>';
	</script><% 
	}
}else{
	%>
	<script>window.alert('잘못된 접근입니다');
	window.location.href = '/brick_market/index.jsp';
	</script>
	<%
}

%>