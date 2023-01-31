<%@page import="java.util.Locale.Category"%>
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

.inline{
	display: inline;
}

table.content{
	margin: auto;
	witdh: 1000px;
}


.imgarea {
	line-height: 220px;
}

.imgarea .img {
	width: 200px;
	height: 220px;
	object-fit: cover;
	vertical-align: middle;
}

.side .img {
	width: 50px;
	height: 50px;
	object-fit: cover;
	vertical-align: middle;
}
table.content td.content{
	text-align:center;
	width: 200px;
}

table.content td.side{
	text-align:center;
	width: 100px;
}
h3 {
	text-align: center;
}
</style>
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
	<section>
		<h3>검색어 : "<%=keyword %>" 카테고리 : "<%=bdao.stringCategory(category) %>" 상태 : <%=str_status %></h3>
		<article class="mid">
			<table class="content">
				<%
				if (arr == null || arr.size() == 0) {
				%>
				<tr class="content">
					<td class="side"></td>
					<td class="content">등록된 최신글이 없습니다</td>
					<td class="side"></td>
				</tr>
				<%
				} else {
				%>
				<tr>
					<td class="side"></td>
					<%
					for (int i = 0; i < arr.size(); i++) {
					%>
					<td class="content"><script>var str = '<%=arr.get(i).getBbs_date_s()%>';
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
					</script></td>
					<%
					}
					%>
					<td class="side"></td>
				</tr>
				<tr>
					<td class="side">
						<%
						if (pagenum > 1) {
							%>
							<a href="/brick_market/bbs/list.jsp?page=<%=pagenum-1 %>&status=<%=status %>&category=<%=category %>&keyword=<%=keyword%>">
							<img class="img" src="/brick_market/img/left.jpg" alt="왼쪽 페이지 이동">
							</a>
							<%
						}
						%>
					</td>
					<%
					for (int i = 0; i < arr.size(); i++) {
					%>

					<td class="imgarea content">
					<a href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>">
					<img class="img" src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>">
					</a></td>

					<%
					}
					%>
					<td class="side">
						<%
						if (pagenum * size + select < totalcnt) {
							%>
							<a href="/brick_market/bbs/list.jsp?page=<%=pagenum+1 %>&status=<%=status %>&category=<%=category %>&keyword=<%=keyword%>">
							<img class="img" src="/brick_market/img/right.jpg" alt="오른쪽 페이지 이동">
							</a>
							<%
						}
						%>
					</td>
				</tr>
				<tr>
					<td class="side"></td>
					<%
					for (int i = 0; i < arr.size(); i++) {
					%>

					<td class="content">
					<a href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>"><%=arr.get(i).getBbs_subject()%>
					</a></td>

					<%
					}
					%>
					<td class="side"></td>
				</tr>
				<tr>
					<td class="side"></td>
					<%
					for (int i = 0; i < arr.size(); i++) {
					%>
					<td class="content"><%=arr.get(i).getBbs_price()%> 원</td>

					<%
					}
					%>
					<td class="side"></td>
				</tr>
				<%
				}
				%>
			</table>
		</article>
	</section>
	<%@ include file="/footer.jsp"%>
</body>
</html>