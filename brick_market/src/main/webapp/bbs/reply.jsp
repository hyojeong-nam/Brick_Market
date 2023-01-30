<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%String idx=(String)session.getAttribute("id"); %>
	
<section>
	<hr>
	<form action="reply_ok.jsp">
		<fieldset>
			<legend>댓글</legend>
			<table>
				<tr>
					<td>댓글1</td><td><input type="button" value="대댓글달기" ></td>
				</tr>
				<tr>
					<td>댓글2</td>
				</tr>
				<tr>
					<td>댓글3</td>
				</tr>
				<tr>
					<td>댓글4</td>
				</tr>
				<tr>
				<td>자신의 닉네임</td>
				<td><input type="text" name="" placeholder="댓글을 입력해보세요"></td> 
				<td><input type="submit" value="등록"></td>
				</tr>
			</table>
		</fieldset>
	</form>

</section>
