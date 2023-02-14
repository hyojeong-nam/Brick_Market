<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<%@page import="com.team4.bbs.BbsDTO"%>
<%@page import="java.util.*"%>
<jsp:useBean id="ldao" class="com.team4.like.LikeDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.team4.reply.ReplyDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href="/brick_market/css/maincss.css">
<style type="text/css">
fieldset{
border: 0px;
}
.mid{
width: max(80%);
margin: auto;
}
.box{
	text-align: left;
	display: grid;
	border:10px solid;
	height:150px;
	border-color:rgba(243,114,62,0.3);
	border-radius: 15px;
	margin-bottom: 5px;
	grid-template-columns: 20% 50% 30%;
	grid-template-rows: 30% 40% 30%;
	grid-template-areas:
	"img  date   date" 
	"img  title  price"
	"img  .      sub" ;
}
.main .img{
width: 120px;
height: 120px;
margin:15px 15px;
object-fit: cover;
grid-area: img;

}
.subject{
margin:15px 15px;
font-size: 25px;
text-align: left;
grid-area: title;

}
.main .price{
margin:15px 15px;
font-size: 20px;
color: red;
grid-area: price;
text-align: right;

}
.main .date{
margin:15px 15px;
text-align:right;
font-size:  15px;
grid-area: date;

}
.button{
z-index: 1;
 right: 0px;
 position: fixed;
}
.sub {
margin-right:10px;
grid-area: sub;
text-align: right;
}



.sub-text a{
	color: transparent;
}
.sub:hover .sub-text a{
	display: inline;
	color:black;
	font-weight: bolder;
	cursor: pointer; 
}

.sub input{
	font-size: 30px;
	outline: none;
	border: 0px;
	background-color: transparent;
	color: red;
}
.sub input:hover{
	font-size: 30px;
	outline: none;
	border: 0px;
	background-color: transparent;
	color: silver;
	cursor: pointer;
}

h1{
	text-align: center;
}
.won{
	color: black;
	font-weight: bold;
}
.price{
	font-weight: bold;
}
/*임시로 넣어둠*/
a{
text-decoration-line: none;
color: black;
}
a:hover { 
color: rgb(243,114,62);
}
</style>
</head>
<%
int size = 5;
int cp = 0;
if (request.getParameter("cp") != null) {
	cp = Integer.parseInt(request.getParameter("cp"));
} else {
	cp = 1;
}
int extra = 1;

%>
<body>
	<%@include file="/header.jsp"%>
	<%
int list=5;
int cnt=ldao.totalCnt(midx);
	if (midx == 0) {
	%><script>
		window.alert('로그인후 이용 가능합니다');
		window.location.href = '/brick_market/member/login.jsp';
		</script>
	<%
	}
	ArrayList<BbsDTO> arr = bdao.bbsList(cp, midx);
	%>
	<section class="mid">
	<h1>관심글 목록</h1>
		<article>
			<fieldset>
					<%if(arr!=null&&arr.size()!=0){
					for (int i = 0; i < arr.size(); i++) {
					%>
					<div class="main box">
					<a href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>">
					<img class="img" src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>">
					</a>
					<span class="date">조회수 : <%=arr.get(i).getBbs_readnum() %> | 등록된 댓글 : <%=rdao.totalRef(arr.get(i).getBbs_idx()) %> | 게시일 : 
						<script>
						var str = '<%=arr.get(i).getBbs_date_s()%>';
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
							document.write('방금전');
						}else if(dayma<1000*60*60){//1시간
							var mi=Math.floor(dayma/(1000*60));//분구하기
							document.write(mi+'분전');
						}else if(dayma<1000*60*60*24){//24시간
							var h=Math.floor(dayma/(1000*60*60));//시간구하기
							document.write(h+'시간전');
						}else if(dayma<1000*60*60*24*7){
							var d=Math.floor(dayma/(1000*60*60*24));
							document.write(d+'일전');
						}else{
							document.write('일주일 이상');
						}
						</script>
					</span>
					<span class="subject">
						<a href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>">
						<%=arr.get(i).getBbs_subject()%> 
						</a>
						<%
						int price = arr.get(i).getBbs_price();
						String price_s = "";
						while(price >= 1000){
							int div = price % 1000;
							if(div > 100){
								price_s = "," + div + price_s;
							}else if(div > 10){
								price_s = ",0" + div + price_s;
							}else{
								price_s = ",00" + div + price_s;
							}
							price = price / 1000;
						}
						price_s = price + price_s;
						%>
					</span>
					<span class="price"><%=price_s%>원</span>
					<span class="sub">
						<span class="sub-text"><a onclick="javascript:location.href='likeUpdate_ok.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>&user_idx=<%=midx%>&check=1&cp=<%=cp%>'">관심글 취소!</a></span>
						<input type="button" onclick="javascript:location.href='likeUpdate_ok.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>&user_idx=<%=midx%>&check=1&cp=<%=cp%>'" value="♥">
					</span>
					</div>
					<%
					}
					if(cp*list>cnt){
						
						
					}else{
						%>
						<a href="/brick_market/bbs/likeList.jsp?cp=<%=cp + 1%>"> 좋아요 글더보기 </a>
						<%
					}
					}else{
					%>
			<div>좋아하는 게시글이 없습니다</div>
					<%
					}
					%>
			</fieldset>
			
			<div class="button"  onclick="window.scrollTo(0,0);"><input type="button" value="TOP" class="class"></div>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>