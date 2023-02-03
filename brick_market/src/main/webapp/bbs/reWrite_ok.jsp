<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>    
<%@page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="redto" class="com.team4.bbs.BbsDTO" scope="page"></jsp:useBean>
<jsp:useBean id="redao" class="com.team4.bbs.BbsDAO"></jsp:useBean>
<%
String savepath=request.getRealPath("/bbs/img");
int size = 1024*1024*15;
MultipartRequest mr=
	new MultipartRequest(request, savepath, size, "utf-8", new DefaultFileRenamePolicy());

int bbs_idx = Integer.parseInt(mr.getParameter("bbs_idx"));

int result=redao.bbsReWrite(mr, bbs_idx, savepath+"\\");
String msg=result>0?"상품정보 수정완료!":"상품정보 수정실패!";
%>
<script>
window.alert("<%=msg %>");
location.href="/brick_market/index.jsp";
</script>