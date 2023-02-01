<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="ddao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdto" class="com.team4.member.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mdto"/>    

<%
int bbs_idx=Integer.parseInt(request.getParameter("bidx"));
int bbs_writer_idx=(int)session.getAttribute("midx");
String pwd=request.getParameter("pwd");
int result=ddao.bbsDelete(bbs_idx, bbs_writer_idx, pwd);

if(result==1){
	
	%>
	<script>
	window.alert("게시글 삭제 성공!");
	opener.location.href="/brick_market/index.jsp";
	window.close();
	</script>
	<%		
	}else if(result==0){
			%>
			<script>
			window.alert("비밀번호가 틀렸습니다.");
			location.href='/brick_market/bbs/content.jsp?bbs_idx=<%=bbs_idx%>';
			window.close();
			</script>
			<% 
			}else if(result==-1){
					%>
					<script>
					window.alert("게시글이 없습니다.");	
					location.href="/brick_market/bbs/index.jsp";
					window.close();
					</script>
					<%
			}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>