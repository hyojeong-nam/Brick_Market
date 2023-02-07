<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session">
</jsp:useBean>
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
	line-height: 200px;
}

.imgarea .img {
	width: 200px;
	height: 200px;
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
ul li{
list-style-type: none;
}
.mid {
width:1000px;
overflow: hidden;
}
.content{
width: 3000px;
}
.ultag{
width: 3000px;
transition:transform 0.5s;
}
.litag{
width: 250px;
float: left;

}
.button{
margin-top: 50px;
}
.button input:hover {
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

function button1() {
	document.querySelector('.ultag').style.transform='translate(0vw)';
}
function button2() {
	document.querySelector('.ultag').style.transform='translate(-80vw)';
}
function button3() {
	document.querySelector('.ultag').style.transform='translate(-160vw)';
}
</script>
</head>
<%
String page_s = request.getParameter("page");
if (page_s == null || page_s.equals("")) {
	page_s = "1";
}
int size = 1;
int pagenum = Integer.parseInt(page_s);
int select = 11;
int totalcnt = bdao.getTotalCnt();
ArrayList<BbsDTO> arr = bdao.bbsList(size, pagenum, select);
%>
<body>
	<%@ include file="header.jsp"%>
	<section class="left">
	</section>
	<section class="right">
	</section>

	<section class="mid">
		<h3>최신글 보기</h3>
		<article class="content">
		<ul class="ultag">
		<%
		if (arr == null || arr.size() == 0) {
		%>
			<li><div>등록된 최신글이 없습니다.</div></li>
		<%
		} else {
		for (int i = 0; i < arr.size(); i++) {
		%>
			<li class="litag">
			<div>
			<script>
			var str = '<%=arr.get(i).getBbs_date_s()%>';
			var msg = articleTime(str);
			document.write(msg);
			</script>
			</div>
			<a class="subject" href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>">
			<div class="imgarea"><img class="img" src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>"></div>
			<div><span><%=arr.get(i).getBbs_subject()%></span></div>
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
			</li>
		<%
			}
		}
		%>
		</ul>
		</article>
		<article class="mid">
		<div class="button">
		<input type="button" onclick="javascript:button1();" value="1">
		<input type="button" onclick="javascript:button2();" value="2">
		<input type="button" onclick="javascript:button3();" value="3">
		</div>
		</article>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>