<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>    
<%@page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="wdto" class="com.team4.bbs.BbsDTO" scope="page"></jsp:useBean>
<jsp:useBean id="wdao" class="com.team4.bbs.BbsDAO"></jsp:useBean>
<%
String savepath=request.getRealPath("/bbs/img");
int size = 1024*1024*15;
MultipartRequest mr=
	new MultipartRequest(request, savepath, size, "utf-8", new DefaultFileRenamePolicy());
//	new MultipartRequest(request,savepath,2097152,"utf-8");
int idx = (int)session.getAttribute("midx");
String imgname = mr.getOriginalFileName("upload");
/*
File orifile = new File(savepath+"/"+imgname);
if(orifile.exists()){
	File newfile = new file(savepath+"/"+idx);	
	orifile.renameTo();
}
*/
int result=wdao.bbsWrite(mr,idx); 
String msg=result>0?"상품등록 완료!":"상품등록 실패!";
%>
<script>
window.alert("<%=msg %>");
location.href="/brick_market/index.jsp";
</script>