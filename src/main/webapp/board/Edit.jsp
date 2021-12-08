<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 수정하기 페이지 진입전 로그인 확인 -->
<%@ include file="./IsLoggedIn.jsp" %>
<%
String num = request.getParameter("num"); //게시물의 일련번호
BoardDAO dao = new BoardDAO(application); //DB연결
BoardDTO dto = dao.selectView(num);		  //게시물 조회
//세션영역에 저장된 회원아이디를 얻어와서 문자열의 형태로 변환
String sessionId = session.getAttribute("UserId").toString();
/*
본인이 작성한 글이 아니어도 URL 패턴을 분석하면 수정페이지로 진입할 수
있으므로 페이지 진입 전 본인확인을 추가로 하는 것이 안전하다.
*/
if(!sessionId.equals(dto.getId())){
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
	return;
}
dao.close(); //DB연결해제
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<script type="text/javascript">
function validateForm(form) { //폼 내용 검증
	if(form.title.value ==""){
		alert("제목을 입력하세요.");
		form.title.focus();
		return false;
	}
	if(form.content.value ==""){
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
</script>
</head>

<%@ include file="./commons/header.jsp" %>
<body>
<div class="container">
    <!-- Top영역 -->
    <%@ include file="./commons/top.jsp" %>
    <!-- Body영역 -->
    <div class="row">
        <!-- Left메뉴영역 -->
         <%@ include file= "./commons/left.jsp" %>
        <!-- Contents영역 -->
        <div class="col-9 pt-3">
            <h3>게시글 수정 - <small>자유게시판</small></h3>
            
            <form name="writeFrm" method="post" action="EditProcess.jsp"
				onsubmit="return validateForm(this);">
			<!--(중요)게시물의 일련번호를 서버로 전송하기 위해 hidden 타입의 입력상자가 필요하다. -->
			<input type="hidden" name="num" value="<%=dto.getNum() %>" />
                <table class="table table-bordered">
                <colgroup>
                    <col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <!-- <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성자</th>
                        <td>
                            <input type="text" class="form-control"  name="name"
                                style="width:100px;" />
                        </td>
                    </tr> -->
                    <!-- <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">패스워드</th>
                        <td>
                            <input type="text" class="form-control" 
                                style="width:200px;" />
                        </td>
                    </tr> -->
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">제목</th>
                        <td>
                            <input type="text" class="form-control" name="title" 
                            	value="<%= dto.getTitle()%>"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td>
                            <textarea rows="5" class="form-control" name="content" ><%=dto.getContent() %></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">첨부파일</th>
                        <td>
                            <input type="file" class="form-control" />
                        </td>
                    </tr>
                </tbody>
                </table>

                <!-- 각종버튼 -->
                <div class="row mb-3">
                    <div class="col d-flex justify-content-end">
                        <%-- <button type="button" class="btn btn-primary">글쓰기</button>--%>
		                <button type="submit" class="btn btn-secondary">수정완료</button>
                        <button type="reset" class="btn btn-dark">다시쓰기</button>
		                <!-- <button type="button" class="btn btn-success"
		                	onclick="deletePost();">삭제하기</button>  
                        <button type="button" class="btn btn-info">답글쓰기</button> -->
                        <button type="button" class="btn btn-warning" 
                        	onclick="location.href='listT.jsp';">목록보기</button>
                        <!-- <button type="submit" class="btn btn-danger">전송하기</button> -->
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- Copyright영역 -->
    <%@ include file= "./commons/copyright.jsp" %>
</div>
</body>
</html>