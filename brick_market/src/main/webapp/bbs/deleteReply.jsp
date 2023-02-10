<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="rdao" class="com.team4.reply.ReplyDAO" scope="session"></jsp:useBean>
<%
int bbs_idx=0;
int ref=0;
int idx=0;
if(request.getParameter("bbs_idx")!=null&&request.getParameter("ref")!=null){
	
	bbs_idx=Integer.parseInt(request.getParameter("bbs_idx"));
	ref=Integer.parseInt(request.getParameter("ref"));
	int resert=rdao.dedleteReply(ref,bbs_idx);
	if(resert>=1){
		
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
}%>
