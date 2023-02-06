<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="ldao" class="com.team4.like.LikeDAO"></jsp:useBean>

<%

if(request.getParameter("bbs_idx")==null||request.getParameter("user_idx")==null||request.getParameter("check")==null){
	%>
	<script>
	window.alert('잘못된 접근입니다');
	window.location.href='/brick_market/index.jsp';
	</script>
	<% 
}
int bbs_idx=Integer.parseInt(request.getParameter("bbs_idx"));
int user_idx=Integer.parseInt(request.getParameter("user_idx"));
int check=Integer.parseInt(request.getParameter("check"));
if(check==1){
	ldao.updateLike(0, bbs_idx, user_idx);
}else if(check==0){
	ldao.updateLike(1, bbs_idx, user_idx);
	
}else{
	ldao.insertLike(bbs_idx, user_idx);
}

if (request.getParameter("cp")!=null){
	
	int cp= Integer.parseInt(request.getParameter("cp"));
	%>
	<script>
	window.location.href='likeList.jsp?cp=<%=cp%>';
	</script><%
}else{
%>
<script>
window.location.href='content.jsp?bbs_idx=<%=bbs_idx%>';
</script>
<%}%>