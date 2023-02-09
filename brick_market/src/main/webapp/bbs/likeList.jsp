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
.main{
text-align: left;
}
.main .img{
width: 80px;
height: 80px;
margin: 10px;
float: left;
margin-left: 0px;
}
.main .img img{
width: 80px;
height: 80px;
}
.main .subject{
font-size: 25px;
width: 400px;
text-align: center;
margin-left: 150px;
margin-top: 30px;
}
.mid .main .price{
margin-left:500px;
display: inline-block;
color: red;
}
.mid .main .date{
float:right;
font-size:  15px;
margin: 10px;
}
.button{
z-index: 1;
  width: 150px;
  height: 200px;
 right: 0px;
 position: fixed;
 top:70%;
}
.class{
height: 50px;
}
.sub {
margin-left: 630px;

}

.sub-text{
	border-radius: 15px; 
	width: 100px;
	padding-top: 15px;
	color: transparent;
}

.sub:hover .sub-text{
	display: inline;
	color:black;
	font-weight: bolder;
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
div .main{
	border:10px solid;
	border-color:rgba(243,114,62,0.3);
	border-radius: 15px;
	margin-bottom: 5px;
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
	<div class="button"  onclick="window.scrollTo(0,0);"><input type="button" value="TOP" class="class"></div>
		<article>
			<fieldset>
				<div>
					<%if(arr!=null&&arr.size()!=0){
					for (int i = 0; i < arr.size(); i++) {
					%>
					<div class="main">
							<div class="mid"><a href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>"><img class="img" src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>"></a></div>
					<div class="date">조회수 : <%=arr.get(i).getBbs_readnum() %> 등록된 댓글 : <%=rdao.totalRef(arr.get(i).getBbs_idx()) %> 게시일 : 
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
						</div>
							<div class="subject">
					<span>	<a href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>">
							<%=arr.get(i).getBbs_subject()%> 
							</a></span></div><span class="price"><%=arr.get(i).getBbs_price()%> <a class="won">원</a></span>
							<span class="sub">
							<span class="sub-text">관심글 취소!</span>
							<input type="button" onclick="javascript:location.href='likeUpdate_ok.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>&user_idx=<%=midx%>&check=1&cp=<%=cp%>'" value="♥"></span>
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
				</div>
			</fieldset>
			
		</article>
		
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>