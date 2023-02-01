<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO"></jsp:useBean>
<%@page import="com.team4.bbs.BbsDTO" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/brick_market/css/maincss.css">
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<article>
<fieldset>
<legend>좋아하는 글 목록</legend>
<table>
<%
int size=1;
int cp=1;
int extra=1;
ArrayList<BbsDTO> arr=bdao.bbsList(size, cp, extra, 1);

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
							%>
							<a href="/brick_market/bbs/list.jsp?page=<%=cp+1 %>">
							<img class="img" src="/brick_market/img/right.jpg" alt="오른쪽 페이지 이동">
							</a>
							<%
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


</table>
</fieldset>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>