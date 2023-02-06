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
//bbs_idx 가져오기
String bidx_s = request.getParameter("bbs_idx");
int bidx = 0;
if (bidx_s != null && bidx_s.length() != 0) {
	bidx = Integer.parseInt(bidx_s);
}

//접속 중인 유저 idx 가져오기
int user_idx=0;
user_idx = (int) session.getAttribute("midx");

//이상한 접속 차단하기
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

//bidx로 게시글 제목 가져오고, widx로 작성자 찾기
BbsDTO bdto = bdao.bbsContent(bidx);
int widx=bdto.getBbs_writer_idx();
MemberDTO mdto=mdao.searchIdx(widx);

//작성자=신고자 같을 경우 알림창 뜨기
if(widx==user_idx){
%>
<script>
	window.alert('자신이 작성한 글은 신고할 수 없습니다.');
	window.history.back();
</script>
<%
return;
}
%>
</head>
<body>
<%@include file="/header.jsp"%>
	<section class="mid">
		<article>
			<h1>신고하기</h1>
			<form name="report" method="post" action="report_ok.jsp">
			<div>
			신고글 제목 <%=bdto.getBbs_subject() %>
			</div>
			<div>
			신고 대상 <%=mdto.getMember_nick() %>
			<input type="hidden" name="report_user" value="<%=mdto.getMember_idx() %>">
			</div>
			<div>
			신고 내용
			<textarea name="report_content" placeholder="신고 내용을 자세히 입력해주세요" required></textarea>
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