<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<script>
	function enrollValidate(){
		   var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
		   var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		   // 이메일이 적합한지 검사할 정규식

		   var id = document.getElementById("memberId_");
		   var pw = document.getElementById("password_");
		   var email = document.getElementById("email_");
		   var num1 = document.getElementById("phone");

		   // ------------ 이메일 까지 -----------

		   if(!check(re,id,"아이디는 4~12자의 영문 대소문자와 숫자로만 입력")) {
		       return false;
		   }

		   if(!check(re,pw,"패스워드는 4~12자의 영문 대소문자와 숫자로만 입력")) {
		       return false;
		   }

		   if(email.value=="") {
		       alert("이메일을 입력해 주세요");
		       email.focus();
		       return false;
		   }

		   if(!check(re2, email, "적합하지 않은 이메일 형식입니다.")) {
		       return false;
		   }

		       if(join.name.value=="") {
		           alert("이름을 입력해 주세요");
		           join.name.focus();
		           return false;
		       }

		  

		       

		       if(join.inter[0].checked==false &&
		           join.inter[1].checked==false &&
		           join.inter[2].checked==false &&
		           join.inter[3].checked==false &&
		           join.inter[4].checked==false) {
		           alert("관심분야를 골라주세요");
		           return false;
		       }

		       if(join.self.value=="") {
		           alert("자기소개를 적어주세요");
		           join.self.focus();
		           return false;
		       }
		       
		     //아이디중복검사여부 체크
		       var idValid = $("#idValid").val();
		       if(idValid ==0){
		           alert("아이디 중복검사해주세요.")
		           return false;
		       }
		       return true;
		       
		       alert("회원가입이 완료되었습니다.");
}
	 function check(re, what, message) {
	       if(re.test(what.value)) {
	           return true;
	       }
	       alert(message);
	       what.value = "";
	       what.focus();
	       //return false;
	   }
	
$(function(){
	//패스워드 일치여부 검사 -> 이벤트핸들러 작성
	var password1 = document.getElementById("password_");
    var password2 = document.getElementById("password__");

    password2.addEventListener("focus", function(){
        console.log("#password__ focus");
    });
    password2.addEventListener("blur", function(){
        if(password1.value != password2.value){
            alert("비밀번호가 일치하지 않습니다.");
            password1.select();
        }
    });
});

function checkIduplicate(){
	//아이디중복검사폼을 전송.
	var memberId = $("#memberId_").val().trim();
	
	if(memberId.length < 4){
		
		alert("아이디는 4글자 이상 가능합니다.");
		return;
	}
	
	//팝업창을 target으로 폼 전송
	var target = "checkIdDuplicate";
	//첫번째 인자 url은 생략, form의 action값이 이를 대신한다.
	var popup = open("", target, "left=300px, top=100px, height=200px, width=300px");
	
	checkIdDuplicateFrm.memberId.value = memberId;
	
	//폼의 대상을 작성한 popup을 가리키게 한다. 
	checkIdDuplicateFrm.target = target;
	checkIdDuplicateFrm.submit();
	
	
}
</script>
<form action="<%=request.getContextPath() %>/member/checkIdDuplicate"
	  method="post"	
	  name="checkIdDuplicateFrm">
	 <input type="hidden" name="memberId" />
</form>
<section id="enroll-container">
        <h2>회원가입 정보 입력</h2>
        <form action="<%=request.getContextPath()%>/member/memberEnrollEnd"
              method="post"
              name="memberEnrollFrm"
              onsubmit="return enrollValidate();">
                <table>
                    <tr>
                        <th>아이디</th>
                        <td><input type="text"
                                   name="memberId"
                                   id="memberId_"
                                   required />
                             <input type="button" 
                             		value="중복검사"
                             		onclick= "checkIduplicate();"/>
                             <input type="hidden" 
                             		name="idValid" 
                             		id="idValid"
                             		value="0" />
                        </td>
                    </tr>
                        <tr>
                        <th>패스워드</th>
                        <td><input type= "password"
                                   name="password"
                                   id="password_"
                                   required /></td>
                    </tr>
                        <tr>
                        <th>패스워드 확인</th>
                        <td><input type="password"
                                   id="password__"
                                   required /></td>
                    </tr>
                        <tr>
                        <th>이름</th>
                        <td><input type="text"
                                   name="memberName"
                                   id="memberName"
                                   required /></td>
                    </tr>
                        <tr>
                        <th>나이</th>
                        <td><input type="number"
                                   name="age"
                                   id="age"
                                   /></td>
                    </tr>
                        <tr>
                        <th>이메일</th>
                        <td><input type="email"
                                   name="email"
                                   id="email"
                                   placeholder="abc@xyz.com"
                                   /></td>
                    </tr>
                        <tr>
                        <th>휴대폰</th>
                        <td><input type="tel"
                                   name="phone"
                                   id="phone"
                                   placeholder="(-없이)01012345678"
                                   required /></td>
                    </tr>
                        <tr>
                        <th>주소</th>
                        <td><input type="text"
                                   name="address"
                                   id="address"
                                   required /></td>
                    </tr>
                        <tr>
                        <th>성별</th>
                        <td><input type="radio"
                                   name="gender"
                                   id="gender0"
                                   required 
                                   value="M" checked/>
                            <label for="gender0">남</label>
                            <input type="radio" 
                            	   name="gender"
                            	   id="gender1"
                            	   required
                            	   value="F"/>
                           	<label for="gender1">여</label>
                        </td>
                    </tr>
                    <tr>
                    	<th>취미</th>
                    	<td>
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby0"
                    			   value="운동" />
                    		<label for="hobby0">운동</label>
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby1"
                    			   value="등산" />
                    		<label for="hobby1">등산</label>
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby2"
                    			   value="독서" />
                    		<label for="hobby2">독서</label>
                    		<br />
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby3"
                    			   value="게임" />
                    		<label for="hobby3">게임</label>
                    		<input type="checkbox"
                    			   name="hobby"
                    			   id="hobby4"
                    			   value="여행" />
                    		<label for="hobby4">여행</label>
                
                    	</td>
                    </tr>
                    
                </table>
                	<input type="submit" value="회원가입" />
                	&nbsp;&nbsp;
                	<input type="reset" value= "초기화"/>
                </form>
    </section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>