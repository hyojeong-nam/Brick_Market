<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="ddao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO"
	scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
int bidx=Integer.parseInt(request.getParameter("bbs_idx"));
int widx=Integer.parseInt(request.getParameter("bbs_writer_idx"));
int midx=(int)session.getAttribute("midx");

if(widx!=midx){
	%>
	<script>
	window.alert("삭제권한이 없습니다.");
	window.self.close();
	</script>
	<% 
	
}
%>
<style>

body{
	text-align: center;
}

input { 

	background-color: 	#E6E6FA; 
	border-color: #FFF8DC;
	border-width: 2px;	
}

input:focus{
	background-color: #FFFFF0;
}
input::placeholder {
  color: gray;
  font-weight: bold;
}



#cancel:active {
	transform: scale(1.5);
}

#submit:active {
	transform: scale(1.5);
}
#review_content{
	border-style: groove;
	border-radius:10px 10px 10px 10px;
	border-color: #EEE8AA;
	border-width: 2px;
	
}
#submit {
    width: 5%;
    background-color: skyblue;
    border-color: transparent;
    color: white;
    padding: 8px;
    margin-bottom: 5px;
    border-radius:10px 10px 10px 10px;
}

#cancel {
    width: 5%;
    background-color: lightgrey;
    border-color: transparent;
    color: black;
    padding: 8px;
    border-radius:10px 10px 10px 10px;
}
</style>
</head>
<body>
	<section>
		<article>
			<form name=delBbs action="delete_ok.jsp">
				<div>삭제된 게시글은 복구할 수 없습니다.</div>
				<div>삭제하시겠습니까?(원할시 비밀번호 입력)</div>
				<input type="hidden" name="midx" value=<%=midx %>>
				<input type="hidden" name="bidx" value=<%=bidx %>>
				<input type="password" name="pwd" placeholder="비밀번호">
				<input type="submit" id="submit"value="삭제하기">
				<input type="button" id="cancel"value="취소하기" 
				onclick="location.href='/brick_market/bbs/content.jsp?bbs_idx=<%=bidx%>'">
			</form>
		</article>
	</section>
</body>
</html>