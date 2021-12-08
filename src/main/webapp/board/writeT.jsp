<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글쓰기 페이지 진입전 로그인 확인 -->
<%@ include file="IsLoggedIn.jsp" %>

<script type="text/javascript">
function validateForm(form) {
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
            <h3>게시글 작성 - <small>자유게시판</small></h3>
            
            <form  name="writeFrm" method="post" 
            	action="WriteProcess.jsp" onsubmit="return validateForm(this);">
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
                            <input type="text" class="form-control" name="title" />
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td>
                            <textarea rows="5" class="form-control" name="content" ></textarea>
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
                        <%-- <button type="button" class="btn btn-primary">글쓰기</button>
		                <button type="button" class="btn btn-secondary"
		                		onclick="location.href='Edit.jsp?num=<%= dto.getNum() %>';">
		                	수정하기</button> --%>
                        <button type="reset" class="btn btn-dark">다시쓰기</button>
		                <!-- <button type="button" class="btn btn-success"
		                	onclick="deletePost();">삭제하기</button>  
                        <button type="button" class="btn btn-info">답글쓰기</button> -->
                        <button type="button" class="btn btn-warning" 
                        	onclick="location.href='listT.jsp';">목록보기</button>
                        <button type="submit" class="btn btn-danger">전송하기</button>
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