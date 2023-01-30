<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>    
<%@page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="wdto" class="com.team4.bbs.BbsDTO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="wdto"/>
<jsp:useBean id="wdao" class="com.team4.bbs.BbsDAO"></jsp:useBean>

<%

%>

<%int result=wdao.bbsWrite(wdto); 
String msg=result>0?"상품등록 완료!":"상품등록 실패!";
%>
<script>
window.alert("<%=msg %>");
location.href="/brick_market/index.jsp";
</script>