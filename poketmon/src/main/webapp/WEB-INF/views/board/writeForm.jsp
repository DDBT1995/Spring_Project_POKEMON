<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</style>

<script type="text/javascript">
$(document).ready(function() {
    
   $("#boardTitle").focus();
   
   $("#btnWrite").on("click", function() {
		$("#btnWrite").prop("disabled", true);	//버튼비활성화
		
		if($.trim($("#boardTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#boardTitle").val("");
			$("#boardTitle").focus();
			
			$("#btnWrite").prop("disabled", false);	// 글쓰기 버튼 활성화
			return;
		}
		
		if($.trim($("#boardContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#boardContent").val("");
			$("#boardContent").focus();
			
			$("#btnWrite").prop("disabled",false);	// 글쓰기 버튼 활성화
			return;
		}
		
		var form = $("#writeForm")[0];
		var formData = new FormData(form); // 자바스크립트에서 폼 데이터를 다루는 객체
		
		$.ajax({
			type:"POST",
			enctype:"multipart/form-data", // 인코딩 타입을 지정 파일,이미지 넘길때 사용
			url:"/board/writeProc",
			data:formData,
			processData:false, 		// formData를 string으로 변환하지 않음.
			contentType:false,		// content-type 헤더가 multipart/form-data로 전송.
			cache:false,
			timeout:600000,
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX","true");	
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					alert("게시물이 등록되었습니다.");
					location.href = "/board/boardList";
					
					/*
					document.bbsForm.action = "/board/list";
					document.bbsForm.submit();
					*/
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#btnWrite").prop("disabled", false);
					$("#hiBbsTitle").focus();
				}
				else
				{
					alert("게시물 등록 중 오류가 발생하였습니다.2");
					$("#btnWrite").prop("disabled", false);
					$("#hiBbsTitle").focus();
				}
			},
			error:function(error)
			{
				icia.common.error(error);
				alert("게시물 등록 중 오류가 발생하였습니다.");
				$("#btnWrite").prop("disabled",false);
			
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
    <h2>글쓰기</h2>
    <hr>
    <form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
        <div class="form-group1">
            <input type="text" id="userNickname" name="userNickname" value="${user.userNickname}" readonly>&nbsp;
            <input type="text" id="userEmail" name="userEmail" value="${user.userEmail}" readonly>
        </div>
        <div class="form-group">
            <label for="boardTitle">제목</label>
            <input type="text" id="boardTitle" name="boardTitle" required>
        </div>
        <div class="form-group">
            <label for="boardContent">내용</label>
            <textarea id="boardContent" name="boardContent" required></textarea>
        </div>
        <div class="form-group">
        <input type="file" id="boardFile" name="boardFile" placeholder="파일을 선택하세요." />
        </div>  
    </form>
    	<div class="button-group">
            <button type="button" id="btnWrite">작성</button>
            <button type="button" id="btnList">목록</button>
        </div>
</div>
<form name="boardForm" id="boardForm" method="POST">
   		<input type="hidden" name="searchType" value="${srarchType}"/>
   		<input type="hidden" name="searchValue" value="${searchValue}"/>
   		<input type="hidden" name="curPage" value="${curPage}"/>
</form>

</body>
</html>
