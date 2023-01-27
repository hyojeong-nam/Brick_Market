<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.*"%>
<jsp:useBean id="imgdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<% 
	String sid=(String)session.getAttribute("sid");
	String savepath=request.getRealPath("/bbs/img");
	MultipartRequest mr=new MultipartRequest(request,savepath,2097152,"utf-8");
	//int result=imgdao.addImg(mr,sid);
	//String msg=result>0?"이미지 업로드 성공":"이미지 업로드 실패";
%>
<script>
window.alert("<%= %>");
opener.location.reload();
window.self.close();
</script>