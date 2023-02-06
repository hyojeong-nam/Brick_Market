<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="rdto" class="com.team4.report.ReportDTO"></jsp:useBean>
<jsp:setProperty property="*" name="rdto"/>
<jsp:useBean id="rdao" class="com.team4.report.ReportDAO"></jsp:useBean>
<%
int midx=(int)session.getAttribute("midx");
int ridx=Integer.parseInt(request.getParameter("report_user"));
String content=request.getParameter("report_content");

int result=rdao.addReport(ridx, midx, content);

String msg=result>0?"신고가 완료되었습니다":"신고 실패하였습니다.";
%>
<script>
window.alert('<%=msg %>');
window.history.go(-2);
</script>