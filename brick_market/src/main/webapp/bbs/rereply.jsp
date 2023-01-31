<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<section>
<article>
<div><%=mdto.getMember_nick() %></div>
<form action="rereply_ok.jsp">
<input type="text" name="rereply">
<input type="submit" value="답글달기">
</form>
</article>
</section>