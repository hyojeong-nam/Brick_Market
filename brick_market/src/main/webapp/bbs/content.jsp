<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.team4.reply.ReplyDAO" scope="session"></jsp:useBean>
<jsp:useBean id="ldao" class="com.team4.like.LikeDAO"></jsp:useBean>
<%@page import="java.util.*"%>
<%@page import="com.team4.reply.ReplyDTO"%>
<%@page import="com.team4.bbs.BbsDTO"%>
<%@page import="com.team4.member.MemberDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/brick_market/css/maincss.css">
<style>
.container {
	text-align: center;
	margin: 0px auto;
	width: 800px;
	display: grid;
	grid-template-columns: 50% 10% 40%;
	grid-template-rows: 40px 40px 40px 40px 240px auto;
	grid-template-areas:
	"item  title  title" 
	"item  price  price"
	"item  proimg  nick" 
	"item  proimg  star" 
	"item   text   text"
	"reply reply  reply";
}

.item_img {
	height: 400px;
	width: 400px;
	object-fit: cover;
	grid-area: item;
}

.title_text {
	grid-area: title;
	margin: 0px 0px;
}

.price_text {
	grid-area: price;
	margin: 10px 10px;
	text-align: right;
	color: red;
}

.profile_img {
	height: 80px;
	width: 80px;
	object-fit: cover;
	grid-area: proimg;
}

.profile_nick {
	grid-area: nick;
	text-align: left;
}

.profile_star {
	grid-area: star;
	text-align: left;
}

.item_text {
	grid-area: text;
	text-align: left;
}

.reply {
	grid-area: reply;
	text-align: left;
}

.reply table {
	width: 750px;
	margin: 0px auto;
}
fieldset table{
	width: 800px;
	border: 0px;
	margin: auto;
}
fieldset{
border: 0px;
margin: auto;

}

legend{
margin-left: 50px;
padding-top: 40px;
}
table .nick{
	text-align: left;
	font-size: 15px;
	height: 10px;
	float: left;
	margin-left: 5px;
}
.content{
	width: 580px;
	font-size: 18px;
	margin-left: 100px;
	margin-top: 5px;
	
}
.img img{
width: 50px;
height: 50px;
float: left;
}
.date{
text-align: right;
margin-top: 0px;
font-size: 10px;

}
.sese{
text-align: right;
font-size: 15px;
}
tbody{
text-align: center;
}
tbody textarea{
 float: left;
 margin-left: 30px;
 height: 50px;s
}
tfoot {
	text-align: center;
	padding-top: 5px;
}
table tbody .nick{
	margin-left: 10px;
	margin-top: 10px;
}
table tbody .sese{
	text-align: center;
	margin-top: 20px;
	
}
.rereply{
margin-left: 10px;
float: left;
margin-right: 10px;
}
table .reply .nick{
margin-top: 0px;
}
.clre .date{
float: right;
}
.clre .content{
margin-left: 150px;
margin-top: 20px;
}

.input textarea{
width: 450px;
margin-left: 40px;
float: left;
height: 40px;
}

table .input .sese{
text-align: center;
margin-top: 10px;
}

footer{
margin-top: 800px;
}

</style>
<%
String bbs_idx_s = request.getParameter("bbs_idx");
int bbs_idx = 0;
if (bbs_idx_s != null && bbs_idx_s.length() != 0) {
	bbs_idx = Integer.parseInt(bbs_idx_s);
}
if (bbs_idx == 0) {
%>
<script>
	window.alert('잘못된 접근입니다.');
	window.location.href = '/brick_market/index.jsp';
</script>
<%
return;
}
BbsDTO bdto = bdao.bbsContent(bbs_idx);
if (bdto.equals(null)) {
%>
<script>
	window.alert('존재하지 않는 게시글입니다.');
	window.location.href = '/brick_market/index.jsp';
</script>
<%
return;
}
int user_idx = bdto.getBbs_writer_idx();
MemberDTO mdto = mdao.searchIdx(user_idx);//게시물 게시자
//////////////////////////////////////////////////////////////////
String ref_s = request.getParameter("ref");
int ref = 0;
if (ref_s != null && ref_s.length() != 0) {
ref = Integer.parseInt(ref_s);
}
int totalCnt = rdao.totalRef(bbs_idx);//db

int listSize = 5;
int pageSize = 5;
String cp_s = request.getParameter("cp");//페이지
if (cp_s == null || cp_s.equals("")) {
cp_s = "1";
}
int totalPage=0;
int cp = Integer.parseInt(cp_s);
if(totalCnt!=0){
 totalPage = totalCnt / listSize + 1;
}
if (totalCnt % listSize == 0) {
totalPage--;
}
int userGroup = cp / pageSize;
if (cp % pageSize == 0)
userGroup--;
/////////////////////////////////////////////////////////////////////////
ArrayList<ReplyDTO> arr = rdao.replyList(bbs_idx,listSize,cp);//댓글 가져오는 기능

%>
<script>
function eventreply(a) {
	document.querySelector('.eventreply').innerHTML=''+
	'<div class="rereply">&hookrightarrow;</div>'+
	'<div class="img"><img src=""></div>'+
	'<div class= "date"></div>'+
	'<div class="nick"></div>'+
	'<div class="content"></div>'+
	'<div class="sese">수정 삭제</div>'+
	'<div class="rereply">&nbsp;&nbsp;&nbsp;&hookrightarrow;</div>'+
	'<div class="img"><img src=""></div>'+
	'<form action="rereply_ok.jsp?cp=<%=cp%>&ref=<%=ref%>" method="post">'+
	'<div class="content"><textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required></textarea></div>'+
	'<input type="hidden" name="reply_bbs_idx" value="<%=bbs_idx%>">'+
	'<input type="hidden" name="reply_write_idx"  value="">'+
	'<div class="sese"><input type="submit" value="등록"></div>'+
	'</form>';
	
}
function delete_reply(a) {
	var bl =window.confirm('삭제하시겠습니까?');
	if(bl){
		location.href='deleteReply.jsp?ref='+a+'&bbs_idx=<%=bbs_idx%>';
	}
}
function openDel(){
	
	window.open('delete.jsp?bbs_idx=<%=bbs_idx%>&bbs_writer_idx=<%=bdto.getBbs_writer_idx()%>',
			'delPage','width=520,height=250');
	
}
</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article class="container">
			<img class="item_img" alt="test" src="<%=bdto.getBbs_img()%>">
			<h2 class="title_text"><%=bdto.getBbs_subject()%></h2>
			<p class="price_text"><%=bdto.getBbs_price()%>원
			</p>
			<img class="profile_img" alt="test" src="<%=mdto.getMember_img()%>">
			<p class="profile_nick"><%=mdto.getMember_nick()%></p>
			<p class="profile_star">거래완료조회 ★★★★☆(23 리뷰) 평점 4.2</p>
			<pre class="item_text">
		<%=bdto.getBbs_content().replaceAll("\n", "<br>")%>
			<%if(midx!=0) {
				
			%>
			<a href="reWrite.jsp?bbs_idx=<%=bbs_idx%>&bbs_writer_idx=<%=bdto.getBbs_writer_idx()%>">수정하기</a>
			<input type="button" onclick="openDel();" value="삭제하기">
			<%}else{ %>
			<%}
			int like=-1;
			if(midx!=0){
				like=ldao.checkLike(bbs_idx, midx);
				if(like==1){
					%><a href="likeUpdate_ok.jsp?bbs_idx=<%=bbs_idx %>&user_idx=<%=midx %>&check=1" >취소</a><% 
				}else if(like==0){
					%><a href="likeUpdate_ok.jsp?bbs_idx=<%=bbs_idx %>&user_idx=<%=midx %>&check=0" >&hearts;</a><%
				}else{
					%><a href="likeUpdate_ok.jsp?bbs_idx=<%=bbs_idx %>&user_idx=<%=midx %>&check=2" >&hearts;</a><%
				}
			}else{
				%><span>로그인후 이용가능</span><% 
			}
			 %>
		</pre>
		</article>
		
		<article class="reply">
			<hr>
			<fieldset>
			<legend>댓글</legend>
			<table border="1">
			<thead class="rereply">
					<%//댓글 없음 출력
					if (arr == null || arr.size() == 0) {
					%>
					<tr><td>등록된 댓글이 없습니다.</td></tr>
					<%
					} else {
					for (int i = 0; i < arr.size(); i++) {
					System.out.print(	arr.get(i).getReply_write_idx());
						MemberDTO writemember= mdao.searchIdx(arr.get(i).getReply_write_idx());
						//댓글없음출력
					//댓글 출력//%>
				<tr>
					<td>
					<div class="img"><img src="<%=writemember.getMember_img() %>"></div>
					<div class="nick"><%=writemember.getMember_nick()%></div>
					<div class="date"><%=arr.get(i).getReply_date()%></div>
					<div class="content"><%=arr.get(i).getReply_content()%></div>
					<div class="sese"><a href="content.jsp?bbs_idx=<%=bbs_idx%>&ref=<%=arr.get(i).getReply_ref()%>&cp=<%=cp%>">답글</a>
					<a onclick="eventreply(<%=arr.get(i).getReply_ref()%>);">test</a>
					<%//댓글출력
					//수정삭제여부
					if (midx != arr.get(i).getReply_write_idx()) {
					%>
					    수정
						삭제
					<%
					}else {
					%>
					
					    <a href="javascript:location.href='content.jsp?bbs_idx=<%=bbs_idx%>&reply_idx=<%=arr.get(i).getReply_idx()%>&cp=<%=cp%>';">수정</a>
					
						<a href="javascript:delete_reply(<%=arr.get(i).getReply_ref()%>);">삭제</a>
				
					<%
					if (request.getParameter("reply_idx") != null&& Integer.parseInt(request.getParameter("reply_idx")) == arr.get(i).getReply_idx()) {
						int reply_idx = Integer.parseInt(request.getParameter("reply_idx"));
					%></div>
					</td>
				</tr>
						<form action="updateReply.jsp" method="post">
				<tr>
					<td>댓글수정
					
						<input type="text" name="content" value="<%=arr.get(i).getReply_content()%>"> 
						<input type="hidden" name="reply_idx" value="<%=reply_idx%>"> 
						<input type="hidden" name="bbs_idx" value="<%=bbs_idx%>">
						<input type="hidden" name="cp" value="<%=cp%>">
						<input type="submit" value="수정"> 
						<input type="button" value="취소" onclick="javascript:location.href='content.jsp?bbs_idx=<%=bbs_idx%>&cp=<%=cp%>';">
					</td>
					<%
					}
					%>
				</tr>
						</form>
				<tr class="eventreply">
				<td>숨길영역</td>
				</tr>
				<%
				}//수정삭제
					//대댓기능
				if (ref == arr.get(i).getReply_ref()) {
					ArrayList<ReplyDTO> arr2=rdao.rereplyList(bbs_idx, ref);
				%>
				<tr>
				<script>
				//기존 대댓글 페이지///////////////////////////////////////////////////////////////////////////
					
						<%
						if(arr2!=null||arr2.size()!=0){
							for(int j=0;j<arr2.size();j++){
								MemberDTO marr2 = mdao.searchIdx(arr2.get(j).getReply_write_idx());	
								%>
								document.write('<td class="clre"><div class="rereply">&hookrightarrow;</div><div class="img"><img src="<%=marr2.getMember_img()%>"></div><div class= "date"><%=arr2.get(j).getReply_date()%></div>');
								document.write('<div class="nick"><%=marr2.getMember_nick()%></div>'+'<div class="content"><%=arr2.get(j).getReply_content()%></div>');
								document.write('<div class="sese">수정 삭제</div></td></tr>');
								<%	
							}
						}
						%>
				</script>
				<%if(midx!=0){
					%>
					<script>
						document.write('<tr><td class="input"><div class="rereply">&nbsp;&nbsp;&nbsp;&hookrightarrow;</div>');
						document.write('<div class="img"><img src="<%=mdtoheader.getMember_img() %>"></div>');
						document.write('<div class="nick"><%= mdtoheader.getMember_nick()%></div>');
						document.write('<form action="rereply_ok.jsp?cp=<%=cp%>&ref=<%=ref%>" method="post">');
						document.write('<div class="content"><textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required></textarea></div>');
						document.write('<input type="hidden" name="reply_bbs_idx" value="<%=bbs_idx%>">');
						document.write('<input type="hidden" name="reply_write_idx"  value="<%=midx%>">');
						document.write('<div class="sese"><input type="submit" value="등록"></div></form></td>');
					
					</script>
					</tr>
				
				<%
				}///////////////////////////////////////////////////////////대댓기능
				}
				
					
					
					}
				}
				%>
					</thead>
								<tfoot class="reply">
				<tr>
					<td>
						<%
						if (userGroup != 0) {
						%><a
						href="content.jsp?cp=<%=(userGroup - 1) * pageSize + 1%>&bbs_idx=<%=bbs_idx%>">&lt;&lt;</a>
						<%
						}
						for (int i = userGroup * pageSize + 1; i <= userGroup * pageSize + pageSize; i++) {
						%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(i==cp){
							%><%=i%><%
						}else{ %>
						<a href="content.jsp?cp=<%=i%>&bbs_idx=<%=bbs_idx%>"><%=i%></a> <%
						}if (i >= totalPage)
						 	break;
						 
						 }
						 if (userGroup != (totalPage / pageSize - (totalPage % pageSize == 0 ? 1 : 0))) {
						 %><a href="content.jsp?cp=<%=(userGroup + 1) * pageSize + 1%>&bbs_idx=<%=bbs_idx%>">
							&gt;&gt;</a>
						<%
						}
						%>
					</td>
				</tr>
				</tfoot>
					<tbody>
							<form action="reply_ok.jsp?" method="post">
					
				<tr class="foot">
					<%
					if (midx == 0) {
					%><td>로그인후 댓글입력가능</td>
					<%
					} else {
					%>
						<td >
						<div class="img"><img src="<%=mdtoheader.getMember_img()%>" alt="내사진"></div>
							<div class="nick"><%=mdtoheader.getMember_nick()%></div>
							<textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required></textarea>
							<input type="hidden" name="reply_bbs_idx" value="<%=bbs_idx%>">
							<input type="hidden" name="reply_write_idx" value="<%=midx%>">
							<div class="sese">
							<input type="submit" value="등록">
							</div>
						</td>
					<%
					}
					%>
				</tr>
							</form>
							</tbody>
			</table>
			</fieldset>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>