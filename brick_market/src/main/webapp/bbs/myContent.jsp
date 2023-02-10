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
	float: left;
	width: 250px;
	height: 300px;
	margin: auto;
	padding-top: 10px;
	display: inline-block;
	transition-duration: 0.3s;
}

article.content:hover{
	box-shadow: 0px 0px 3px 2px gray;
	background-color:white;
	transform: scale(1.1);
	z-index:1;
}
.imgarea {
	line-height: 200px;
}

.imgarea .img {
	width: 200px;
	height: 220px;
	object-fit: cover;
	vertical-align: middle;
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
.left .btn, .right .btn{
	width:100%;
	height:100%;
	display:flex;
    justify-content:center;
    align-items:center;
	margin:0px 0px;
	
}
.fake{
	opacity: 10%;
}
.real{
	transition-duration: 0.2s;
	opacity: 50%;
}
.left .btn:hover .real,.right .btn:hover .real{
	opacity: 100%;
	transform: scale(1.2);
}

.newbutton{
position:inherit;
margin-right:10px;
width: 30px;
height: 30px;
padding:2px 2px;
border-radius: 50%;
background-color:red;
font-size: 13px;
color: white;
line-height: 17px;
font-weight: bold;
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
		return '<span class="newbutton">&nbsp;N&nbsp;</span>방금전';
	}else if(dayma<1000*60*60){//1시간
		var mi=Math.floor(dayma/(1000*60));//분구하기
		return '<span class="newbutton">&nbsp;N&nbsp;</span>'+mi+'분전';
	}else if(dayma<1000*60*60*24){//24시간
		var h=Math.floor(dayma/(1000*60*60));//시간구하기
		return '<span class="newbutton">&nbsp;N&nbsp;</span>'+h+'시간전';
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
int my_idx = (int)session.getAttribute("midx");

String page_s = request.getParameter("page");
if (page_s == null || page_s.equals("")) {
	page_s = "1";
}
int size = 4;
int pagenum = Integer.parseInt(page_s);
int totalcnt = bdao.getTotalCnt(my_idx);
ArrayList<BbsDTO> arr = bdao.bbsMyList(pagenum, size, my_idx);
%>
<body>
	<%@ include file="/header.jsp"%>
		<section class="left">
			<%
			if (pagenum > 1) {
			%>
			<a class="btn" href="/brick_market/bbs/myContent.jsp?page=<%=pagenum-1 %>">
				<img class="sideimg real" src="/brick_market/img/left.jpg" alt="왼쪽 페이지 이동">
			</a>
			<%
			}else {
			%>
			<span class="btn">
				<img class="sideimg fake" src="/brick_market/img/left.jpg" alt="왼쪽 페이지 이동">
			</span>
			<%
			}
			%>
		</section>
		<section class="right">
			<%
			if (pagenum * size < totalcnt) {
			%>
			<a class="btn" href="/brick_market/bbs/myContent.jsp?page=<%=pagenum+1 %>">
				<img class="sideimg real" src="/brick_market/img/right.jpg" alt="오른쪽 페이지 이동">
			</a>
			<%
			}else {
			%>
			<span class="btn">
				<img class="sideimg fake" src="/brick_market/img/right.jpg" alt="오른쪽 페이지 이동">
			</span>
			<%
			}
			%>
		</section>
	<section class="mid">
		<h3>등록한 상품</h3>
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
		<a class="subject" href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>">
		<article class="content">
			<div>
			<script>
			var str = '<%=arr.get(i).getBbs_date_s()%>';
			var msg = articleTime(str);
			document.write(msg);
			</script>
			</div>
			<div class="imgarea">
				<img class="img" src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>">
			</div>
			<%
			int status = arr.get(i).getBbs_status();
			String status_s = "";
			switch(status){
			case 0:status_s = "판매중"; break;
			case 1:status_s = "예약 완료"; break;
			case 2:status_s = "거래 완료"; break;
			}
			%>
			<div style="color: blue;">[<%=status_s %>]</div>
			<div>
				<span>[<%=bdao.stringCategory(arr.get(i).getBbs_category()) %>]<%=arr.get(i).getBbs_subject()%></span>
			</div>
			<div>
			<%
			int price = arr.get(i).getBbs_price();
			String price_s = "";
			if (price >= 100000000){
				price_s = (price / 100000000) + "억 원";
			}else if(price >= 10000){
				price_s = (price / 10000) + "만 원";
			}else if(price > 0){
				price_s = price + "원";
			}else {
				price_s = "무료나눔";
			}
			%>
				<span style="color: red;"><%=price_s%></span>
			</div>
		</article>
		</a>
		<%
			}
		}
		%>
	</section>
	<%@ include file="/footer.jsp"%>
</body>
</html>