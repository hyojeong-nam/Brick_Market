<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.*"%>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<%@page import="com.team4.bbs.BbsDTO"%>
<%@page import="com.team4.member.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styLesheet" type="text/css" href="/brick_market/css/maincss.css">
<%
int user_idx=0;
user_idx = (int) session.getAttribute("midx");

if (session.getAttribute("midx") == null || session.getAttribute("midx").equals("")
		|| session.getAttribute("midx").equals("0")) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	window.location.href = '/brick_market/index.jsp';
</script>
<%
return;
}

String bidx_s = request.getParameter("bbs_idx");
int bidx = 0;
if (bidx_s != null && bidx_s.length() != 0) {
	bidx = Integer.parseInt(bidx_s);
}

if(user_idx==bidx) {
	%>
<script>
	window.alert('자신의 글은 신고할 수 없습니다.');
	window.location.href = '/brick_market/index.jsp';
</script>
<%
return;
}


BbsDTO bdto = bdao.bbsContent(bidx);
MemberDTO mdto=mdao.searchIdx(bidx);


%>
</head>
<body>
<%@include file="/header.jsp"%>
	<section class="mid">
		<article>
			<h1>신고하기</h1>
			<form>
			<div>
			신고글 제목 <%=bdto.getBbs_subject() %>
			</div>
			<div>
			신고 대상 <%=mdto.getMember_nick()%>
			<input type="hidden" name="report_user" value="<%=mdto.getMember_idx() %>">
			</div>
			<div>
			신고 내용
			<textarea name="report_content"> </textarea>
			</div>
			<div>
			<input type="submit" value="등록하기">
			<input type="reset" value="다시 작성">
			<input type="button" value="취소하기" onclick="history.back();">
			</div>
			</form>
		</article>
	</section>
		<%@include file="/footer.jsp"%>
</body>
</html>