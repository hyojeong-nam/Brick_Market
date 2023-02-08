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
	box-shadow: 0px 0px 3px 2px gray;
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

.subject:hover {
	text-decoration: underline;
	color: skyblue;
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
float: left;
width: 250px;
height: 280px;
margin: auto;
padding-top: 10px;
}
.button{
margin-top: 50px;
border-color: green;
}

.button div {
display:inline-block;
 margin: 0 auto;
        width: 15px;
        height: 15px;
        border: 0px;
        border-radius: 50%;
   
background-color:#e9e9e9; 
}
div .button1 {

background-color:#808080; 
}
.left, .right {
	display:flex;
    justify-content:center;
    align-items:center;
}
.img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	vertical-align: middle;
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
<body>
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
			<div>
			<script>
			var str = '<%=arr.get(i).getBbs_date_s()%>';
			var msg = articleTime(str);
			document.write(msg);
			</script>
			</div>
			<div class="imgarea"><img class="img" src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>"></div>
			<div><span><%=arr.get(i).getBbs_subject()%></span></div>
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
		<img src="img/left.jpg" onclick="javascript:pe();" class="img">
		</section>
		<section class="right">
		<img src="img/right.jpg" onclick="javascript:next();" class="img">
		
		</section>
	<%@ include file="footer.jsp"%>
</body>
</html>