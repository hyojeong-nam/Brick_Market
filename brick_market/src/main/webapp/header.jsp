<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header>
	<div class="log">
	<%
	int midx=0;
	
	if(session.getAttribute("midx")==null) {
	%>
		<a href="/brick_market/member/login.jsp">로그인</a> | 
		<a href="/brick_market/member/join.jsp">회원가입</a>
			<%} else {
				%>
			<a href="/brick_market/member/reJoin.jsp">회원정보</a> |
			<a href="/brick_market/member/logout.jsp">로그아웃</a>
		</div>
		<%
			}
			%>
	<a href="/brick_market/index.jsp"><img
		src="/brick_market/img/logo.png" alt="메인로고"></a> 
		<form name="search" action="/brick_market/bbs/list.jsp">
			<select name="status">
				<option value="0" selected="selected">판매중</option>
				<option value="1">예약 완료</option>
				<option value="2">거래 완료</option>
			</select>
			<select name="category">
				<option value="-1" selected="selected"><%=bdao.stringCategory(-1) %></option>
				<option value="0"><%=bdao.stringCategory(0) %></option>
				<option value="1"><%=bdao.stringCategory(1) %></option>
				<option value="2"><%=bdao.stringCategory(2) %></option>
				<option value="3"><%=bdao.stringCategory(3) %></option>
				<option value="4"><%=bdao.stringCategory(4) %></option>
			</select>
			<input type="text" name="keyword">
			<input type="submit" value="검색">
		</form>
	<div class="style">
		<span>내상점</span> <span><a href="/brick_market/bbs/write.jsp">상품등록</a></span>
	</div>
	<nav>
		
		<ul>
			<li>1번</li>
			<li>2번</li>
			<li>3번</li>
			<li>4번</li>
		</ul>
	</nav>
	<div class="aa">
		<a>이용가이드</a> <a href="/brick_market/report/reportList.jsp">신고조회</a>
	</div>
	<hr>
</header>