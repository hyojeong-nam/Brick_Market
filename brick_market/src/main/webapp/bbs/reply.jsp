<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="rdao" class="com.team4.reply.ReplyDAO" scope="session"></jsp:useBean>
<%@page import="java.util.*"%>
<%@page import="com.team4.reply.ReplyDTO"%>
<%
ArrayList<ReplyDTO> arr = rdao.replyList(bbs_idx);
String ref_s = request.getParameter("ref");
int ref = 0;
if (ref_s != null && ref_s.length() != 0) {
	ref = Integer.parseInt(ref_s);
}
%>
<style>
.test {
	border: solid 1px;
}
</style>
<section>
	<article>
		<hr>
		<form action="reply_ok.jsp">
			<fieldset class="test">
				<legend>댓글</legend>
				<table border="1">
					<tr>
						<%
						if (arr == null || arr.size() == 0) {
						%><td>등록된 댓글이 없습니다.</td>
						<%
						} else {
						for (int i = 0; i < arr.size(); i++) {
						%>
					
					<tr>
						<%
						MemberDTO marr = mdao.searchIdx(arr.get(i).getReply_write_idx());
						%>
						<td><%=marr.getMember_nick()%></td>
						<td><%=arr.get(i).getReply_content()%></td>
						<td><%=arr.get(i).getReply_date()%></td>
						<td><a
							href="content.jsp?bbs_idx=<%=bbs_idx%>&ref=<%=arr.get(i).getReply_ref()%>">답글</a></td>
					</tr>
					<%
					if (midx == arr.get(i).getReply_write_idx()) {
					%><tr>
						<td><a href="">수정</a> <a href="">삭제</a></td>
					</tr>
					<%
					}
					if (ref == arr.get(i).getReply_ref()) {
					%><tr>
						<td><%@include file="rereply.jsp"%></td>
					</tr>
					<%
					}
					}

					}
					%>
					<tr>
						<%
						if (midx == 0) {
						%><td>로그인후 댓글입력가능</td>
						<%
						} else {
						%>

						<td><%=mdto.getMember_nick()%>
						<input type="text" name="reply_content" placeholder="댓글을 입력해보세요">
						<input type="submit" value="등록"><input type="hidden" name="reply_bbs_idx" value="<%=bbs_idx%>">
						<input type="hidden" name="reply_write_idx" value="<%=midx%>"></td>
						<%
						}
						%>
					</tr>
				</table>
			</fieldset>
		</form>

	</article>
</section>
