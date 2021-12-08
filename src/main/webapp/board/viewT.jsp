<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//게시물의 일련번호를 파라미터를 통해 받는다.
String num = request.getParameter("num");
//DB연결
BoardDAO dao = new BoardDAO(application);
//조회수 증가
dao.updateVisitCount(num);
//일련번호에 해당하는 게시물 조회
BoardDTO dto = dao.selectView(num);
//자원 해제
dao.close();
%>

<script>
 function deletePost(){
	 var confirmed = confirm("정말로 삭제하시겠습니까?");
	 if(confirmed){
		 var form = document.writeFrm;
		 form.method = "post";	//전송방식을 post로 설정
		 form.action = "DeleteProcess.jsp";	//전송할 URL
		 form.submit();	//폼값 전송
	 }
 }

</script>

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
            <h3>게시판 내용보기 - <small>자유게시판</small></h3>
            
            <form name="writeFrm">
            <!-- 게시물의 일련번호: 삭제시 사용할 예정임 -->
			<input type="hidden" name="num" value="<%= num %>"/>
                <table class="table table-bordered">
                <colgroup>
                    <col width="20%"/>
                    <col width="30%"/>
                    <col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성자</th>
                        <td>
                            <%= dto.getName() %>
                        </td>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성일</th>
                        <td>
                            <%= dto.getPostdate() %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">조회수</th>
                        <td colspan="3">
                            <%= dto.getVisitcount() %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">제목</th>
                        <td colspan="3">
                            <%= dto.getTitle() %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td colspan="3">
                            <!-- 엔터키로 처리된 부분을 <br>태그로 변경해야 줄바꿈되어 출력된다. -->
            				<%= dto.getContent().replace("\r\n", "<br/>") %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">첨부파일</th>
                        <td colspan="3">
                            파일명.jpg
                        </td>
                    </tr>
                </tbody>
                </table>

                <!-- 각종버튼 -->
                <div class="row mb-3">
                    <div class="col d-flex justify-content-end">
                        <button type="button" class="btn btn-primary" 
                    	onclick="location.href='writeT.jsp';">글쓰기</button>
                    <%
		            /*
		            	로그인 되었고, 세션영역에 저장된 아이디가 해당 게시물을 작성한 아이디와
		            	일치한다면 수정, 삭제 버튼을 보이게 처리한다.
		            	즉, 작성자 본인이 해당 게시물을 조회했을때 버튼이 보인다.
		            */
		            if(session.getAttribute("UserId") != null
		            	&& session.getAttribute("UserId").toString().equals(dto.getId())){
		            %>       
		                <button type="button" class="btn btn-secondary"
		                		onclick="location.href='Edit.jsp?num=<%= dto.getNum() %>';">
		                	수정하기</button>
                        <!-- <button type="reset" class="btn btn-dark">다시쓰기</button> -->
		                <button type="button" class="btn btn-success"
		                	onclick="deletePost();">삭제하기</button>  
		            <%
		            }
		            %>    
                        <!-- <button type="button" class="btn btn-info">답글쓰기</button> -->
                        <button type="button" class="btn btn-warning" 
                        	onclick="location.href='listT.jsp';">목록보기</button>
                        <!-- <button type="button" class="btn btn-danger">전송하기</button> -->
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