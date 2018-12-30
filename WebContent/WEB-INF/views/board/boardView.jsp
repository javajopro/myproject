<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.kh.board.model.vo.*" %>  
<%@ include file = "/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<script>
function fileDownload(oName, rName){
	var url = "<%=request.getContextPath()%>/board/fileDownload";
	//oName에는 한글, 공백 등 문자가 섞여 있을 수 있어서 인코딩 처리가 필요함.
	//ie는 암묵적인 인코딩을 지원하지 않으므로 명시적인 인코딩이 필요함.
	oName = encodeURIComponent(oName);
	//console.log("oName = ",oName);
	location.href = url + "?oName="+oName+"&rName="+rName;
}





</script>
<%
	String boardNo = request.getParameter("boardNo");
	
	Board b = (Board)request.getAttribute("b");
	List<BoardComment> commentList = 
			(List<BoardComment>)request.getAttribute("commentList");
	System.out.println("commentList = "+commentList);
%>

<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board-view">
		<tr>
			<th>글번호</th>
			<td><%=b.getBoardNo() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=b.getBoardTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=b.getBoardWriter() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=b.getReadCount() %></td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<!-- 첨부파일이 있는 경우만 표시돼야함 -->
				<a href="javascript:fileDownload(
							'<%=b.getOrginalFileName() %>',
							'<%=b.getRenamedFileName() %>');">
					<img src="<%=request.getContextPath() %>/images/file.png"
						 alt="첨부파일"
						 width="16px" />
					 <!-- 파일명 -->
					 <%=b.getOrginalFileName()!=null?b.getOrginalFileName():"" %>
				</a>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=b.getBoardContent() %></td>
		</tr>
		<!-- 글작성자/관리자인경우만 표시되야함.  -->
		 <% if((memberLoggedIn!=null)&&(b.getBoardWriter().equals(memberLoggedIn.getMemberId())
				|| "admin".equals(memberLoggedIn.getMemberId())) ){  %> 
		<tr>
			<th colspan="2">
				<input type="button" value="수정하기" onclick="updateBoard()" />
				<input type="button" value="삭제하기" onclick="deleteBoard()" />
			</th>
		</tr>
		<%} %>
	
	</table>
	<hr style="margin-top: 30px;" />
	<!-- 댓글시작 -->
	<div id="comment-container">
		<div class="comment-editor">
			<form action="<%=request.getContextPath() %>/board/boardCommentInsert"
				  method="post"
				  name="boardCommentFrm" >
				<input type="hidden" 
					   name="boardRef"
					   value="<%=b.getBoardNo() %>" />
				<input type="hidden" 
					   name="boardCommentWriter"
					   value="<%=memberLoggedIn!=null?memberLoggedIn.getMemberId():"" %>" />
				<input type="hidden" 
					   name="boardCommentLevel"
					   value="1" /> <!-- 댓글레벨 : 1 -->
				<input type="hidden" 
					   name="boardCommentRef"
					   value="0" />
				<textarea name="boardCommentContent" 
						  cols="60" 
						  rows="3">
				</textarea>
				<button type="submit"
						id="btn-insert">
					등록
				</button>
			</form>
		</div> <!-- end of .comment-editor -->
		
		<!-- 댓글 목록 테이블 -->
		<table id="tbl-comment">
		<% for(BoardComment bc: commentList) {
			if(bc.getBoardCommentLevel() == 1){
		%>
			<tr class="level1">
				<td>
					<sub class="comment-writer">
						<%=bc.getBoardCommentWriter() %>
					</sub>
					<sub class="comment-date">
						<%=bc.getBoardCommentDate() %> 
					</sub>
					<br />
					<%=bc.getBoardCommentContent() %>
				</td>
				<td>
					<button class="btn-reply"
							value="<%=bc.getBoardCommentNo()%>">
							답글
			
					</button>
				
			
					<!-- 실습문제 :
					관리자이거나, 본인이 쓴 댓글(대댓글)에 대해서만 삭제버튼이 보여야 한다.
					삭제요청처리후에는 현재페이지가 다시보여줘야 한다. -->
				<%if(memberLoggedIn!=null 
						&& ("admin".equals(memberLoggedIn.getMemberId()) 
								|| bc.getBoardCommentWriter().equals(memberLoggedIn.getMemberId()) )){%>
					<button class="btn-delete" value="<%=bc.getBoardCommentNo()%>" >삭제</button>
				<%} %>
				</td>
			</tr>
		
		
		<%} 
		 else {%>
		 	<tr class="level2">
				<td>
					<sub class="comment-writer">
						<%=bc.getBoardCommentWriter() %>
					</sub>
					<sub class="comment-date">
						<%=bc.getBoardCommentDate() %> 
					</sub>
					<br />
					<%=bc.getBoardCommentContent() %>
				</td>
				<td>
				
				
				<%if(memberLoggedIn!=null 
						&& ("admin".equals(memberLoggedIn.getMemberId()) 
								|| bc.getBoardCommentWriter().equals(memberLoggedIn.getMemberId()) )){%>
					<button class="btn-delete" value="<%=bc.getBoardCommentNo()%>" >삭제</button>
				<%} %>
			
				</td>
			</tr>
		 
		 
		 
		<% }
		  } %>
		</table>
		
	</div> <!-- end of.comment-container -->
	<!-- 댓글 끝 -->
	<script>
	//textarea click이벤트 핸들러
	$("[name=boardCommentContent]").on('click', function () {
		if(<%=memberLoggedIn == null%>)
			loginAlert();
	});
	
	//댓글form submit이벤트핸들러
	$("[name=boardCommentFrm]").submit(function(e) {
		if(<%=memberLoggedIn == null%>){
			loginAlert();
			e.preventDefault(); //submit 방지
			return;
		}
		//boardCommentContent 유효성검사
		var len = $("[name=boardCommentContent]").val()
												 .trim()
												 .length;
		if(len == 0){
			alert("댓글을 작성하세요.");
			e.preventDefault();			
		}
	});
	
	function loginAlert(){
		alert("로그인 후 이용할 수 있습니다.");
		$("#memberId").focus();
		
	}
	
	$(".btn-reply").on("click", function () {
		<% if(memberLoggedIn != null) {%>
		<%--로그인한경우--%>
			var tr = $("<tr></tr>");
			var html = '<td style="display:none; text-align:left;" colspan="2">';
			html += '<form action="boardCommentInsert" method="post">';
			html += '<input type="hidden" name="boardRef" value="<%=b.getBoardNo()%>"/>';
			html += '<input type="hidden" name="boardCommentWriter" value="<%=memberLoggedIn.getMemberId()%>"/>';
			html += '<input type="hidden" name="boardCommentLevel" value="2"/>';
			html += '<input type="hidden" name="boardCommentRef" value="'+$(this).val()+'"/>';
			html += '<textarea name="boardCommentContent" cols="60" rows="1"></textarea>';
			html += '<button type="submit" class="btn-insert2" >등록</button>';
			html += '</form></td>';
			tr.html(html);
			
			tr.insertAfter($(this).parent().parent())
			  .children("td").slideDown(800);
			
			//한번 실행후 이벤트핸들러 제거
			$(this).off('click');
			
			//생성된 폼에 대해 submit이벤트핸들러
			tr.find('form').submit(function(e){
				var len = $(this).find("textarea").val().trim().length;
				if(len == 0){
					e.preventDefault();
					alert("내용 입력해 주세요");
					
				}
			});
			
			
		<%} else {%>
		<%--로그인 하지 않은 경우--%>
			loginAlert();
			
		<%}%>
	});
	
	//삭제버튼 클릭시
    $(".btn-delete").click(function(){
        if(!confirm("정말 삭제하시겠습니까?")) return;
        //삭제처리후 돌아올 현재게시판번호도 함께 전송함.
        location.href="<%=request.getContextPath()%>/board/boardCommentDelete?boardNo=<%=b.getBoardNo() %>&del="+$(this).val();
    });
	
	
	</script>
</section>
<!-- 글작성자/관리자인경우만 표시되야함.  -->
 <% if((memberLoggedIn!=null)&&(b.getBoardWriter().equals(memberLoggedIn.getMemberId())
		|| "admin".equals(memberLoggedIn.getMemberId())) ){  %> 
<form action="<%=request.getContextPath()%>/board/boardDelete"
	  name="boardDelFrm"
	  method="post">
	  <input type="hidden" name="boardNo"
	  		 value="<%=b.getBoardNo() %>" />
	  <input type="hidden" name="rName"
	  		 value="<%=b.getRenamedFileName() %>" />
</form>
<script>
function updateBoard(){
	location.href = "<%=request.getContextPath()%>/board/boardUpdate?boardNo=<%=b.getBoardNo() %>";
	
}
function deleteBoard(){
	if(!confirm("이 게시글을 정말 삭제하시겠습니까?")){
		return;
	}
	$("[name=boardDelFrm]").submit();
}

/* function commentDelete(){
	
}
 */
</script>
<% } %>



<%@ include file = "/WEB-INF/views/common/footer.jsp" %>