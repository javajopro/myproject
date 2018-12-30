/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.35
 * Generated at: 2018-12-20 11:29:54 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.member;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.kh.member.model.vo.*;

public final class memberEnroll_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/WEB-INF/views/common/header.jsp", Long.valueOf(1545213651548L));
    _jspx_dependants.put("/WEB-INF/views/common/footer.jsp", Long.valueOf(1544431610007L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("com.kh.member.model.vo");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("   \r\n");

	Member memberLoggedIn = (Member)session.getAttribute("logm");

	//전송된 쿠키확인
	boolean saveId = false;
	String memberId = "";
	
	Cookie[] cookies = request.getCookies();
	//System.out.println("브라우져가 전송한 쿠키 목록@header.jsp");
	//System.out.println("-------------------------------");
	for(Cookie c : cookies){
		String key = c.getName();
		String value = c.getValue();
		
		//System.out.printf("%s = %s\n", key, value);
		if("saveId".equals(key)){
			saveId = true;
			memberId = value; //abcde
			
		}
	}
	//System.out.println("-------------------------------");

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>Hello MVC</title>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.print(request.getContextPath() );
      out.write("/css/style.css\" />\r\n");
      out.write("<script src=\"");
      out.print(request.getContextPath() );
      out.write("/js/jquery-3.3.1.js\"></script>\r\n");
      out.write("<script>\r\n");
      out.write("function loginValidate(){\r\n");
      out.write("    if($(\"#memberId\").val().trim().length==0){\r\n");
      out.write("        alert(\"아이디를 입력하세요.\");\r\n");
      out.write("        $(\"#memberId\").focus();\r\n");
      out.write("        return false;//폼 전송방지\r\n");
      out.write("    }\r\n");
      out.write("    if($(\"#password\").val().trim().length==0){\r\n");
      out.write("        alert(\"비밀번호를 입력하세요.\");\r\n");
      out.write("        $(\"#password\").focus();\r\n");
      out.write("        return false;\r\n");
      out.write("    }\r\n");
      out.write("    return true;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("    <div id=\"container\">\r\n");
      out.write("        <header>\r\n");
      out.write("            <h1>Hello MVC</h1>\r\n");
      out.write("            <!--로그인 시작  -->\r\n");
      out.write("            <div class=\"login-container\">\r\n");
      out.write("            ");
if(memberLoggedIn == null) {
      out.write("\r\n");
      out.write("                <form action=\"");
      out.print(request.getContextPath() );
      out.write("/member/login\"\r\n");
      out.write("                method=\"post\"\r\n");
      out.write("                id=\"loginFrm\"\r\n");
      out.write("                onsubmit=\"return loginValidate();\">\r\n");
      out.write("                <table>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td>\r\n");
      out.write("                        <input type=\"text\" \r\n");
      out.write("                        \t   name=\"memberId\" \r\n");
      out.write("                        \t   id=\"memberId\" \r\n");
      out.write("                        \t   value = \"");
      out.print(memberId);
      out.write("\"\r\n");
      out.write("                        \t   placeholder=\"아이디\"/></td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td>\r\n");
      out.write("                        <input type=\"password\" name=\"password\" id=\"password\" placeholder=\"비밀번호\"/></td>\r\n");
      out.write("                        <td><input type=\"submit\" value=\"로그인\"/></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td colspan=\"2\">\r\n");
      out.write("                        \t<input type=\"checkbox\" \r\n");
      out.write("                        \t       name=\"saveId\" \r\n");
      out.write("                        \t\t   id=\"saveId\"\r\n");
      out.write("                        \t\t   ");
      out.print(saveId?"checked" : "");
      out.write(">\r\n");
      out.write("                        <label for=\"saveId\">\r\n");
      out.write("                        \t아이디저장\r\n");
      out.write("                        </label>\r\n");
      out.write("                        &nbsp;&nbsp;\r\n");
      out.write("                        <input type=\"button\" \r\n");
      out.write("                        \t   value=\"회원가입\"\r\n");
      out.write("                        \t   onclick=\"location.href='");
      out.print(request.getContextPath() );
      out.write("/member/memberEnroll'\" />\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                </table>\r\n");
      out.write("                </form>\r\n");
      out.write("            ");
 }
            else {
      out.write("\r\n");
      out.write("            \t<table id=\"logged-in\">\r\n");
      out.write("            \t\t<tr>\r\n");
      out.write("            \t\t\t<td>\r\n");
      out.write("            \t\t\t\t");
      out.print(memberLoggedIn.getMemberName() );
      out.write("님,\r\n");
      out.write("            \t\t\t\t안녕하세요 :)\r\n");
      out.write("            \t\t\t</td>\r\n");
      out.write("            \t\t</tr>\r\n");
      out.write("            \t\t<tr>\r\n");
      out.write("            \t\t\t<td>\r\n");
      out.write("            \t\t\t\t<input type=\"button\" \r\n");
      out.write("            \t\t\t\t\t   value=\"내정보보기\" \r\n");
      out.write("            \t\t\t\t\t   onclick='location.href = \"");
      out.print(request.getContextPath() );
      out.write("/member/memberView?memberId=");
      out.print(memberLoggedIn.getMemberId());
      out.write("\"' />\r\n");
      out.write("            \t\t\t\t&nbsp;\r\n");
      out.write("            \t\t\t\t<input type=\"button\" \r\n");
      out.write("            \t\t\t\t\t   value=\"로그아웃\" \r\n");
      out.write("            \t\t\t\t\t   onclick=\"location.href='");
      out.print(request.getContextPath());
      out.write("/member/logout'\"/>\r\n");
      out.write("            \t\t\t</td>\r\n");
      out.write("            \t\t</tr>\r\n");
      out.write("            \t</table>\r\n");
      out.write("            \t\r\n");
      out.write("            \t\r\n");
      out.write("            \t\r\n");
      out.write("            ");
 } 
      out.write("\r\n");
      out.write("            </div>\r\n");
      out.write("            <!-- 로그인 끝 -->\r\n");
      out.write("            <!-- 메인메뉴 시작  -->\r\n");
      out.write("            <nav>\r\n");
      out.write("                <ul class=\"main-nav\">\r\n");
      out.write("                    <li><a href=\"#\">Home</a></li>\r\n");
      out.write("                    <li><a href=\"#\">공지사항</a></li>\r\n");
      out.write("                    <li><a href=\"");
      out.print(request.getContextPath() );
      out.write("/board/boardList\">게시판</a></li>\r\n");
      out.write("                    \r\n");
      out.write("                   \t<!--  관리자인 경우만 보이기 -->\r\n");
      out.write("                   \t");
 if(memberLoggedIn != null && "admin".equals(memberLoggedIn.getMemberId())) {
      out.write("\r\n");
      out.write("                    <li><a href=\"");
      out.print(request.getContextPath());
      out.write("/admin/memberList\">회원관리</a></li>\r\n");
      out.write("                    ");
} 
      out.write("\r\n");
      out.write("                </ul>\r\n");
      out.write("            </nav>\r\n");
      out.write("            <!-- 메인메뉴 끝 -->\r\n");
      out.write("        </header>\r\n");
      out.write("        \r\n");
      out.write("        <section id=\"content\">\r\n");
      out.write("        \r\n");
      out.write("        \r\n");
      out.write("        \r\n");
      out.write("        \r\n");
      out.write("        \r\n");
      out.write("        \r\n");
      out.write("        \r\n");
      out.write("        ");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("\tfunction enrollValidate(){\r\n");
      out.write("\t\t   var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식\r\n");
      out.write("\t\t   var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;\r\n");
      out.write("\t\t   // 이메일이 적합한지 검사할 정규식\r\n");
      out.write("\r\n");
      out.write("\t\t   var id = document.getElementById(\"memberId_\");\r\n");
      out.write("\t\t   var pw = document.getElementById(\"password_\");\r\n");
      out.write("\t\t   var email = document.getElementById(\"email_\");\r\n");
      out.write("\t\t   var num1 = document.getElementById(\"phone\");\r\n");
      out.write("\r\n");
      out.write("\t\t   // ------------ 이메일 까지 -----------\r\n");
      out.write("\r\n");
      out.write("\t\t   if(!check(re,id,\"아이디는 4~12자의 영문 대소문자와 숫자로만 입력\")) {\r\n");
      out.write("\t\t       return false;\r\n");
      out.write("\t\t   }\r\n");
      out.write("\r\n");
      out.write("\t\t   if(!check(re,pw,\"패스워드는 4~12자의 영문 대소문자와 숫자로만 입력\")) {\r\n");
      out.write("\t\t       return false;\r\n");
      out.write("\t\t   }\r\n");
      out.write("\r\n");
      out.write("\t\t   if(email.value==\"\") {\r\n");
      out.write("\t\t       alert(\"이메일을 입력해 주세요\");\r\n");
      out.write("\t\t       email.focus();\r\n");
      out.write("\t\t       return false;\r\n");
      out.write("\t\t   }\r\n");
      out.write("\r\n");
      out.write("\t\t   if(!check(re2, email, \"적합하지 않은 이메일 형식입니다.\")) {\r\n");
      out.write("\t\t       return false;\r\n");
      out.write("\t\t   }\r\n");
      out.write("\r\n");
      out.write("\t\t       if(join.name.value==\"\") {\r\n");
      out.write("\t\t           alert(\"이름을 입력해 주세요\");\r\n");
      out.write("\t\t           join.name.focus();\r\n");
      out.write("\t\t           return false;\r\n");
      out.write("\t\t       }\r\n");
      out.write("\r\n");
      out.write("\t\t  \r\n");
      out.write("\r\n");
      out.write("\t\t       \r\n");
      out.write("\r\n");
      out.write("\t\t       if(join.inter[0].checked==false &&\r\n");
      out.write("\t\t           join.inter[1].checked==false &&\r\n");
      out.write("\t\t           join.inter[2].checked==false &&\r\n");
      out.write("\t\t           join.inter[3].checked==false &&\r\n");
      out.write("\t\t           join.inter[4].checked==false) {\r\n");
      out.write("\t\t           alert(\"관심분야를 골라주세요\");\r\n");
      out.write("\t\t           return false;\r\n");
      out.write("\t\t       }\r\n");
      out.write("\r\n");
      out.write("\t\t       if(join.self.value==\"\") {\r\n");
      out.write("\t\t           alert(\"자기소개를 적어주세요\");\r\n");
      out.write("\t\t           join.self.focus();\r\n");
      out.write("\t\t           return false;\r\n");
      out.write("\t\t       }\r\n");
      out.write("\t\t       \r\n");
      out.write("\t\t     //아이디중복검사여부 체크\r\n");
      out.write("\t\t       var idValid = $(\"#idValid\").val();\r\n");
      out.write("\t\t       if(idValid ==0){\r\n");
      out.write("\t\t           alert(\"아이디 중복검사해주세요.\")\r\n");
      out.write("\t\t           return false;\r\n");
      out.write("\t\t       }\r\n");
      out.write("\t\t       return true;\r\n");
      out.write("\t\t       \r\n");
      out.write("\t\t       alert(\"회원가입이 완료되었습니다.\");\r\n");
      out.write("}\r\n");
      out.write("\t function check(re, what, message) {\r\n");
      out.write("\t       if(re.test(what.value)) {\r\n");
      out.write("\t           return true;\r\n");
      out.write("\t       }\r\n");
      out.write("\t       alert(message);\r\n");
      out.write("\t       what.value = \"\";\r\n");
      out.write("\t       what.focus();\r\n");
      out.write("\t       //return false;\r\n");
      out.write("\t   }\r\n");
      out.write("\t\r\n");
      out.write("$(function(){\r\n");
      out.write("\t//패스워드 일치여부 검사 -> 이벤트핸들러 작성\r\n");
      out.write("\tvar password1 = document.getElementById(\"password_\");\r\n");
      out.write("    var password2 = document.getElementById(\"password__\");\r\n");
      out.write("\r\n");
      out.write("    password2.addEventListener(\"focus\", function(){\r\n");
      out.write("        console.log(\"#password__ focus\");\r\n");
      out.write("    });\r\n");
      out.write("    password2.addEventListener(\"blur\", function(){\r\n");
      out.write("        if(password1.value != password2.value){\r\n");
      out.write("            alert(\"비밀번호가 일치하지 않습니다.\");\r\n");
      out.write("            password1.select();\r\n");
      out.write("        }\r\n");
      out.write("    });\r\n");
      out.write("});\r\n");
      out.write("\r\n");
      out.write("function checkIduplicate(){\r\n");
      out.write("\t//아이디중복검사폼을 전송.\r\n");
      out.write("\tvar memberId = $(\"#memberId_\").val().trim();\r\n");
      out.write("\t\r\n");
      out.write("\tif(memberId.length < 4){\r\n");
      out.write("\t\t\r\n");
      out.write("\t\talert(\"아이디는 4글자 이상 가능합니다.\");\r\n");
      out.write("\t\treturn;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t//팝업창을 target으로 폼 전송\r\n");
      out.write("\tvar target = \"checkIdDuplicate\";\r\n");
      out.write("\t//첫번째 인자 url은 생략, form의 action값이 이를 대신한다.\r\n");
      out.write("\tvar popup = open(\"\", target, \"left=300px, top=100px, height=200px, width=300px\");\r\n");
      out.write("\t\r\n");
      out.write("\tcheckIdDuplicateFrm.memberId.value = memberId;\r\n");
      out.write("\t\r\n");
      out.write("\t//폼의 대상을 작성한 popup을 가리키게 한다. \r\n");
      out.write("\tcheckIdDuplicateFrm.target = target;\r\n");
      out.write("\tcheckIdDuplicateFrm.submit();\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("<form action=\"");
      out.print(request.getContextPath() );
      out.write("/member/checkIdDuplicate\"\r\n");
      out.write("\t  method=\"post\"\t\r\n");
      out.write("\t  name=\"checkIdDuplicateFrm\">\r\n");
      out.write("\t <input type=\"hidden\" name=\"memberId\" />\r\n");
      out.write("</form>\r\n");
      out.write("<section id=\"enroll-container\">\r\n");
      out.write("        <h2>회원가입 정보 입력</h2>\r\n");
      out.write("        <form action=\"");
      out.print(request.getContextPath());
      out.write("/member/memberEnrollEnd\"\r\n");
      out.write("              method=\"post\"\r\n");
      out.write("              name=\"memberEnrollFrm\"\r\n");
      out.write("              onsubmit=\"return enrollValidate();\">\r\n");
      out.write("                <table>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <th>아이디</th>\r\n");
      out.write("                        <td><input type=\"text\"\r\n");
      out.write("                                   name=\"memberId\"\r\n");
      out.write("                                   id=\"memberId_\"\r\n");
      out.write("                                   required />\r\n");
      out.write("                             <input type=\"button\" \r\n");
      out.write("                             \t\tvalue=\"중복검사\"\r\n");
      out.write("                             \t\tonclick= \"checkIduplicate();\"/>\r\n");
      out.write("                             <input type=\"hidden\" \r\n");
      out.write("                             \t\tname=\"idValid\" \r\n");
      out.write("                             \t\tid=\"idValid\"\r\n");
      out.write("                             \t\tvalue=\"0\" />\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                        <th>패스워드</th>\r\n");
      out.write("                        <td><input type= \"password\"\r\n");
      out.write("                                   name=\"password\"\r\n");
      out.write("                                   id=\"password_\"\r\n");
      out.write("                                   required /></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                        <th>패스워드 확인</th>\r\n");
      out.write("                        <td><input type=\"password\"\r\n");
      out.write("                                   id=\"password__\"\r\n");
      out.write("                                   required /></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                        <th>이름</th>\r\n");
      out.write("                        <td><input type=\"text\"\r\n");
      out.write("                                   name=\"memberName\"\r\n");
      out.write("                                   id=\"memberName\"\r\n");
      out.write("                                   required /></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                        <th>나이</th>\r\n");
      out.write("                        <td><input type=\"number\"\r\n");
      out.write("                                   name=\"age\"\r\n");
      out.write("                                   id=\"age\"\r\n");
      out.write("                                   /></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                        <th>이메일</th>\r\n");
      out.write("                        <td><input type=\"email\"\r\n");
      out.write("                                   name=\"email\"\r\n");
      out.write("                                   id=\"email\"\r\n");
      out.write("                                   placeholder=\"abc@xyz.com\"\r\n");
      out.write("                                   /></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                        <th>휴대폰</th>\r\n");
      out.write("                        <td><input type=\"tel\"\r\n");
      out.write("                                   name=\"phone\"\r\n");
      out.write("                                   id=\"phone\"\r\n");
      out.write("                                   placeholder=\"(-없이)01012345678\"\r\n");
      out.write("                                   required /></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                        <th>주소</th>\r\n");
      out.write("                        <td><input type=\"text\"\r\n");
      out.write("                                   name=\"address\"\r\n");
      out.write("                                   id=\"address\"\r\n");
      out.write("                                   required /></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                        <th>성별</th>\r\n");
      out.write("                        <td><input type=\"radio\"\r\n");
      out.write("                                   name=\"gender\"\r\n");
      out.write("                                   id=\"gender0\"\r\n");
      out.write("                                   required \r\n");
      out.write("                                   value=\"M\" checked/>\r\n");
      out.write("                            <label for=\"gender0\">남</label>\r\n");
      out.write("                            <input type=\"radio\" \r\n");
      out.write("                            \t   name=\"gender\"\r\n");
      out.write("                            \t   id=\"gender1\"\r\n");
      out.write("                            \t   required\r\n");
      out.write("                            \t   value=\"F\"/>\r\n");
      out.write("                           \t<label for=\"gender1\">여</label>\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                    \t<th>취미</th>\r\n");
      out.write("                    \t<td>\r\n");
      out.write("                    \t\t<input type=\"checkbox\"\r\n");
      out.write("                    \t\t\t   name=\"hobby\"\r\n");
      out.write("                    \t\t\t   id=\"hobby0\"\r\n");
      out.write("                    \t\t\t   value=\"운동\" />\r\n");
      out.write("                    \t\t<label for=\"hobby0\">운동</label>\r\n");
      out.write("                    \t\t<input type=\"checkbox\"\r\n");
      out.write("                    \t\t\t   name=\"hobby\"\r\n");
      out.write("                    \t\t\t   id=\"hobby1\"\r\n");
      out.write("                    \t\t\t   value=\"등산\" />\r\n");
      out.write("                    \t\t<label for=\"hobby1\">등산</label>\r\n");
      out.write("                    \t\t<input type=\"checkbox\"\r\n");
      out.write("                    \t\t\t   name=\"hobby\"\r\n");
      out.write("                    \t\t\t   id=\"hobby2\"\r\n");
      out.write("                    \t\t\t   value=\"독서\" />\r\n");
      out.write("                    \t\t<label for=\"hobby2\">독서</label>\r\n");
      out.write("                    \t\t<br />\r\n");
      out.write("                    \t\t<input type=\"checkbox\"\r\n");
      out.write("                    \t\t\t   name=\"hobby\"\r\n");
      out.write("                    \t\t\t   id=\"hobby3\"\r\n");
      out.write("                    \t\t\t   value=\"게임\" />\r\n");
      out.write("                    \t\t<label for=\"hobby3\">게임</label>\r\n");
      out.write("                    \t\t<input type=\"checkbox\"\r\n");
      out.write("                    \t\t\t   name=\"hobby\"\r\n");
      out.write("                    \t\t\t   id=\"hobby4\"\r\n");
      out.write("                    \t\t\t   value=\"여행\" />\r\n");
      out.write("                    \t\t<label for=\"hobby4\">여행</label>\r\n");
      out.write("                \r\n");
      out.write("                    \t</td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    \r\n");
      out.write("                </table>\r\n");
      out.write("                \t<input type=\"submit\" value=\"회원가입\" />\r\n");
      out.write("                \t&nbsp;&nbsp;\r\n");
      out.write("                \t<input type=\"reset\" value= \"초기화\"/>\r\n");
      out.write("                </form>\r\n");
      out.write("    </section>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</section>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<footer>\r\n");
      out.write("\t\t\t<p>&lt;Copyright 2017. <strong>KH정보교육원</strong>. All rights reserved.&gt;</p>\r\n");
      out.write("\t\t</footer>\r\n");
      out.write("\t</div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}