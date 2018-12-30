<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String memberId = request.getParameter("memberId");
	System.out.println("memberId@updatePassword.jsp=" + memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 비밀번호 변경</title>
<script src="<%=request.getContextPath() %>/js/jquery-3.3.1.js"></script>
<style>
div#updatePassword-container{
	background: red;
	
}
div#updatePassword-container table{
	margin: 0 auto;
	border-spacing: 20px;
	
}
div#updatePassword-container table tr:last-of-type td{
	text-align: center;
}


</style>
</head>
<body>
	<div id="updatePassword-container">
		<form action="<%=request.getContextPath() %>/member/updatePasswordEnd"
			  name="updatePasswordFrm"
			  method="post">
			  <table>
			  	<tr>
			  		<td><input type="hidden" 
			  				   name="memberId" 
			  				   value="<%=memberId%>"
			  				   required/>
			  		</td>
			  	</tr>
			  	<tr>
			  	<tr>
			  		<th>현재비밀번호</th>
			  		<td><input type="password" 
			  				   name="password" 
			  				   id="password" 
			  				   required/>
			  		</td>
			  	</tr>
			  	<tr>
			  		<th>새 비밀번호</th>
			  		<td><input type="password" 
			  				   name="password_new" 
			  				   id="password_new" 
			  				   required/>
			  		</td>
			  	</tr>
			  	<tr>
			  		<th>새 비밀번호 확인</th>
			  		<td><input type="password" 
			  				   id="password_check" 
			  				   required/>
			  		</td>
			  	</tr>
			  	<tr>
			  		<td colspan="2">
			  		<input type="submit" 
			  			   onclick="return passwordValidate();"
			  			   value="변경" />
			  		<input type="button"
			  			   onclick="self.close();"
			  			   value="취소" />
			  		</td>
			  	</tr>
			  </table>
		</form>
	</div>




















</body>
</html>