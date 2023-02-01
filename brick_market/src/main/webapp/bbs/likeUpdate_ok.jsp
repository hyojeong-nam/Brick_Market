<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="ldao" class="com.team4.like.LikeDAO"></jsp:useBean>
<%
request.getParameter("bbs_idx");
request.getParameter("user_idx");
request.getParameter("check");
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
%>
<script>
window.location.href='content.jsp?bbs_idx=<%=bbs_idx%>';
</script>