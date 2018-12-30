<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>
    
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
	Member m = (Member)request.getAttribute("member");
	
	//header.jsp의 변수명 충돌 방지용
	String memberId_ = m.getMemberId();
	String password = m.getPassword();
	String memberName = m.getMemberName();
	int age = m.getAge();
	String email = m.getEmail()!=null?m.getEmail():"";
	String phone = m.getPhone();
	String address = m.getAddress()!=null?m.getAddress():"";
	
	String gender = m.getGender();
	
	//예) 여행, 독서
	String hobby = m.getHobby();
	String[] hobbyArr = null;
	String[] hobbyChecked = new String[5];
	
	//사용자 아무 취미도 입력하지 않은 경우
	if(hobby != null){
		hobbyArr = hobby.split(",");
		
		for(int i=0; i<hobbyArr.length; i++){
			switch(hobbyArr[i]){
			case "운동": hobbyChecked[0] = "checked"; break;
			case "등산": hobbyChecked[1] = "checked"; break;
			case "독서": hobbyChecked[2] = "checked"; break;
			case "게임": hobbyChecked[3] = "checked"; break;
			case "여행": hobbyChecked[4] = "checked"; break;
			}
		}
		
	}
	
	//System.out.println(Arrays.toString(hobbyChecked));


%>
<script>
$(function() {
	//비밀번호 일치여부검사
	$("#password__").on("blur", passwordChecker);
});

/* function passwordChecker(){
	
		var p1 = $("#password_").val();
		var p2 = $("#password__").val();
		
		if(p1 != p2){
			alert("패스워드가 일치하지 않습니다.");
			$("#password_").select();
			return false;
		}
		return true;
} */

function updateValidate(){
	
	/* //비밀번호 최종검사
	if(passwordChecker() == false){
		return false;
	} */
	
	return true;
}

function deleteMember() {
	var bool = confirm("정말로 탈퇴하시겠습니까?");
	if(bool){
		<%-- location.href="<%=request.getContextPath()%>/member/memberDelete?memberId=<%=memberId_%>"; --%>
		var frm = document.memberUpdateFrm;
		
		frm.action = "<%=request.getContextPath()%>/member/memberDelete";
		frm.submit();
	}
}

//비밀번호 변경 팝업 요청
function updatePassword(){
	var url = "<%=request.getContextPath()%>/member/updatePassword?memberId=<%=memberId_%> ";
	var title = "updatePassword";
	var status = "left=500px, top=200px, width=400px, height=210px";
	
	open(url, title, status);
}
</script>

<!-- <form name="memberDeleteFrm">
	<input type="hidden" name="memberId" />
</form> -->


<section id="enroll-container">
        <h2>회원 정보 보기</h2>
        <form action="<%=request.getContextPath()%>/member/memberUpdateEnd"
              method="post"
              name="memberUpdateFrm"
              onsubmit="return updateValidate();">
                <table>
                    <tr>
                        <th>아이디</th>
                        <td><input type="text"
                                   name="memberId"
                                   id="memberId_"
                                   value="<%=memberId_%>"
                                   required
                                   readonly />
                        </td>
                    </tr>
                        <%-- <tr>
                        <th>패스워드</th>
                        <td><input type= "password"
                                   name="password"
                                   id="password_"
                                   value="<%=password %>"
                                   required /></td>
                    </tr>
                        <tr>
                        <th>패스워드 확인</th>
                        <td><input type="password"
                                   id="password__"
                                   value="<%=password %>"
                                   required /></td>
                    </tr> --%>
                        <tr>
                        <th>이름</th>
                        <td><input type="text"
                                   name="memberName"
                                   id="memberName"
                                   value="<%=memberName %>"
                                   required /></td>
                    </tr>
                        <tr>
                        <th>나이</th>
                        <td><input type="number"
                                   name="age"
                                   id="age"
                                   value="<%=age %>"
                                   /></td>
                    </tr>
                        <tr>
                        <th>이메일</th>
                        <td><input type="email"
                                   name="email"
                                   id="email"
                                   value="<%=email %>"
                                   placeholder="abc@xyz.com"
                                   /></td>
                    </tr>
                        <tr>
                        <th>휴대폰</th>
                        <td><input type="tel"
                                   name="phone"
                                   id="phone"
                                   value="<%=phone %>"
                                   placeholder="(-없이)01012345678"
                                   required /></td>
                    </tr>
                        <tr>
                        <th>주소</th>
                        <td><input type="text"
                                   name="address"
                                   id="address"
                                   value="<%=address %>"
                                   required /></td>
                    </tr>
                        <tr>
                        <th>성별</th>
                        <td>
                            <input type="radio"
                                   name="gender"
                                   id="gender0"
                                   required 
                                   value="M" 
                                   <%="M".equals(gender)?"checked":"" %>/>
                            <label for="gender0">남</label>
                            <input type="radio" 
                            	   name="gender"
                            	   id="gender1"
                            	   required
                            	   value="F"
                            	   <%="F".equals(gender)?"checked":"" %> />
                           	<label for="gender1">여</label>
                        <%-- <%if("M".equals(gender)){ %>
                        	<input type="radio"
                                   name="gender"
                                   id="gender0"
                                   required 
                                   value="M" checked/>
                            <label for="gender0">남</label>
                            <input type="radio" 
                            	   name="gender"
                            	   id="gender1"
                            	   required
                            	   value="M" checked/>
                           	<label for="gender1">여</label>
                           	<%} else { %>
                        	<input type="radio"
                                   name="gender"
                                   id="gender0"
                                   required 
                                   value="M" checked/>
                            <label for="gender0">남</label>
                            <input type="radio" 
                            	   name="gender"
                            	   id="gender1"
                            	   required
                            	   value="F" checked/>
                           	<label for="gender1">여</label>
                           	<%} %> --%>
                        </td>
                    </tr>
                    <tr>
                    	<th>취미</th>
                    	<td>
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby0"
                    			   value="운동" 
                    			   <%=hobbyChecked[0]!=null?hobbyChecked[0]:"" %>/>
                    		<label for="hobby0">운동</label>
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby1"
                    			   value="등산" 
                    			   <%=hobbyChecked[1]!=null?hobbyChecked[1]:"" %>/>
                    		<label for="hobby1">등산</label>
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby2"
                    			   value="독서" 
                    			   <%=hobbyChecked[2]!=null?hobbyChecked[2]:"" %>/>
                    		<label for="hobby2">독서</label>
                    		<br />
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby3"
                    			   value="게임" 
                    			   <%=hobbyChecked[3]!=null?hobbyChecked[3]:"" %>/>
                    		<label for="hobby3">게임</label>
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby4"
                    			   value="여행" 
                    			   <%=hobbyChecked[4]!=null?hobbyChecked[4]:"" %>/>
                    		<label for="hobby4">여행</label>
                
                    	</td>
                    </tr>
                    
                </table>
                	<input type="submit" value="회원정보 수정" />
                	&nbsp;
                	<input type="button" value= "비밀번호 수정"
                		   onclick="updatePassword();" />
                	&nbsp;
                	<input type="button" value="탈퇴" onclick="deleteMember();" />
                </form>
    </section>

<%@ include file= "/WEB-INF/views/common/footer.jsp"%>