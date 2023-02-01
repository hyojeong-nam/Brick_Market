<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mdaoheader" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdtoheader" class="com.team4.member.MemberDTO" scope="session"></jsp:useBean>
<jsp:useBean id="bdtoheader" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<header>
	<div class="log">
		<%
		int midx = 0;
		if (session.getAttribute("midx") == null || session.getAttribute("midx").equals("")
				|| session.getAttribute("midx").equals("0")) {
		%>
		<a href="/brick_market/member/login.jsp">로그인</a> | <a
			href="/brick_market/member/join.jsp">회원가입</a>
		<%
		} else {
		midx = (Integer) session.getAttribute("midx");
		mdtoheader = mdaoheader.searchIdx(midx);
		%>
		<%=mdtoheader.getMember_nick()%> 님 안녕하세요~  <a href="/brick_market/member/pwdCheck.jsp">회원정보</a> | <a
			href="/brick_market/member/logout.jsp">로그아웃</a>
	</div>
	<%
	}
	%>
	<a href="/brick_market/index.jsp"><img
		src="/brick_market/img/logo.png" alt="메인로고"></a>
	<div class="style">
		<form name="search" action="/brick_market/bbs/list.jsp">
			<select name="status">
				<option value="0" selected="selected">판매중</option>
				<option value="1">예약 완료</option>
				<option value="2">거래 완료</option>
			</select> <select name="category">
				<option value="-1" selected="selected"><%=bdtoheader.stringCategory(-1)%></option>
				<option value="0"><%=bdtoheader.stringCategory(0)%></option>
				<option value="1"><%=bdtoheader.stringCategory(1)%></option>
				<option value="2"><%=bdtoheader.stringCategory(2)%></option>
				<option value="3"><%=bdtoheader.stringCategory(3)%></option>
				<option value="4"><%=bdtoheader.stringCategory(4)%></option>
			</select> 
				<input type="text" name="keyword"> <input type="submit" value="검색">
		</form>
		<span>내상점</span> <span><a href="/brick_market/bbs/write.jsp">상품등록</a></span>
		<span><a href="/brick_market/bbs/likeList.jsp">좋아하는 글</a></span>
	</div>
	<nav>
		<ul>
			<li><a href="/brick_market/bbs/list.jsp?status=0&category=0&keyword="><%=bdtoheader.stringCategory(0)%></a></li>
			<li><a href="/brick_market/bbs/list.jsp?status=0&category=1&keyword="><%=bdtoheader.stringCategory(1)%></a></li>
			<li><a href="/brick_market/bbs/list.jsp?status=0&category=2&keyword="><%=bdtoheader.stringCategory(2)%></a></li>
			<li><a href="/brick_market/bbs/list.jsp?status=0&category=3&keyword="><%=bdtoheader.stringCategory(3)%></a></li>
			<li><a href="/brick_market/bbs/list.jsp?status=0&category=4&keyword="><%=bdtoheader.stringCategory(4)%></a></li>
		</ul>
	</nav>
	<div class="aa">
		<a>이용가이드</a> <a href="/brick_market/report/reportList.jsp">신고조회</a>
	</div>
	<hr>
</header>