<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bdao" class="com.team4.bbs.BbsDAO" scope="session"></jsp:useBean>
<jsp:useBean id="mdao" class="com.team4.member.MemberDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.team4.reply.ReplyDAO" scope="session"></jsp:useBean>
<jsp:useBean id="vdao" class="com.team4.review.ReviewDAO" scope="session"></jsp:useBean>
<jsp:useBean id="pdao" class="com.team4.report.ReportDAO" scope="session"></jsp:useBean>
<jsp:useBean id="ldao" class="com.team4.like.LikeDAO" scope="session"></jsp:useBean>
<%@page import="java.util.*"%>
<%@page import="com.team4.reply.ReplyDTO"%>
<%@page import="com.team4.bbs.BbsDTO"%>
<%@page import="com.team4.member.MemberDTO"%>
<%@page import="com.team4.review.ReviewDTO"%>
<%@page import="com.team4.report.ReportDTO"%>
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
	grid-template-rows: 40px 40px 40px 40px 240px 50px auto;
	grid-template-areas:
	"item  title  title" 
	"item  price  price"
	"item  proimg  nick" 
	"item  proimg  star" 
	"item   text   text"
	"btn   btn    btn  "
	"reply reply  reply";
}

.item_img {
	height: 400px;
	width: 400px;
	object-fit: cover;
	grid-area: item;
}

.title_text {
	text-align: left;
	grid-area: title;
	margin: 0px 0px;
}

.view_text {
	text-align: right;
	grid-area: price;
	margin: 0px 0px;
}

.price_text {
	grid-area: price;
	margin: 10px 10px;
	text-align: left;
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

.btn{
	grid-area: btn;
	text-align: center;
}

.btn a{
	display: inline-block;
	margin: 5px;
}

.btn a {
	text-decoration: none;
	color: black;
}

.btn a:hover {
	text-decoration: underline;
	color: skyblue;
}


fieldset {
	width: 800px;
margin: auto;
border: 0px;
}
.main{
margin-top: 50px;
}

.img{
 width: 50px;
 height: 50px;
 float: left;
 margin-left: 10px;
 margin-top: 5px;
 }
 .date{
 text-align: right;
 float: right;
 font-size: 10px;
 }
 .nick{
 text-align: left;
 margin-left: 80px;
 }
#content{
text-align:left;
margin-left:150px;
max-width: 600px;

}
.tag{
text-align: right;
}
.arrow{
text-align: left;
margin-top: 10px;
}
div .mid .img{

margin-left: 30px;
}
div .mid .nick{
margin-left: 100px;
}
div .mid .content{
text-align: left;
margin-left: 160px;
max-width: 550px;
}
.replying{
margin-top: 20px;
}
.rereplying .arrow{
margin-left: 20px;
}
.rereplying .img{
margin-left: 70px;
}
.mid .rereplying .img{
margin-left: 70px;
}
.submit{

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
int user_idx = bdto.getBbs_writer_idx();//게시자 인덱스
MemberDTO mdto = mdao.searchIdx(user_idx);//게시물 게시자 정보
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

function openRivew() {
	window.open('/brick_market/review/review.jsp?bbs_idx='+
			'<%=bbs_idx%>&bbs_writer_idx=<%=bdto.getBbs_writer_idx()%>'
			+'&bbs_subject=<%=bdto.getBbs_subject()%>'
			+'&bbs_category=<%=bdto.getBbs_category()%>&bbs_price=<%=bdto.getBbs_price()%>&bbs_img=<%=bdto.getBbs_img()%>',
			+'reviewPage','width=600,height=800');	
}
</script>
</head>
<body>
	<%@include file="/header.jsp"%>
	<section class="mid">
		<article class="container">
			<%
			int status = bdto.getBbs_status();
			String status_s = "";
			switch(status){
			case 0:status_s = "판매중"; break;
			case 1:status_s = "예약 완료"; break;
			case 2:status_s = "거래 완료"; break;
			}
			%>
		
			<img class="item_img" alt="test" src="<%=bdto.getBbs_img()%>">
			<h2 class="title_text"><span style="color: blue;">[<%=status_s %>]</span><span>[<%=bdao.stringCategory(bdto.getBbs_category()) %>]</span><%=bdto.getBbs_subject()%></h2>
			<p class="price_text"><%=bdto.getBbs_price()%>원</p>
			<p class="view_text">조회수 <%=bdto.getBbs_readnum()%></p>
			<img class="profile_img" alt="test" src="<%=mdto.getMember_img()%>">
			<p class="profile_nick"><%=mdto.getMember_nick()%></p>
			<%
			int report_cnt = pdao.cntReport(user_idx);
			String pstr = "";
			if(report_cnt >= 5){
				pstr = "[신고 횟수 "+report_cnt+"회]";
			}
			
			ArrayList<ReviewDTO> varr = vdao.selectReview(user_idx);
			if(varr == null || varr.size() == 0){
				%>
				<p class="profile_star">남겨진 리뷰가 없습니다. <span style="color: red;"><%=pstr %></span></p>
				<%
			}else {
				int vsum = 0;
				int vcnt = 0;
				for(int i = 0; i < varr.size(); i++){
					vsum += varr.get(i).getReview_rate();
					vcnt ++;
				}
				double vavg = (double)vsum / vcnt;
				String star = "";
				if(vavg >= 4.5){
					star = "★★★★★";
				}else if(vavg >= 3.5){
					star = "★★★★☆";
				}else if(vavg >= 2.5){
					star = "★★★☆☆";
				}else if(vavg >= 1.5){
					star = "★★☆☆☆";
				}else{
					star = "★☆☆☆☆";
				}
				%>
				<p class="profile_star"><%=star %>(<%=varr.size() %> 리뷰) 평점 <%=(double)Math.round((vavg*10))/10 %> <span style="color: red;"><%=pstr %></span></p>
				<%
			}
			%>
			
			<%
			int how = bdto.getBbs_how();
			String how_s = "";
			switch(how){
			case 0:how_s = "자유"; break;
			case 1:how_s = "직거래"; break;
			case 2:how_s = "택배"; break;
			}
			%>
			
			<pre class="item_text">거래장소 : <%=bdto.getBbs_place() %><br>거래방법 : <%=how_s %><br><%=bdto.getBbs_content().replaceAll("\n", "<br>")%></pre>
			<div class="btn">
			<hr>
			<%if(midx!=0) {
			%>
				<a href="reWrite.jsp?bbs_idx=<%=bbs_idx%>&bbs_writer_idx=<%=bdto.getBbs_writer_idx()%>">
				수정
				</a>
				<a href="#" onclick="openDel();">
				삭제
				</a>
				<a href="#" onclick="openRivew();">
				리뷰 
				</a>
				<a href="/brick_market/report/report.jsp?bbs_idx=<%=bbs_idx%>">
				신고 
				</a>
			<%}else{ %>
			<%}
			int like=-1;
			if(midx!=0){
				like=ldao.checkLike(bbs_idx, midx);
				if(like==1){
					%><a href="likeUpdate_ok.jsp?bbs_idx=<%=bbs_idx %>&user_idx=<%=midx %>&check=1" >좋아요 취소</a><% 
				}else if(like==0){
					%><a href="likeUpdate_ok.jsp?bbs_idx=<%=bbs_idx %>&user_idx=<%=midx %>&check=0" >좋아요 &hearts;</a><%
				}else{
					%><a href="likeUpdate_ok.jsp?bbs_idx=<%=bbs_idx %>&user_idx=<%=midx %>&check=2" >좋아요 &hearts;</a><%
				}
			}else{
				%><span>로그인후 이용가능</span><% 
			}
			 %>
			</div>
		</article>
		
		<article class="mid">
			<hr>
		<fieldset>
		<script>
		
		function rereplyselect(img,date,nick,content,size,idx,ref){
			var str='<div class="mid">';
			for( i=0;i<size;i++){
			
				str+='<div class="arrow">&hookrightarrow;</div>'+
				'<div><img class="img" src="'+img[i]+'"></div>'+
				'<div class= "date">'+date[i]+'</div>'+
				'<div class="nick">'+nick[i]+'</div>'+
				'<div class="content">'+content[i]+'</div>'+
				'<div class="tag">수정 삭제</div>';
			}
			if(<%=midx%>!=0){
				
			str+='<div class="rereplying"><form action="rereply_ok.jsp?" method="post">'+
			'<div class="arrow">&nbsp;&nbsp;&nbsp;&hookrightarrow;</div>'+
			'<div><img class="img" src="<%=mdtoheader.getMember_img()%>"></div>'+
			'<div class="content"><textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required></textarea></div>'+
			'<input type="hidden" name="reply_write_idx" value="<%=midx%>">'+
			'<input type="hidden" name="ref" value="'+ref+'">'+
			'<input type="hidden" name="cp" value="<%=cp%>">'+
			'<input type="hidden" name="bbs_idx" value="<%=bbs_idx%>">'+
			'<div onclick="javascript:noreply('+idx+');">숨기기</div>'+///////////////////////////////
			'<div class="tag"><input type="submit" class="submit" value="등록"></div></form></div>';
			}else{
				str+='<div>로그인후 작성 가능합니다</div>';
			}
			document.querySelector('.rereply'+idx).innerHTML=''+str;
			
					
		}
	
		
		function rereply(idx,ref) {
			str='';
			if(<%=midx%>!=0){
				str+='<div class="rereplying"><form action="rereply_ok.jsp?bbs_idx=<%=bbs_idx%>" method="post">'+
				'<div class="arrow">&nbsp;&nbsp;&nbsp;&hookrightarrow;</div>'+
				'<div><img class="img" src="<%=mdtoheader.getMember_img()%>"></div>'+
				'<div class="content"><textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required></textarea></div>'+
				'<input type="hidden" name="reply_write_idx" value="<%=midx%>">'+
				'<input type="hidden" name="ref" value="'+ref+'">'+
				'<input type="hidden" name="cp" value="<%=cp%>">'+
				'<input type="hidden" name="bbs_idx" value="<%=bbs_idx%>">'+
				'<div onclick="javascript:noreply('+idx+');">숨기기</div>'+/////////////////////////////
				'<div class="sese"><input type="submit" class="submit" value="등록"></div></form></div>';
			}else{
				str+='로그인후 작성 가능합니다';
			}
			document.querySelector('.rereply'+idx).innerHTML=''+str;
		}
		
		function noreply(idx) {
			document.querySelector('.rereply'+idx).innerHTML='';
		}
		</script>
			<legend>댓글</legend>
			<%
			ArrayList<ReplyDTO> rearr=rdao.replyList(bbs_idx, listSize, cp);
			if(rearr==null||rearr.size()==0){
				%>등록된 댓글이 없습니다<%
			}else{
				%>
				
				<% 
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
						content<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getReply_content().replaceAll("\r\n", "<br>").replace("'", "\'").replace("\\", "\\\\")%>';
							img<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getMember_img()%>';
							</script>
							<%
						}
						%><script>
						
						</script><%
					}
				%>
				<div class="main">
				<div class="date"><%=rearr.get(i).getReply_date() %></div> 
				<div><img class="img" src="<%=replyMember.getMember_img()%>"></div>
				<div class="nick"><%=replyMember.getMember_nick() %></div>
				<div id="content" class="updatereply<%=rearr.get(i).getReply_idx()%>"><%=rearr.get(i).getReply_content() %></div>
				<div class="tag">
				<%if(rereply.size()!=0){
					%>
					<span onclick="javascript:rereplyselect(img<%=rearr.get(i).getReply_idx()%>,date<%=rearr.get(i).getReply_idx()%>,nick<%=rearr.get(i).getReply_idx()%>,content<%=rearr.get(i).getReply_idx()%>,<%=rereply.size()%>,<%=rearr.get(i).getReply_idx()%>,<%=rearr.get(i).getReply_ref()%>);">등록된답글<%=rereply.size()%></span>
					<%
				}else{
					
					%><span class="pl"><a onclick="javascript:rereply(<%=rearr.get(i).getReply_idx()%>,<%=rearr.get(i).getReply_ref()%>);">등록된답글<%=rereply.size() %></a></span> <%
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
			}	
			 %>
							<form action="reply_ok.jsp?" method="post">
					
					<%
					if (midx == 0) {
					%>로그인후 댓글입력가능
					<%
					} else {
					%>
						<div class="replying"><img class="img" src="<%=mdtoheader.getMember_img()%>" alt="내사진"></div>
							<div class="nick"><%=mdtoheader.getMember_nick()%></div>
							<textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required ></textarea>
							<input type="hidden" name="reply_bbs_idx" value="<%=bbs_idx%>">
							<input type="hidden" name="reply_write_idx" value="<%=midx%>">
							<div class="sese">
							<input class="submit" type="submit" value="등록">
							</div>
							</form>
					<%
					}
					
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
			</fieldset>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>