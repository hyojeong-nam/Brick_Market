<%@page import="java.util.Locale.Category"%>
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
<link rel="styLesheet" type="text/css"
	href="/brick_market/css/maincss.css">
<style type="text/css">

article.content{
	display: inline-block;
	margin: auto;
	witdh: 250px;
}

.imgarea {
	line-height: 250px;
}

.imgarea .img {
	width: 200px;
	height: 220px;
	object-fit: cover;
	vertical-align: middle;
}
.left, .right {
	display:flex;
    justify-content:center;
    align-items:center;
}
.sideimg {
	width: 50px;
	height: 50px;
	object-fit: cover;
	vertical-align: middle;
}
h3 {
	text-align: center;
}
.subject {
	text-decoration: none;
	color: black;
}

.subject:hover {
	text-decoration: underline;
	color: skyblue;
}
</style>
<script>
function articleTime(str){
	var strY=str.substring(0,4);
	var strM=parseInt(str.substring(5,7))-1;
	var strD=str.substring(8,10);
	var strH=str.substring(11,13);
	var strMi=str.substring(14,16);
	var strS=str.substring(17,19);
	var date=new Date(strY,strM,strD,strH,strMi,strS);
	var today=new Date();
	var dayma= today-date;
	if(dayma<60*1000){//1분
		return '방금전';
	}else if(dayma<1000*60*60){//1시간
		var mi=Math.floor(dayma/(1000*60));//분구하기
		return mi+'분전';
	}else if(dayma<1000*60*60*24){//24시간
		var h=Math.floor(dayma/(1000*60*60));//시간구하기
		return h+'시간전';
	}else if(dayma<1000*60*60*24*7){
		var d=Math.floor(dayma/(1000*60*60*24));
		return d+'일전';
	}else{
		return '일주일 이상';
	}
}
</script>
</head>
<%
String keyword = request.getParameter("keyword");
String category_s = request.getParameter("category");
String status_s = request.getParameter("status");

int category = -1;
int status = -1;
String str_status = "판매중";
if (!(category_s.equals(null) || category_s.length() == 0)){
	category = Integer.parseInt(category_s);
}
if (!(status_s.equals(null) || status_s.length() == 0)){
	status = Integer.parseInt(status_s);
	switch (status){
	case 0:
		str_status = "판매중";
		break;
	case 1:
		str_status = "예약 완료";
		break;
	case 2:
		str_status = "거래 완료";
		break;
	}
}



String page_s = request.getParameter("page");
if (page_s == null || page_s.equals("")) {
	page_s = "1";
}
int size = 4;
int pagenum = Integer.parseInt(page_s);
int select = 0;
int totalcnt = bdao.getTotalCnt(keyword,category,status);
ArrayList<BbsDTO> arr = bdao.bbsList(size, pagenum, select, keyword, category, status);
%>
<body>
	<%@ include file="/header.jsp"%>
	<section class="left">
		<%
		if (pagenum > 1) {
			%>
			<a href="/brick_market/bbs/list.jsp?page=<%=pagenum-1 %>&status=<%=status %>&category=<%=category %>&keyword=<%=keyword%>">
			<img class="sideimg" src="/brick_market/img/left.jpg" alt="왼쪽 페이지 이동">
			</a>
			<%
		}
		%>
	</section>
	<section class="right">
		<%
		if (pagenum * size + select < totalcnt) {
			%>
			<a href="/brick_market/bbs/list.jsp?page=<%=pagenum+1 %>&status=<%=status %>&category=<%=category %>&keyword=<%=keyword%>">
			<img class="sideimg" src="/brick_market/img/right.jpg" alt="오른쪽 페이지 이동">
			</a>
			<%
		}
		%>
	</section>
	<section class="mid">
		<h3>검색어 : "<%=keyword %>" 카테고리 : "<%=bdao.stringCategory(category) %>" 상태 : <%=str_status %></h3>
		<%
		if (arr == null || arr.size() == 0) {
		%>
		<article class="content">
			<div>검색된 글이 없습니다.</div>
		</article>
		<%
		} else {
		for (int i = 0; i < arr.size(); i++) {
		%>
		<article class="content">
			<div>
			<script>
			var str = '<%=arr.get(i).getBbs_date_s()%>';
			var msg = articleTime(str);
			document.write(msg);
			</script>
			</div>
			<a class="subject" href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>">
			<div class="imgarea">
				<img class="img" src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>">
			</div>
			<div>
				<span><%=arr.get(i).getBbs_subject()%></span>
			</div>
			</a>
			<div>
			<%
			int price = arr.get(i).getBbs_price();
			String price_s = "";
			if (price >= 100000000){
				price_s = (price / 100000000) + "억 원";
			}else if(price >= 10000){
				price_s = (price / 10000) + "만 원";
			}else {
				price_s = price + "원";
			}
			%>
				<span><%=price_s%></span>
			</div>
			
		</article>
		<%
			}
		}
		%>
	</section>
	<%@ include file="/footer.jsp"%>
</body>
</html>