<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<header>
	<div class="log">
	<%
	String sid =(String) session.getAttribute("sid");
	
	if(sid == null) {%>
		<a href="/brick_market/member/login.jsp">로그인</a> | 
		<a href="/brick_market/member/join.jsp">회원가입</a>
			<%} else {
				%>
			<a href="/brick_market/member/myPage.jsp">마이 페이지</a> |
			<a href="#" onclick="Logout();">로그아웃</a>
		</div>
		<%
			}
			%>
	<a href="/brick_market/index.jsp"><img
		src="/brick_market/img/logo.png" alt="메인로고"></a> 
		<form action="">
		<input type="text" id="star">
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