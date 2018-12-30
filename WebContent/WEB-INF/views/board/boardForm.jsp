<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<%
	Member logm = (Member)request.getAttribute("memberLoggedIn");

%>
<script>
function validate(){
	
	var content = $("[name=content]").val();
	if(content.trim().length==0){
		alert("내용을 입력하세요.");
		return false;
	}

	return true;
}
</script>
<section id="board-container">
<h2>게시판 작성</h2>
<form action="<%=request.getContextPath() %>/board/boardFormEnd" 
	  method="post"
	  enctype="multipart/form-data"><!-- 파일업로드를 위한 필수속성 -->
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td><input type="text" name="title" required></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<!--로그인한 회원명출력-->
			<%=logm.getMemberName() %>
			<input type="hidden" name="writer" value="<%=logm.getMemberId() %>" readonly="readonly">
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>			
			<input type="file" name="up_file">
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="50" name="content"></textarea></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="등록하기" onclick="return validate();">
		</th>
	</tr>
</table>
</form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>