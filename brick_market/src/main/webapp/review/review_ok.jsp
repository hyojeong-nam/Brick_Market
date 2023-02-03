<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="rdao" class="com.team4.review.ReviewDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdto" class="com.team4.review.ReviewDTO" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="rdto"/>

<% 
int review_writer_idx=Integer.parseInt(request.getParameter("midx"));
int bbs_idx=Integer.parseInt(request.getParameter("bbs_idx"));

int result=rdao.reviewWrite(rdto);
String msg=result>0?"리뷰등록 성공!":"리뷰등록 실패!";
%>
<script>
	alert(<%=msg%>);
	location."/brick_market/index.jsp";
</script>