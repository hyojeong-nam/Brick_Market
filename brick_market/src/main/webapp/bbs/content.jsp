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
fieldset {
	width: 800px;
margin: auto;
border: 0px;
}
fieldset legend {
margin-left: 50px;
}
fieldset table{
	width: 750px;
	margin: auto;
	margin-top: 10px;
}
table{
}

table .img{
 width: 50px;
 height: 50px;
 float: left;
 margin-left: 10px;
 margin-top: 5px;
}
table .nick{
margin-top: 5px;
float: left;
}
.content{
float: left;
}
.tate{
}
.mainreply{
height:100px;
}
table tfoot .img{
	width: 50px;
	height: 50px;
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
function cancelupdatereply(idx,content){
	document.querySelector('.updatereply'+idx).innerHTML=''+content;
}
function updatereply(content,idx) {
	document.querySelector('.updatereply'+idx).innerHTML=''+
	'<form action="updateReply.jsp" method="post">'+
	'<div class="content"><textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="content" required >'+content+'</textarea></div>'+
	'<input type="hidden" name="reply_idx" value="'+idx+'">'+
	'<input type="hidden" name="bbs_idx" value="<%=bbs_idx%>">'+
	'<input type="hidden" name="cp" value="<%=cp%>">'+
	'<div class="sese"><input type="submit" value="수정"></div> '+
	'<div class+"sese"><input type="button" value="취소" onclick="javascript:cancelupdatereply('+idx+',\''+content+'\');"><div></form>';

}

function delete_reply(a) {
	var bl =window.confirm('삭제하시겠습니까?');
	if(bl){
		location.href='deleteReply.jsp?ref='+a+'&bbs_idx=<%=bbs_idx%>';
	}
}
function openDel(){
	
	window.open('delete.jsp?bbs_idx=<%=bbs_idx%>&bbs_writer_idx=<%=bdto.getBbs_writer_idx()%>',
			+'delPage','width=520,height=250');	
}
</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<article class="container">
		<a href="/brick_market/report/report.jsp?bbs_idx=<%=bbs_idx%>">신고하기</a>
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
			<a href="/brick_market/review/review.jsp?bbs_idx=<%=bbs_idx%>&bbs_writer_idx=<%=bdto.getBbs_writer_idx()%>">리뷰하기(임시)</a>
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
		
		<article class="mid">
			<hr>
		<fieldset class="mid">
		<script>
		function noreply(idx) {
			document.querySelector('.rereply'+idx).innerHTML='';
		}
		function rereplyselect(img,date,nick,content,size,idx,ref){
			alert(ref);
			var str='';
			for( i=0;i<size;i++){
			
				str+='<div class="arrow">&hookrightarrow;</div>'+
				'<div class="img"><img src="'+img[i]+'"></div>'+
				'<div class= "date">'+date[i]+'</div>'+
				'<div class="nick">'+nick[i]+'</div>'+
				'<div class="content">'+content[i]+'</div>'+
				'<div class="sese">수정 삭제</div>';
			}
			if(<%=midx%>!=0){
				
			str+='<form action="rereply_ok.jsp?" method="post">'+
			'<div class="arrow">&nbsp;&nbsp;&nbsp;&hookrightarrow;</div>'+
			'<div><img class="img" src="<%=mdtoheader.getMember_img()%>"></div>'+
			'<div class="content"><textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required></textarea></div>'+
			'<input type="hidden" name="reply_write_idx" value="<%=midx%>">'+
			'<input type="hidden" name="ref" value="'+ref+'">'+
			'<input type="hidden" name="cp" value="<%=cp%>">'+
			'<input type="hidden" name="bbs_idx" value="<%=bbs_idx%>">'+
			'<div onclick="javascript:noreply('+idx+');">숨기기</div>'+
			'<div class="sese"><input type="submit" value="등록"></div></form>';
			}else{
				str+='<div>로그인후 작성 가능합니다</div>';
			}
			document.querySelector('.rereply'+idx).innerHTML=''+str;
			
					
		}
	
		
		function rereply(idx,ref) {
			str='';
			if(<%=midx%>!=0){
				str+='<form action="rereply_ok.jsp?bbs_idx=<%=bbs_idx%>" method="post">'+
				'<div class="rereply">&nbsp;&nbsp;&nbsp;&hookrightarrow;</div>'+
				'<div><img class="img" src="<%=mdtoheader.getMember_img()%>"></div>'+
				'<div class="content"><textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required></textarea></div>'+
				'<input type="hidden" name="reply_write_idx" value="<%=midx%>">'+
				'<input type="hidden" name="ref" value="'+ref+'">'+
				'<input type="hidden" name="cp" value="<%=cp%>">'+
				'<input type="hidden" name="bbs_idx" value="<%=bbs_idx%>">'+
				'<div onclick="javascript:noreply('+idx+');">숨기기</div>'+
				'<div class="sese"><input type="submit" value="등록"></div></form>';
			}else{
				str+='<div>로그인후 작성 가능합니다</div>';
			}
			document.querySelector('.rereply'+idx).innerHTML=''+str;
			
			
			
		}
		
		</script>
			<legend class="reply">댓글</legend>
			<table class="reply" border="1">
			<thead class="reply">
			<tr>
			<%
			ArrayList<ReplyDTO> rearr=rdao.replyList(bbs_idx, listSize, cp);
			if(rearr==null||rearr.size()==0){
				%><td>등록된 댓글이 없습니다</td><%
			}else{
				%><td><% 
				for(int i=0;i<rearr.size();i++){
					MemberDTO replyMember=mdao.searchIdx(rearr.get(i).getReply_write_idx());//댓글 게시자의 프로필 정보
					ArrayList <ReplyDTO> rereply=rdao.rereplyList(bbs_idx, rearr.get(i).getReply_ref());//대댓글
					String nick[]=null;
					String date[]=null;
					String content[]=null;
					String img[]=null;
					if(rereply!=null&&rereply.size()!=0){
						%>
						<script>
						var nick<%=rearr.get(i).getReply_idx()%>=new Array(<%=rereply.size()%>);
						var date<%=rearr.get(i).getReply_idx()%>=new Array(<%=rereply.size()%>);
						var img<%=rearr.get(i).getReply_idx()%>=new Array(<%=rereply.size()%>);
						var content<%=rearr.get(i).getReply_idx()%>=new Array(<%=rereply.size()%>);
						</script>
						<%
						
						for(int j=0;j<rereply.size();j++){
							%><script>
							nick<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getMember_nick()%>';
							date<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getReply_date_s()%>';
						content<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getReply_content().replaceAll("\r\n", "<br>")%>';
							img<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getMember_img()%>';
							</script>
							<%
						}
						%><script>
						
						</script><%
					}
				%><div class="mainreply"><div><img class="img" src="<%=replyMember.getMember_img()%>"></div>
				<div class="nick"><%=replyMember.getMember_nick() %></div>
				<div class="updatereply<%=rearr.get(i).getReply_idx()%>"><%=rearr.get(i).getReply_content() %></div>
				<div class="date"><%=rearr.get(i).getReply_date() %></div> 
				<div class="sese">
				<%if(rereply.size()!=0){
					%>
					<span onclick="javascript:rereplyselect(img<%=rearr.get(i).getReply_idx()%>,date<%=rearr.get(i).getReply_idx()%>,nick<%=rearr.get(i).getReply_idx()%>,content<%=rearr.get(i).getReply_idx()%>,<%=rereply.size()%>,<%=rearr.get(i).getReply_idx()%>,<%=rearr.get(i).getReply_ref()%>);">등록된답글<%=rereply.size()%></span>
					<%
				}else{
					
					%><span onclick="javascript:rereply(<%=rearr.get(i).getReply_idx()%>,<%=rearr.get(i).getReply_ref()%>);">등록된답글<%=rereply.size() %></span> <%
				} %>
				
				
				<%if(rearr.get(i).getReply_write_idx()==midx){
					
					%>
					<span><a href="#updatereply" onclick="javascript:updatereply('<%=rearr.get(i).getReply_content()%>',<%=rearr.get(i).getReply_idx()%>);">수정</a></span>
					<span><a href="#" onclick="javascript:href='deleteReply.jsp?bbs_idx=<%=bbs_idx%>&ref=<%=rearr.get(i).getReply_ref()%>';">삭제</a></span>
					<% 
				}else{ %>
				<span class="updatereply<%=rearr.get(i).getReply_idx() %>">수정</span>
				<span>삭제</span>
				<%} %>
				</div>
				<div class="rereply<%=rearr.get(i).getReply_idx()%>"></div></div>
				<% 
				
			}
				%></td><% 
			}	
			 %>
			
			</tr>
			
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
						<div ><img class="img" src="<%=mdtoheader.getMember_img()%>" alt="내사진"></div>
							<div class="nick"><%=mdtoheader.getMember_nick()%></div>
							<textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required ></textarea>
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