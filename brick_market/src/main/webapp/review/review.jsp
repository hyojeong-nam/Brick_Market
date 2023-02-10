<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.team4.bbs.BbsDTO"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"
	scope="session"></jsp:useBean>
<jsp:useBean id="bdto" class="com.team4.bbs.BbsDTO"></jsp:useBean>
<jsp:setProperty property="*" name="bdto"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
int bidx=Integer.parseInt(request.getParameter("bbs_idx"));
int sidx=Integer.parseInt(request.getParameter("bbs_writer_idx"));
int midx=(int)session.getAttribute("midx");
%>
<style>
#review_star fieldset{
	display: inline-block;
	border: 0;
	direction: rtl;
}
#review_star fieldset input{
	
	display: none;
	text-align: right;
}

#review_star input[type=radio]:checked ~ label{
	
	text-shadow: 2px 2px 2px #FFD700;
}
#review_star label{
	font-size: 3em;
	color:transparent;
	text-shadow: 0 0 0 #C0C0C0;
}

#review_star label:hover{

	text-shadow: 2px 2px 2px #FFD700;
}
#review_star label:hover~label{

	text-shadow: 2px 2px 2px #FFD700;
}
#review_star fieldset span{
	font-size: 1em; 
	font-family: NanumBarunGothic;
}

fieldset input[type=button]:hover{
	text-shadow: 2px 2px 2px #DCDCDC;
}

#review_content{
	border-style: groove;
	border-radius:10px 10px 10px 10px;
	border-color: #EEE8AA;
	border-width: 2px;
}

#review_content:focus { 
	background-color: #F8F8FF; 
}


#submit {
    width: 70px;
    background-color:  rgb(243,114,62);
    border-color: transparent;
    color: white;
    padding: 8px;
    margin-bottom: 5px;
    border-radius:10px 10px 10px 10px;
}

#cancel {
    width: 70px;
    background-color: lightgrey;
    border-color: transparent;
    color: black;
    padding: 8px;
    border-radius:10px 10px 10px 10px;
}

#cancel:active {
	transform: scale(1.5);
}

#submit:active {
	transform: scale(1.5);
}

body section{
	text-align: center;
}
h4{
	color: red;
	text-align: center;
	margin-top: 80px;
	margin-bottom: 0px;
}
div img{
	float: left;
	margin-left: 150px ;
	
}
textarea{
	resize: none;
}

</style>
<script>
function popupClose() {
	location.href='/brick_market/index.jsp';
	window.close();
}
</script>
<%if(midx==sidx){
	%>
	<script>
	window.alert("리뷰 등록 권한이 없습니다");
	window.close();
	</script>
	 <% 
	return;
} %>
</head>
<body>


<section>
<div><h3>[<%=bdao.stringCategory(bdto.getBbs_category())%>]<%=bdto.getBbs_subject()%></h3></div>
<div clss="img"><img src=<%=bdto.getBbs_img() %> width="80px" height="80px"></div>
<h4><%=bdto.getBbs_price()%>원</h4>
	<form name="review_star" id="review_star" action="review_ok.jsp">
		<fieldset>
			<span>!별점을 남겨주세요</span>
			<input type="radio" name=review_rate value="5" id="1"><label for="1">★</label>
			<input type="radio" name=review_rate value="4" id="2"><label for="2">★</label>
			<input type="radio" name=review_rate value="3" id="3"><label for="3">★</label>
			<input type="radio" name=review_rate value="2" id="4"><label for="4">★</label>
			<input type="radio" name=review_rate value="1" id="5" required="required"><label for="5">★</label>
		</fieldset>
		<input type="hidden" name="review_bbs_idx" value="<%=bidx%>">
		<input type="hidden" name="review_writer_idx" value="<%=midx%>">		
		<input type="hidden" name="review_seller_idx" value="<%=sidx%>">		
		<div><textarea rows="20" cols="70" name="review_content" id="review_content"
			placeholder="거래는 어떠셨나요?"></textarea></div>
			<span><input type="submit" id="submit" value="등록하기"></span>
			<span><input type="button" id="cancel" value="취소하기" onclick="popupClose();"></span>
	</form>
	</section>
	
</body>
</html>