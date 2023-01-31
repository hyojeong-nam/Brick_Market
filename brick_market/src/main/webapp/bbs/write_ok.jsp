<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>    
<%@page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="wdto" class="com.team4.bbs.BbsDTO" scope="page"></jsp:useBean>
<jsp:useBean id="wdao" class="com.team4.bbs.BbsDAO"></jsp:useBean>
<%
<<<<<<< HEAD
String realFolder="";
String saveFolder = "/brick_market/img";		
String encType = "utf-8";			
int maxSize=5*1024*1024;				
		
ServletContext context = this.getServletContext();		
realFolder = context.getRealPath(saveFolder);			
		
MultipartRequest multi = new MultipartRequest(request,realFolder,maxSize,encType);


String bbs_img = multi.getFilesystemName("bbs_img");
String bbs_subject = multi.getParameter("bbs_subject");
String bbs_content = multi.getParameter("bbs_content");
int bbs_category=Integer.parseInt(multi.getParameter("bbs_category"));

wdto.getBbs_subject();
wdto.getBbs_content();
wdto.getBbs_category();
%>

<%int result=wdao.bbsWrite(wdto); 
=======
String savepath=request.getRealPath("/bbs/img");
MultipartRequest mr=
	new MultipartRequest(request,savepath,2097152,"utf-8");
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
>>>>>>> eb8f6784a686bb20e65bc3bb5b5aed3326f069b9
String msg=result>0?"상품등록 완료!":"상품등록 실패!";
%>
<script>
window.alert("<%=msg %>");
location.href="/brick_market/index.jsp";
</script>