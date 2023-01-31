<%@page import="com.team4.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>
<%@page import="com.team4.bbs.BbsDTO"%>
<%@page import="com.team4.member.MemberDTO"%>

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
if (bbs_idx == 0){
	%>
	<script>
	window.alert('잘못된 접근입니다.');	
	window.location.href='/brick_market/index.jsp';
	</script>
	<%
	return;
}
BbsDTO bdto = bdao.bbsContent(bbs_idx);

if (bdto.equals(null)){
	%>
	<script>
	window.alert('존재하지 않는 게시글입니다.');	
	window.location.href='/brick_market/index.jsp';
	</script>
	<%
	return;
}
int user_idx = bdto.getBbs_writer_idx();
System.out.println(user_idx);
MemberDTO mdto = mdao.searchIdx(user_idx);
%>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article class="container">
		<img class="item_img" alt="test" src="<%=bdto.getBbs_img()%>">
		<h2 class="title_text"><%=bdto.getBbs_subject() %></h2>
		<p class="price_text"><%=bdto.getBbs_price() %>원</p>
		<img class="profile_img" alt="test" src="<%=mdto.getMember_img()%>">
		<p class="profile_nick"><%=mdto.getMember_nick() %></p>
		<p class="profile_star">거래완료조회 ★★★★☆(23 리뷰) 평점 4.2</p>
		<pre class="item_text">
		<%=bdto.getBbs_content().replaceAll("\n", "<br>") %>
		</pre>
	</article>
<%@include file="reply.jsp" %>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>