<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="rdao" class="com.team4.reply.ReplyDAO" scope="session"></jsp:useBean>
<%@page import="java.util.*"%>
<%@page import="com.team4.reply.ReplyDTO"%>
<%
ArrayList<ReplyDTO> arr = rdao.replyList(bbs_idx);
%>

<section>
	<hr>
	<form action="reply_ok.jsp">
		<fieldset>
			<legend>댓글</legend>
			<table>
				<tr>
					<%
					if (arr == null || arr.size() == 0) {
					%><td>등록된 댓글이 없습니다.</td>
					<%
					} else {
					for (int i = 0; i < arr.size(); i++) {
					%><td><%=arr.get(i).getReply_content()%></td>
					<td><%=arr.get(i).getReply_date()%></td>
					<%
					}

					}
					%>
				</tr>
				<tr>
					<td><%=mdto.getMember_nick()%></td>
					<td><input type="text" name="reply_content"
						placeholder="댓글을 입력해보세요"></td>
					<td><input type="submit" value="등록"></td>
					<td><input type="hidden" name="reply_bbs_idx"
						value="<%=bbs_idx%>"></td>
					<td><input type="hidden" name="reply_write_idx"
						value="<%=user_idx%>"></td>
				</tr>
			</table>
		</fieldset>
	</form>

</section>
