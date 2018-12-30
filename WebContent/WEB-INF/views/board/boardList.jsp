<%@page import="com.kh.board.model.service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common/header.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="com.kh.board.model.vo.*" %>  

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/board.css" />
<%
    List<Board> list = (List<Board>)request.getAttribute("list");

	int cPage = (int)request.getAttribute("cPage");
	int numPerPage = (int)request.getAttribute("numPerPage");
	String pageBar = (String)request.getAttribute("pageBar");
	
	Member logm = (Member)request.getAttribute("memberLoggedIn");
	
	System.out.println("로그인자 : logm = "+logm);
	System.out.println("list="+ list);

%>


<script>
function goToBoardForm(){
	location.href= "<%=request.getContextPath()%>/board/boardForm";
	
	
}
</script>
<script>
$(function(){
	var btnadd = $("#btn-add");
	
	<%
	if(logm == null){%>
		btnadd.hide();
	<%
	}
	else{}
	%>
	
});

</script>
<section id="board-container">
	<h2>게시판</h2>
	<input type="button" value="글쓰기" id="btn-add" 
		   onclick="goToBoardForm();" />
	<table id="tbl-board">
		<thead>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th>
			<th>조회수</th>
		</tr>
		<!-- 스클립틀릿 처리요망 -->
		</thead>
		<tbody>
			<% if(list == null || list.isEmpty()){ %>
				<tr>
					<td colspan="9" align="center">검색 결과가 없습니다.</td>
				</tr>
			<%} 
			else {
				for(Board b :list) {
					
			%>
				<tr>
				
					<td><%=b.getBoardNo() %></td>
					
					<td>
					
						<a href="<%=request.getContextPath()%>/board/boardView?boardNo=<%=b.getBoardNo() %>">
						<%=b.getBoardTitle()%>
						
						<% if(b.getBoardCommentCnt()>0) {%>
						<%=" ["+b.getBoardCommentCnt()+"]" %>
						<%} %>
						
						</a>
					</td>
					
					<td><%=b.getBoardWriter() %></td>
					<td><%=b.getBoardDate() %></td>
					<td>
					<% if(b.getOrginalFileName() != null){ %>
						<img src="<%=request.getContextPath() %>/images/file.png" alt=""
							 width="16px" />
					<%} %>
					</td>
					<td><%=b.getReadCount() %></td>
					

				</tr>
				<%} %>
			<%} %>
		</tbody>
		
	</table>
	
	<div id="pageBar">
	<%=pageBar %>
	
	</div>
	
</section>
<%@ include file = "/WEB-INF/views/common/footer.jsp" %>