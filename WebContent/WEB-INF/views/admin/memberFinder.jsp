<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>  
  
<%
    List<Member> list = (List<Member>)request.getAttribute("list");
    
	
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	
	int numPerPage = (int)request.getAttribute("numPerPage");
	int cPage = (int)request.getAttribute("cPage");
	String pageBar = (String)request.getAttribute("pageBar");
	
	
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/admin.css" />
<style>
div#search-memberId{
	display: <%="memberId".equals(searchType)?"inline-block":"none"%>
}
div#search-memberName{
	display: <%="memberName".equals(searchType)?"inline-block":"none"%>
}
div#search-gender{
	display: <%="gender".equals(searchType)?"inline-block":"none"%>
}
</style>


<script>
$(function(){
	var sid = $("#search-memberId");
	var sname = $("#search-memberName");
	var sgender = $("#search-gender");
	
	$("select#searchType").change(function(){
		sid.hide();
		sname.hide();
		sgender.hide();
		
		$("#search-"+$(this).val()).css("display","inline-block");
	});
	
	
	
});

</script>


<section id="memberList-container">
	<h2>회원관리</h2>
	<!-- 검색 시작 -->
	<div id="search-container">
		검색 타입 : 
		<select id="searchType">
			<option value="memberId" <%="memberId".equals(searchType)?"selected":"" %>>아이디</option>
			<option value="memberName" <%="memberName".equals(searchType)?"selected":"" %>>회원명</option>
			<option value="gender" <%="gender".equals(searchType)?"selected":"" %>>성별</option>
		</select>
		<!-- 아이디 검색폼 -->
		<div id="search-memberId">
			<form action="<%=request.getContextPath() %>/admin/memberFinder">
				<input type="hidden" 
					   name="numPerPage"
					   value="<%=numPerPage%>" />
				<input type="hidden" 
					   name="numPerPage"
					   value="<%=searchType%>" />
				<input type="hidden" 
					   name="numPerPage"
					   value="<%=searchKeyword%>" />
				<input type="hidden" 
					   name="numPerPage"
					   value="<%=cPage%>" />	   
				<input type="hidden" 
					   name="searchType"
					   value="memberId" />
				<input type="search"
					   name="searchKeyword"
					   size="25"
					   placeholder="검색할 아이디를 입력하세요."
					   value="<%="memberId".equals(searchType)?searchKeyword:"" %>" />
				<button type="submit">검색</button>
			</form>
		</div>
		<div id="search-memberName">
		<!-- 회원명 검색폼 -->	
			<form action="<%=request.getContextPath() %>/admin/memberFinder">
				<input type="hidden" 
					   name="numPerPage"
					   value="<%=numPerPage%>" /> 
				<input type="hidden" 
					   name="numPerPage"
					   value="<%=cPage%>" />
				<input type="hidden" 
					   name="numPerPage"
					   value="<%=searchType%>" />
				<input type="hidden" 
					   name="numPerPage"
					   value="<%=searchKeyword%>" />
				<input type="hidden" 
					   name="searchType"
					   value="memberName" />
				<input type="search"
					   name="searchKeyword"
					   size="25"
					   placeholder="검색할 회원명을 입력하세요."
					   value="<%="memberName".equals(searchType)?searchKeyword:"" %>" />
				<button type="submit">검색</button>
			</form>
		</div>
		<div id="search-gender">
		<!-- 성별 검색폼 -->
			<form action="<%=request.getContextPath() %>/admin/memberFinder">
			<input type="hidden" 
					   name="numPerPage"
					   value="<%=numPerPage%>" /> 
			<input type="hidden" 
					   name="numPerPage"
					   value="<%=cPage%>" />
			<input type="hidden" 
					   name="numPerPage"
					   value="<%=searchType%>" />
			<input type="hidden" 
					   name="numPerPage"
					   value="<%=searchKeyword%>" />	
				
			<input type="hidden" 
                  name="searchType"
                  value="gender" />
            <input type="radio" 
                  name="searchKeyword"
                  value="M"
                  id="gender0"
                  <%="gender".equals(searchType)&&"M".equals(searchKeyword)?"checked":"" %>/>
            <label for="gender0">남</label>
            <input type="radio" 
                  name="searchKeyword"
                  value="F"
                  id="gender1"
                  <%="gender".equals(searchType)&&"F".equals(searchKeyword)?"checked":"" %>/>
            <label for="gender1">여</label>
				<button type="submit">검색</button>
			</form>
		</div>
	</div>
	<!-- 검색 끝 -->
	
	
	<table id="tbl-member">
		<thead>
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>성별</td>
				<td>나이</td>
				<td>이메일</td>
				<td>전화번호</td>
				<td>주소</td>
				<td>취미</td>
				<td>가입날짜</td>
			</tr>
		</thead>
		<tbody>
			<% if(list == null || list.isEmpty()){ %>
				<tr>
					<td colspan="9" align="center">검색 결과가 없습니다.</td>
				</tr>
			<%} 
			else {
				for(Member m :list) {
			%>
				<tr>
					<td>
						<a href="<%=request.getContextPath()%>/member/memberView?memberId=<%=m.getMemberId() %>">
						<%=m.getMemberId() %>
						</a>
					</td>
					<td><%=m.getMemberName() %></td>
					<td><%="M".equals(m.getGender())?"남":"여" %></td>
					
					<td><%=m.getAge() %></td>
					<td><%=m.getEmail() %></td>
					<td><%=m.getPhone() %></td>
					<td><%=m.getAddress() %></td>
					<td><%=m.getHobby() %></td>
					<td><%=m.getEnrollDate() %></td>
					
					
				</tr>
				<%} %>
			<%} %>
		</tbody>
	</table>
	<div id="pageBar">
	<%=pageBar %>
	</div>
</section>




<%@ include file="/WEB-INF/views/common/footer.jsp" %>