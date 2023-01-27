<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/brick_market/css/maincss.css">
<style>

section {
	margin: 0px auto;
	text-align: center;
	height: 400px;
}
section article {
	margin: 0px auto;
	text-align: center;
}

section article div {
	display: inline-block;
	float:left;
	text-align: center;
    padding: 0;
    margin: 0;
    box-sizing: border-box;
    font-size: 0;
    letter-spacing: 0;
    word-spacing: 0;
}

.content {
	width: 800px;
	height: 400px;
}

.content_left {
	width: 50%;
	height: 100%;
	background-color: rgb(50,50,50);
}

.content_right {
	width: 50%;
	height: 100%;
	background-color: rgb(150,150,150);
}

.content_right_head {
	width: 100%;
	height: 40%;
	background-color: rgb(200,200,200);
}

.content_right_head_title {
	width: 100%;
	height: 40%;
	background-color: rgb(50,250,250);
}
.content_right_head_price {
	width: 100%;
	height: 20%;
	background-color: rgb(250,50,250);
}
.content_right_head_profile {
	width: 100%;
	height: 40%;
	background-color: rgb(250,250,50);
}

.content_right_head_profile_left {

}
.content_right_head_profile_right {

}


</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
	<article>
		<div class="content">
			<div class="content_left">
			
			</div>
			
			<div class="content_right">
				<div class="content_right_head">
					<div class="content_right_head_title"></div>
					<div class="content_right_head_price"></div>
					<div class="content_right_head_profile">
						<div class="content_right_head_profile_left">
						
						</div>
						<div class="content_right_head_profile_right">
							<div class="content_right_head_profile_right_nick"></div>
							<div class="content_right_head_profile_right_review"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>