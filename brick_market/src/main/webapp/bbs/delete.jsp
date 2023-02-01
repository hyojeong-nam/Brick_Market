<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="ddao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"
	scope="session"></jsp:useBean>
<%
int bidx=Integer.parseInt(request.getParameter("bbs_idx"));
int widx=Integer.parseInt(request.getParameter("bbs_writer_idx"));
int midx=(int)session.getAttribute("midx");

if(widx!=midx){
	%>
	<script>
	window.alert("삭제권한이 없습니다.");
	location.href='/brick_market/bbs/content.jsp?bbs_idx=<%=bidx%>';
	
	</script>
	<% 
	
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section>
		<article>
			<form name=delBbs action="delete_ok.jsp">
				<div>삭제된 게시글은 복구할 수 없습니다.</div>
				<div>삭제하시겠습니까?(원할시 비밀번호 입력)</div>
				<input type="hidden" name="midx" value=<%=midx %>>
				<input type="hidden" name="bidx" value=<%=bidx %>>
				<input type="password" name="pwd" placeholder="비밀번호">
				<input type="submit" value="삭제하기">
				<input type="button" value="취소하기" 
				onclick="location.href='/brick_market/bbs/content.jsp?bbs_idx=<%=bidx%>'">
			</form>
		</article>
	</section>
</body>
</html>