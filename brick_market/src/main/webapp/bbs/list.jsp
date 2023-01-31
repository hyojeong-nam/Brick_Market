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
section {
	width: 1200px;
}

section table img {
	width: 200px;
	margin: 10px;
	height: 220px;
}

section table {
	text-align: center;
	border: 0px;
	margin: auto;
}

section fieldset {
	border: 0px;
}

section legend {
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
int totalcnt = bdao.getTotalCnt();
ArrayList<BbsDTO> arr = bdao.bbsList(4, pagenum, select, keyword, category, status);
%>
<body>
	<%@ include file="/header.jsp"%>
	<section class="section">
		<article>
			<fieldset>
				<%
				if (pagenum <= 1) {
				%>왼쪽<%
				} else {
				%>
				<a href="list.jsp?page=<%=pagenum - 1%>&status=<%=status %>&category=<%=category %>&keyword=<%=keyword%>">왼쪽</a>
				<%
				}
				%>
				<legend>검색어 : "<%=keyword %>" 카테고리 : "<%=bdao.stringCategory(category) %>" 상태 : <%=str_status %></legend>
				<table>
					<%
					if (arr == null || arr.size() == 0) {
					%>
					<tr>
						<td>검색결과 없음</td>
					</tr>
					<%
					} else {
					%>
					<tr>
						<%
						for (int i = 0; i < arr.size(); i++) {
						%>
						<td><script>var str = '<%=arr.get(i).getBbs_date_s()%>';
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
					</tr>
					<tr>
						<%
						for (int i = 0; i < arr.size(); i++) {
						%>

						<td><a href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>"><img src="<%=arr.get(i).getBbs_img()%>" alt="<%=arr.get(i).getBbs_subject()%>"></a></td>

						<%
						}
						%>
					</tr>
					<tr>
						<%
						for (int i = 0; i < arr.size(); i++) {
						%>

						<td><a href="/brick_market/bbs/content.jsp?bbs_idx=<%=arr.get(i).getBbs_idx()%>"><%=arr.get(i).getBbs_subject()%></a></td>

						<%
						}
						%>
					</tr>
					<tr>
						<%
						for (int i = 0; i < arr.size(); i++) {
						%>

						<td><%=arr.get(i).getBbs_price()%></td>

						<%
						}
						%>
					</tr>
					<%
					}
					%>
				</table>
				<%
				//  1페이지당 4개 총12개 페이지넘버 4,8,12(안됨)
				if ((pagenum - 1) * size < totalcnt ) {
				%>오른쪽<%
				} else {
				%>
				<a href="list.jsp?page=<%=pagenum + 1%>&status=<%=status %>&category=<%=category %>&keyword=<%=keyword%>">오른쪽</a>
				<%
				}
				%>
			</fieldset>
		</article>

	</section>
	<%@ include file="/footer.jsp"%>
</body>
</html>