<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
   // 개행문자 값을 저장한다.
   pageContext.setAttribute("newLine", "\n");
%>
<!DOCTYPE html>

<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<style>
/* 기본적인 레이아웃과 스타일 설정 */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.write-container {
    width: 1000px;
    background-color: #ffffff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    border-radius: 8px;
    margin-top: 250px;
}

h2 {
    text-align: left;
    color: #333;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    font-weight: bold;
    display: block;
    margin-bottom: 5px;
    color: #555;
}

.form-group input[type="text"],
.form-group textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 0px;
    box-sizing: border-box;
}

.form-group textarea {
    resize: vertical;
    height: 400px;
    resize: none;
}

.button-group {
    text-align: right;
}

.button-group button {
    background-color: #FED856;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 16px;
}

.button-group button:hover {
    background-color: #ffdb4d;
}

hr {
   height: 4px;
   border-color: #fff;
   background-color: #FED856;
   margin: 20px 0;
}

#btnList {
   background-color: #0080FF;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 16px;
}

.form-group1 #userNickname {
   margin-bottom: 15px;
    width: 230px;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 0px;
    box-sizing: border-box;
}

.form-group1 #userEmail {
   margin-bottom: 15px;
    width: 420px;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 0px;
    box-sizing: border-box;
}

.right-float1 {
  float: right;
}
</style>

<script type="text/javascript">
$(document).ready(function() {

	   $("#boardTitle").focus();
	   
	   $("#btnUpdate").on("click", function() {
	      $("#btnUpdate").prop("disabled", true);		// 버튼 비활성화
	      
	      if($.trim($("#boardTitle").val()).length <= 0)
	   	  {
	    	  alert("제목을 입력하세요.");
	    	  $("#boardTitle").val("");
	    	  $("#boardTitle").focus();
	    	  $("#btnUpdate").prop("disabled", false);		// 버튼 활성화
	    	  return;
	   	  }
	      
	      if($.trim($("#boardContent").val()).length <= 0)
	      {
	    	  alert("내용을 입력하세요.");
	    	  $("#boardContent").val("");
	    	  $("#boardContent").focus();
	    	  $("#btnUpdate").prop("disabled", false);	// 버튼 활성화
	    	  return;
	      }
	      
	      var form = $("#updateForm")[0];
	      var formData = new FormData(form);
	      
	      $.ajax({
	    	 type:"POST",
	    	 enctype:"multipart/form-data",
	    	 url:"/board/updateProc",
	    	 data:formData,
	    	 processData:false,
	    	 contentType:false,
	    	 cache:false,
	    	 beforeSend:function(xhr)
	    	 {
	    		 xhr.setRequestHeader("AJAX","true");
	    	 },
	    	 success:function(response)
	    	 {
	    		 if(response.code == 0)
	    		 {
	    			 alert("게시물이 수정되었습니다.");
	    			 location.href = "/board/boardList";
	    		 }
	    		 else if(response.code == 400)
	    		 {
	    			 alert("파라미터 값이 올바르지 않습니다.");
	    			 $("#btnUpdate").prop("disabled", false);		// 버튼 활성화
	    		 }
	    		 else if(response.code == 403)
	    		 {
	    			 alert("본인 게시물이 아닙니다.");
	    			 $("#btnUpdate").prop("disabled", false);		// 버튼 활성화
	    		 }
	    		 else if(response.code == 404)
	    		 {
	    			 alert("게시물을 찾을 수 없습니다.");
	    			 location.href = "/board/boardList";
	    		 }
	    		 else 
	    	     {
	    			 alert("게시물 수정 중 오류가 발생하였습니다.");
	    			 $("#btnUpdate").prop("disabled", false);		// 버튼 활성화
	    	     }
	    	 },
	    	 error:function(error)
	      	 {
	    		icia.common.error(error);
	    		alert("게시물 수정 중 오류가 발생하였습니다.");
	    		 $("#btnUpdate").prop("disabled", false);		// 버튼 비활성화
	      	 }
	      });
	    	 
	   });
	   
	   $("#btnList").on("click", function() {
			document.boardForm.action = "/board/boardList";
			document.boardForm.submit();
	   });


	});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="write-container">
    <h2>글 수정</h2>
    <hr>
    <form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
        <div class="form-group1">
            <input type="text" id="userNickname" name="userNickname" value="${board.userNickname}" readonly>&nbsp;
            <input type="text" id="userEmail" name="userEmail" value="${board.userEmail}" readonly>
        </div>
        <div class="form-group">
            <label for="boardTitle">제목</label>
            <input type="text" id="boardTitle" name="boardTitle" value="" >
        </div>
        <div class="form-group">
            <label for="boardContent">내용</label>
            <textarea id="boardContent" name="boardContent"></textarea>
        </div>
        <input type="file" id="boardFile" name="boardFile" placeholder="파일을 선택하세요." />
        <c:if test="${!empty board.boardFile}">
        <div style="margin-bottom:0.3em;">[첨부파일 : ${board.boardFile.fileOrgName}]</div>
		</c:if>
	  <input type="hidden" name="boardSeq" value="${board.boardSeq}" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
		 </form>
		
        <div class="button-group">
            <button type="button" id="btnList">목록</button>
            <button type="button" id="btnUpdate" class="btn btn-secondary">수정</button>
        </div>
   
</div>
<form name="boardForm" id="boardForm" method="POST">
		<input type="hidden" name="boardSeq" value="${board.boardSeq}"/>
   		<input type="hidden" name="searchType" value="${srarchType}"/>
   		<input type="hidden" name="searchValue" value="${searchValue}"/>
   		<input type="hidden" name="curPage" value="${curPage}"/>
</form>

</body>
</html>
