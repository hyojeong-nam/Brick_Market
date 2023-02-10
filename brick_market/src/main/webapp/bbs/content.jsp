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
	height: 350px;
	width: 350px;
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
	text-decoration: none;
	color: rgb(243,114,62);
}


fieldset {
	width: 800px;
margin: auto;
border: 0px;

}
.main{
margin-top: 30px;
margin-bottom: 30px;
border: 3px solid rgb(243,114,62,0.3);
padding: 10px 4px;
}
.replying{

border: 3px solid rgb(243,114,62,0.3);
padding: 20px 0px 50px 0px;
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
max-width: 580px;
word-wrap:break-word;
}
.tag{
text-align: right;
}
.arrow{
text-align: left;
margin-top: 10px;
}
div .mid .img{
display:inline-block;
margin-left: 30px;
}
div .mid .nick{
margin-left: 100px;
}
div .mid .content{
text-align: left;
margin-left: 160px;
max-width: 500px;
}
.replying{
margin-top: 20px;
width: max(100%);
margin-bottom: 30px;
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
.sese{
text-align: right;
margin-top: 20px;
margin-right: 30px;
}
div .tag a:hover{
	color: rgb(243,114,62);
}
div .tag a{
	text-decoration: none;
	color: black;
}
div .tag span:hover{
	color: rgb(243,114,62);
}
div .tag span{
	text-decoration: none;
	color: black;
}
.sese input{
margin-top: 20px;
}
.replying .nick{
display: block;
float: left;
margin-left: 20px;
}
.replying textarea{
z-index: 1;
float: left;
margin-left: 10px;
}
.rereplying textarea{
display: inline-block;
float: left;
}
.tag{
margin-right: 30px;

}
.page{
margin-top: 70px;
}
textarea {
padding: 10px;
margin-left: 20px;
}
form{
}
.nn textarea {
	margin-bottom: 20px;
}
.nn{
margin-bottom: 30px;
}
.mid #zz textarea {
margin-left: 0px;
padding-left: 10px;
}
div .content{
word-wrap:break-word;

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

//댓글삭제 메서드
function delete_reply(ref) {
	var bl =window.confirm('삭제하시겠습니까?');
	if(bl){
		location.href='deleteReply.jsp?ref='+ref+'&bbs_idx=<%=bbs_idx%>';
	}
}
function delete_rereply(idx,widx) {
	var bl =window.confirm('삭제하시겠습니까?');
	if(bl){
		location.href='deleteReply.jsp?idx='+idx+'&bbs_idx=<%=bbs_idx%>';
	}
}
function openDel(){
	window.open('delete.jsp?bbs_idx=<%=bbs_idx%>&bbs_writer_idx=<%=bdto.getBbs_writer_idx()%>',
			+'delPage','width=520,height=250');	
}
function openReport(){
	window.open('/brick_market/report/report.jsp?bbs_idx=<%=bbs_idx%>',
			+'reportPage','width=570,height=300');	
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
				<a href="#" onclick="openReport();">
				신고 
				</a>
			<%}else{ %>
			<%}
			int like=-1;
			if(midx!=0){
				like=ldao.checkLike(bbs_idx, midx);
				if(like==1){
					%><a href="likeUpdate_ok.jsp?bbs_idx=<%=bbs_idx %>&user_idx=<%=midx %>&check=1" >관심글 취소</a><% 
				}else if(like==0){
					%><a href="likeUpdate_ok.jsp?bbs_idx=<%=bbs_idx %>&user_idx=<%=midx %>&check=0" >관심글 &hearts;</a><%
				}else{
					%><a href="likeUpdate_ok.jsp?bbs_idx=<%=bbs_idx %>&user_idx=<%=midx %>&check=2" >관심글 &hearts;</a><%
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
		// 댓글 입력 가능 여부 메서드
		function submitstr(bl,ref,idx) {
			if(bl){
			var submitstr='<div class="rereplying"><form action="rereply_ok.jsp?" method="post">'+
			'<div class="arrow">&nbsp;&nbsp;&nbsp;&hookrightarrow;</div>'+
			'<div><img class="img" src="<%=mdtoheader.getMember_img()%>"></div>'+
			'<div class="content"><textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required></textarea></div>'+
			'<input type="hidden" name="reply_write_idx" value="<%=midx%>">'+
			'<input type="hidden" name="ref" value="'+ref+'">'+
			'<input type="hidden" name="cp" value="<%=cp%>">'+
			'<input type="hidden" name="bbs_idx" value="<%=bbs_idx%>">'+
			'<div onclick="javascript:noreply('+idx+');">숨기기</div>'+
			'<div class="tag"><input type="submit" class="submit" value="등록"></div></form></div>';
			return submitstr;
				}else{
				var submitstr='<div>로그인후 댓글입력 가능</div>';
				return submitstr;
				}
			}
		//대댓보기 메서드 
		function rereplyselect(img,date,nick,content,size,idx,ref,widx,reidx){
			var str='<div class="mid" id="zz">';
			for( i=0;i<size;i++){
				str+='<div class="arrow">&hookrightarrow;</div>'+
				'<div><img class="img" src="'+img[i]+'"></div>'+
				'<div class= "date">'+date[i]+'</div>'+
				'<div class="nick">'+nick[i]+'</div>'
				+'<div class="content">'+content[i]+'</div>';
				
			}
			
			str+=submitstr(<%=midx!=0%>,ref,idx);
			document.querySelector('.rereply'+idx).innerHTML=''+str+'';
		}
		//대댓 없을경우 대댓보기 메서드
		function rereply(idx,ref) {
			 str=submitstr(<%=midx!=0%>,ref,idx);
			document.querySelector('.rereply'+idx).innerHTML='<div class="nn">'+str+'</div><div class="nn">&nbsp;</div>';
		}
		//대댓 숨기기 메서드
		function noreply(idx) {
			document.querySelector('.rereply'+idx).innerHTML='';
		}
		</script>
			<legend>댓글</legend>
			<%
			ArrayList<ReplyDTO> rearr=rdao.replyList(bbs_idx, listSize, cp);
			if(rearr==null||rearr.size()==0){
				%><div>등록된 댓글이 없습니다</div><%
			}else{
				for(int i=0;i<rearr.size();i++){
					MemberDTO replyMember=mdao.searchIdx(rearr.get(i).getReply_write_idx());//댓글 게시자의 프로필 정보
					ArrayList <ReplyDTO> rereply=rdao.rereplyList(bbs_idx, rearr.get(i).getReply_ref());//대댓글
					if(rereply!=null&&rereply.size()!=0){
						%>
						<script>
						//배열 초기화
						var nick<%=rearr.get(i).getReply_idx()%>=new Array(<%=rereply.size()%>);
						var date<%=rearr.get(i).getReply_idx()%>=new Array(<%=rereply.size()%>);
						var img<%=rearr.get(i).getReply_idx()%>=new Array(<%=rereply.size()%>);
						var content<%=rearr.get(i).getReply_idx()%>=new Array(<%=rereply.size()%>);
						</script>
						<%
						for(int j=0;j<rereply.size();j++){
							%><script>
							//스키립트 배열에 데이터 등록 
							nick<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getMember_nick()%>';
							date<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getReply_date_s()%>';
							content<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getReply_content().replaceAll("\r\n", "<br>").replace("'", "\'").replace("\\", "\\\\")%>';
							img<%=rearr.get(i).getReply_idx()%>[<%=j%>]='<%=rereply.get(j).getMember_img()%>';
							</script>
							<%
						}
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
					<a href="#;"><span onclick="javascript:rereplyselect(img<%=rearr.get(i).getReply_idx()%>,date<%=rearr.get(i).getReply_idx()%>,nick<%=rearr.get(i).getReply_idx()%>,content<%=rearr.get(i).getReply_idx()%>,<%=rereply.size()%>,<%=rearr.get(i).getReply_idx()%>,<%=rearr.get(i).getReply_ref()%>,<%=rearr.get(i).getReply_write_idx()%>);">등록된답글<%=rereply.size()%></span></a>
					<%
				}else{
					%><span class="pl"><a href="#;" onclick="javascript:rereply(<%=rearr.get(i).getReply_idx()%>,<%=rearr.get(i).getReply_ref()%>);">등록된답글<%=rereply.size() %></a></span> <%
				} %>
				<%if(rearr.get(i).getReply_write_idx()==midx){
					%>
					<script>
					//수정캔슬
					function cancelupdatereply<%=rearr.get(i).getReply_idx()%>(idx,content){
						document.querySelector('.up'+idx).innerHTML='<a href="#;" onclick="javascript:updatereply<%=rearr.get(i).getReply_idx()%>(\'<%=rearr.get(i).getReply_content()%>\',<%=rearr.get(i).getReply_idx()%>);">수정</a>';
						document.querySelector('.updatereply'+idx).innerHTML=''+content;
					}
					//수정하기 메서드
					function updatereply<%=rearr.get(i).getReply_idx()%>(content,idx) {
						document.querySelector('.up'+idx).innerHTML='<a href="#;" onclick="javascript:cancelupdatereply<%=rearr.get(i).getReply_idx()%>('+idx+',\''+content+'\');">취소</a>';
						document.querySelector('.updatereply'+idx).innerHTML=''+
						'<form action="updateReply.jsp" method="post">'+
						'<div class="content"><textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="content" required>'+content+
						'</textarea></div>'+
						'<input type="hidden" name="reply_idx" value="'+idx+'">'+
						'<input type="hidden" name="bbs_idx" value="<%=bbs_idx%>">'+
						'<input type="hidden" name="cp" value="<%=cp%>">'+
						'<div class="sese"><input type="submit" value="등록"></div></form>';
					}
					</script>
					<span class="up<%=rearr.get(i).getReply_idx()%>"><a href="#;" onclick="javascript:updatereply<%=rearr.get(i).getReply_idx()%>('<%=rearr.get(i).getReply_content()%>',<%=rearr.get(i).getReply_idx()%>);">수정</a></span>
					<span><a href="#;" onclick="javascript:delete_reply(<%=rearr.get(i).getReply_ref()%>);">삭제</a></span>
					<% 
					}
				%>
				</div>
				<div class="rereply<%=rearr.get(i).getReply_idx()%>"></div></div>
				<% 
				}
			}	
			 %>
				<form action="reply_ok.jsp?" method="post">
					<%
					if (midx == 0) {
					%><div>로그인후 댓글입력가능</div>
					<%
					} else {
					%>
					<hr>
						<div class="replying"><img class="img" src="<%=mdtoheader.getMember_img()%>" alt="내사진">
							<div class="nick"><%=mdtoheader.getMember_nick()%></div>
							<textarea rows="5" cols="80" placeholder="답글을 입력해보세요" name="reply_content" required ></textarea>
							<div class="sese">
							<input class="submit" type="submit" value="등록">
							</div>
							<input type="hidden" name="reply_bbs_idx" value="<%=bbs_idx%>">
							<input type="hidden" name="reply_write_idx" value="<%=midx%>"></div>
							</form>
							<div class="page">
					<%
					}
					//////////////////페이징/////////////////////
						if (userGroup != 0) {
						%><a
						href="content.jsp?cp=<%=(userGroup - 1) * pageSize + 1%>&bbs_idx=<%=bbs_idx%>">&lt;&lt;</a></span>
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
						</div>
			</fieldset>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>