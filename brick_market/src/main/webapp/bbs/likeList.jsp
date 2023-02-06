<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<%@page import="com.team4.bbs.BbsDTO"%>
<%@page import="java.util.*"%>
<jsp:useBean id="ldao" class="com.team4.like.LikeDAO" scope="session"></jsp:useBean>
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
.main{
text-align: left;
}
.main .img{
width: 100px;
height: 90px;
margin-left: 40px;
}
.main .subject{
font-size: 25px;
float: left;
margin-top: 20px;
width: 100px;
margin-left: 100px;
}
.mid .main .price{
text-align: right;
margin-left: 350px;
}
.mid .main .date{
font-size:  10px;
text-align: right;
float: right;
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
		<article>
			<fieldset>
				<legend>좋아하는 글 목록</legend>
				<div>
					<%if(arr!=null&&arr.size()!=0){
					for (int i = 0; i < arr.size(); i++) {
					%>
					<div class="main">
					<span class="date">
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
						<a href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>">
							<span class="subject"><%=arr.get(i).getBbs_subject()%></span>
							<span><img class="img" src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>"></span>
							<span class="price"><%=arr.get(i).getBbs_price()%> 원</span></a>
							<span><input type="button" onclick="javascript:location.href='likeUpdate_ok.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>&user_idx=<%=midx%>&check=1&cp=<%=cp%>'" value="좋아요 취소"></span>
					</div>
					<%
					}
					if(cp*list>=cnt){
						
						
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