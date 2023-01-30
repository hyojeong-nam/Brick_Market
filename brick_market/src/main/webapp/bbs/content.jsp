<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<%@page import="java.util.*"%>
<%@page import="com.team4.bbs.BbsDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/brick_market/css/maincss.css">
<style>
.container {
	text-align:center;
	margin:0px auto;
	width:800px;
	display:grid;
	grid-template-columns: 50% 10% 40%;
	grid-template-rows: 40px 40px 40px 40px 240px auto;
	grid-template-areas:
		"item  title  title"
		"item  price  price"
		"item  proimg  nick"
		"item  proimg  star"
		"item   text   text"
		;
}

.item_img {
	height:400px;
	width:400px;
	object-fit: cover;
	grid-area:item;
}

.title_text {
	grid-area:title;
	margin:0px 0px;
}

.price_text {
	grid-area:price;
	margin:10px 10px;
	text-align: right;
	color: red;
}

.profile_img {
	height:80px;
	width:80px;
	object-fit: cover;
	grid-area:proimg;
}
.profile_nick {
	grid-area:nick;
	text-align: left;
}
.profile_star {
	grid-area:star;
	text-align: left;
}

.item_text {
	grid-area:text;
	text-align: left;
}
</style>
<%
String bbs_idx_s = request.getParameter("bbs_idx");
int bbs_idx = 0;
if(bbs_idx_s != null && bbs_idx_s.length() != 0){
	bbs_idx = Integer.parseInt(bbs_idx_s);
}
bdao.bbsContent(bbs_idx);
if (bbs_idx == 0){
	
}
%>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article class="container">
		<img class="item_img" alt="test" src="/brick_market/img/test.png">
		<h2 class="title_text">이런저런거 팔아요</h2>
		<p class="price_text">300만원</p>
		<img class="profile_img" alt="test" src="/brick_market/img/profile.png">
		<p class="profile_nick">김똘똘이</p>
		<p class="profile_star">★★★★☆(23 리뷰) 평점 4.2</p>
		<pre class="item_text">
지금까지 간단하게 display 속성값인 inline과 block, 
inline-block에 대해서 알아보았습니다. 참고로 span로
마크업된 엘리먼트가 inline 속성값을 가지고, div로 마크업된
엘리먼트가 block 속성값을 가지는 이유는 소위 user agent
stylesheet라고 불리는 브라우저의 내장 스타일이 적용되서 그렇습니다.
이렇게 HTML 태그 별로 기본적으로 적용되어 있는 display 속성값은
원하는 값으로 CSS를 이용하서 자유롭게 변경이 가능합니다.
		</pre>
	</article>
</section>
<%@include file="reply.jsp" %>
<%@include file="/footer.jsp" %>
</body>
</html>