<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="rdao" class="com.team4.review.ReviewDAO" ></jsp:useBean>
<jsp:useBean id="rdto" class="com.team4.review.ReviewDTO" ></jsp:useBean>
<jsp:setProperty property="*" name="rdto"/>

<% 
int result=rdao.reviewWrite(rdto);
String msg=result>0?"리뷰등록 성공!":"리뷰등록 실패!";
%>
<script>
	alert('<%=msg%>');
	location.href='/brick_market/index.jsp';
	window.close();
	opener.location.reload();
</script>