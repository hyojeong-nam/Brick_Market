<%@page import="java.text.DecimalFormat"%>
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

article.content .litag:hover{
	
	background-color:white;
	transform: scale(1.13);
	z-index:1;
}


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
	height: 220px;
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

ul li{
list-style-type: none;
}
.mid {
overflow: hidden;
}
.ultag{
width: 3000px;
transition:transform 0.5s;
margin: 0px 0px;
padding: 0px;
}
.litag{
transition-duration: 0.3s;
float: left;
width: 250px;
height: 300px;
margin: auto;
padding-top: 10px;
}
.button{
margin-top: 50px;
border-color: green;
}

.button div {
display:inline-block;
 margin: auto 5px;
        width: 15px;
        height: 15px;
        border: 0px;
        border-radius: 50%;
   
background-color:#e9e9e9; 
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


div .button1 {
background-color:#808080; 
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
	opacity: 50%;
	transition-duration: 0.2s;
}
.left .btn:hover .real,.right .btn:hover .real{
	opacity: 100%;
	cursor: pointer;
	transform: scale(1.2);
}
.sideimg {
	width: 50px;
	height: 50px;
	object-fit: cover;
	vertical-align: middle;
}
.img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	vertical-align: middle;
}
</style>
<script>
function nextaoto() {
	window.setTimeout('nextaoto();',5000);
	next();
}
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
var page=0;
var value=0;
function color() {
	if(page==0){
		document.querySelector('.button2').style.backgroundColor='#e9e9e9'; 
		document.querySelector('.button3').style.backgroundColor='#e9e9e9'; 
		document.querySelector('.button1').style.backgroundColor='#808080'; 
			
		}else if(page==1){
			document.querySelector('.button1').style.backgroundColor='#e9e9e9'; 
			document.querySelector('.button3').style.backgroundColor='#e9e9e9'; 
			document.querySelector('.button2').style.backgroundColor='#808080'; 
		}else{
			document.querySelector('.button1').style.backgroundColor='#e9e9e9';
			document.querySelector('.button2').style.backgroundColor='#e9e9e9';
			document.querySelector('.button3').style.backgroundColor='#808080'; 
		}
	
}
function button(page2) {
	var value=page2*-1000
	document.querySelector('.ultag').style.transform='translate('+value+'px)';
	page=page2;
	color();

}

function next() {
	page++;
	if(page>=3){
		page=0;
	}
	value=page*-1000;
	document.querySelector('.ultag').style.transform='translate('+value+'px)';
	color();
}
function pe() {
	page--;
	if(page<=-1){
		page=2;
	}
	value=page*-1000;
	document.querySelector('.ultag').style.transform='translate('+value+'px)';
	color();
	
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



<body onload="window.setTimeout('nextaoto();',5000);">
	<%@ include file="header.jsp"%>
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
			<a class="subject" href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>">
			<li class="litag">
			<div class="date" style="color: black;">
			<script>
			var str = '<%=arr.get(i).getBbs_date_s()%>';
			var msg = articleTime(str);
			document.write(msg);
			</script>
			</div>
			<div class="imgarea"><img class="img" src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>"></div>
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
			<div><span>[<%=bdao.stringCategory(arr.get(i).getBbs_category()) %>]<%=arr.get(i).getBbs_subject()%></span></div>
			<div style="color: red;">
			<%
			int price = arr.get(i).getBbs_price();
			String price_s = "";
			DecimalFormat form= new DecimalFormat();
			form.applyLocalizedPattern("#.0");
			if (price >= 100000000){
				price_s = form.format(price / 100000000.0) + "억 원";
			}else if(price >= 10000){
				price_s = form.format(price / 10000.0)  + "만 원";
			}else if(price > 0){
				price_s = price + "원";
			}else {
				price_s = "무료나눔";
			}
			price_s = price_s.replaceAll(".0", "");
			%>
				<span><%=price_s%></span>
			</div>
			</li>
			</a>
		<%
			}
		}
		%>
		</ul>
		</article>
		<div class="button">
		<div onclick="javascript:button(0);" class="button1"></div>
		<div onclick="javascript:button(1);" class="button2"></div>
		<div onclick="javascript:button(2);" class="button3"></div>
		</div>
	</section>
		<section class="left">
		<span class="btn" onclick="javascript:pe();">
		<img class="sideimg real" src="img/left.jpg">
		</span>
		</section>
		<section class="right">
		<span class="btn" onclick="javascript:next();">
		<img class="sideimg real" src="img/right.jpg">
		</span>
		</section>
	<%@ include file="footer.jsp"%>
</body>
</html>