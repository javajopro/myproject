<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<%@ page import="com.kh.board.model.vo.*" %>  
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<%
	Member logm = (Member)request.getAttribute("memberLoggedIn");
	
	Board b = (Board)request.getAttribute("board");
	
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

$(function () {
	$("[name=up_file]").change(function () {
		console.log($(this).val());//가짜경로 이거나 """
		if($(this).val() != ""){
			$("span#fname").hide();
		}else{
			$("span#fname").show();
		}
	});
});
</script>
<section id="board-container">
<h2>게시판 작성</h2>
<form action="<%=request.getContextPath() %>/board/boardUpdateEnd" 
	  method="post"
	  enctype="multipart/form-data"><!-- 파일업로드를 위한 필수속성 -->
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td>
			<input type="text" name="boardTitle" value = "<%=b.getBoardTitle()%>" required>
			<input type="hidden" name="boardNo" value="<%=b.getBoardNo()%>" />	
		</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<!--로그인한 회원명출력-->
			<%=b.getBoardWriter() %>
			<input type="hidden" name="boardWriter" value="<%=b.getBoardWriter() %>" readonly="readonly"> 
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td style="position:relative;">			
			<input type="file" name="up_file">
			<span id="fname"><%=b.getOrginalFileName()!=null?b.getOrginalFileName():"" %></span>
			
			<!-- 파일변경시 삭제를 위해 --> 
			<input type="hidden" name="old_renamed_file" 
				   value="<%=b.getRenamedFileName()%>" />
			<input type="hidden" name="old_original_file"
				   value="<%=b.getOrginalFileName()%>" />
			
						
			<%if(b.getOrginalFileName() != null) {%>
			<br />
			<input type="checkbox" 
				   name="del_file" 
				   id="del_file" />
			<label for="del_file">첨부파일 삭제</label>
			<%} %>
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="50" name="boardContent"><%=b.getBoardContent() %></textarea></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="수정하기" onclick="return validate();">
		</th>
	</tr>
</table>
</form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>