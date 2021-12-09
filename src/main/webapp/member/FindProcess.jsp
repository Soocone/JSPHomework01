<%@page import="utils.JSFunction"%>
<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//아이디/비밀번호 찾기 폼에서 사용자가 입력한 이름, 아이디 받기
String userName = request.getParameter("name");
String userId = request.getParameter("id");

//application 내장객체를 통해 web.xml에 저장된 오라클 접속정보를 읽어옴
String oracleDriver = application.getInitParameter("OracleDriver");
String OracleURL = application.getInitParameter("OracleURL");
String OracleId = application.getInitParameter("OracleId");
String OraclePwd = application.getInitParameter("OraclePwd");

//JDBC를 통해 오라클 접속 (튜브 하나 만듦)
MemberDAO dao = new MemberDAO(oracleDriver, OracleURL, OracleId, OraclePwd);
//받아온 이름, 아이디를 매개변수로 getMemberDTO()호출. 회원찾기 시도함.
//아이디, 비밀번호 찾기
MemberDTO findMemDTO = dao.findMemDTO(userName, userId);

//자원 해제
dao.close(); //튜브 터뜨림!!


if(findMemDTO.getId() !=null){
	//회원 정보 중에 이름이 있는 경우
	JSFunction.alertLocation("회원님의 아이디는 "+findMemDTO.getId()+"입니다.",
			"./Login.jsp", out);
}
else if(findMemDTO.getPass() !=null){
	//회원 정보 중에 이름/ 아이디가 있는 경우
	JSFunction.alertLocation("회원님의 비밀번호는 "+findMemDTO.getPass()+"입니다.",
			"./Login.jsp", out);
}
else{
	//인증에 실패한 경우
	JSFunction.alertBack("아이디/ 비밀번호 찾기에 실패하였습니다.", out);
}

%>