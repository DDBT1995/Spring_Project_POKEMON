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
    height: 100%;  /* 페이지가 전체 화면을 채우도록 설정 */
	margin: 0;     /* 기본 마진 제거 */
  	overflow-x: hidden;  /* 가로 스크롤 방지 */
}

.write-container {
    width: 1000px;
    background-color: #ffffff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    border-radius: 8px;
    
    margin-top: 100px;
    
    
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

/* 댓글 스타일 */
.comment-container {
    margin-top: 30px;
    padding: 20px;
    background-color: #ffffff;
    border-top: 1px solid #ddd;
}

.comment-form-group {
    margin-bottom: 15px;
}

.comment-form-group input[type="text"],
.comment-form-group textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
}

.comment-form-group button {
    background-color: #FED856;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 16px;
}

.comment-list {
    margin-top: 20px;
}

.comment {
    display: flex;
    align-items: flex-start;
    margin-bottom: 15px;
    padding: 10px;
    background-color: #f9f9f9;
    border-radius: 4px;
}

.comment .comment-header {
    font-weight: bold;
    color: #555;
}

.comment .comment-content {
    margin-top: 5px;
    color: #333;
}


.comment-image {
    width: 40px;
    height: 40px;
    border-radius: 50%; /* 동그란 이미지 */
    margin-right: 10px;
}

.comment-details {
    flex: 1;
}

.comment-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
    color: #555;
    margin-bottom: 5px;
}

.comment-header .nickname {
    color: #333;
}

.comment-header .comment-date {
    font-size: 0.9em;
    color: #999;
}

.comment-content {
    color: #333;
    margin-top: 5px;
}

/* 수정/삭제 버튼 스타일 */

.comment-action {
    display: flex;
    justify-content: flex-start; /* 버튼 우측 배치 */
    margin-top: 10px;
    border-top: 1px solid #ddd; /* 상단 경계선 */
}

.comment-action2 {
    justify-content: flex-end; /* 버튼 우측 배치 */
    margin-top: 10px;
    padding-top: 10px;
    margin-left: auto;
    
}

.com-com,
.com-update,
.com-delete {
    background-color: #FED856;
    color: #fff;
    border: none;
    padding: 8px 16px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;

}

.com-com:hover,
.com-update:hover,
.com-delete:hover {
    background-color: #ffdb4d;
}

.bottom-menu {
   display: inline-block;
   margin-left: 30px;
   display: flex;
   justify-content: center;
   margin-top: 10px;
}

.page-item.active .page-link {
   background-color: #FFD700 !important;
   border-color: #FFD700 !important;
   color: black !important;
   font-weight: 700 !important;
}

.page-link {
   color: black !important;
   font-weight: 700 !important;
}















/* 댓글 섹션의 스타일 */
.comment-section {
 max-width: 600px; /* 최대 너비 설정 */
  margin: 20px 0 20px 0; /* 위, 아래 마진만 설정하여 화면 왼쪽에 배치 */
  padding: 0px;
  box-sizing: border-box;
  text-align: left; /* 텍스트나 콘텐츠를 왼쪽 정렬 */
}

/* 댓글 추가 버튼 스타일 */
.comment-section__add-comment-btn {
 	background-color: #FED856;
    color: #fff;
    border: none;
    padding: 8px 16px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;
    margin-left: 10px; /* 버튼 간 간격 */
    margin: 0
}

/* 댓글 입력 폼 스타일 */
.comment-section__comment-form {
  display: flex;
  flex-direction: column;
}

.comment-section__textarea {
  width: 500px;
  padding: 12px;
  font-size: 14px;
  margin-top: 10px;
  margin-bottom: 15px;
  border: 1px solid #ddd;
  border-radius: 5px;
  resize: vertical;
  box-sizing: border-box;
  
   
}

.comment-section__submit-comment-btn {
   background-color: #FED856;
   color: #fff;
   border: none;
   padding: 8px 16px;
   border-radius: 20px;
   cursor: pointer;
   font-size: 14px;
   width: 60px;
  
   
}

/* 대댓글 스타일 */
.showButton {
  background-color: #FED856;
  color: #fff;
  border: none;
  padding: 8px 16px;
  border-radius: 20px;
  cursor: pointer;
  font-size: 14px;
}

.hiddenContent {
  background-color: #f1f1f1;
  padding: 20px;
  border-radius: 8px;
  margin-top: 10px;
}

 /* 좋아요 */  
/* 버튼 스타일 */
        .like-button {
            padding: 10px 20px;
            background-color: #e0e0e0;
            color: #333;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            transition: background-color 0.3s ease;
        }
        .like-button.liked {
            background-color: #ff6b6b;
            color: #fff;
        }
        /* 좋아요 카운트 스타일 */
        .like-count {
            margin-left: 10px;
            font-size: 16px;
            color: #333;
        }
        
     
#like{
     cursor: pointer;
      width: 30px;
      fill: #ddd;
}

#like.active{
      fill: red;
      cursor: pointer;
}

 /* 박스 스타일 */
    .like-container {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 10px;
        border: 2px solid #e0e0e0;
        border-radius: 0px;
        background-color: #f9f9f9;
        
        width: 90px;
    }  
    
    



/* 댓글 섹션의 스타일 */
.commentUp-section {
 max-width: 600px; /* 최대 너비 설정 */
  margin: 20px 0 20px 0; /* 위, 아래 마진만 설정하여 화면 왼쪽에 배치 */
  padding: 0px;
  box-sizing: border-box;
  text-align: left; /* 텍스트나 콘텐츠를 왼쪽 정렬 */
}

/* 댓글 추가 버튼 스타일 */
.commentUp-section__add-comment-btn {
 	background-color: #FED856;
    color: #fff;
    border: none;
    padding: 8px 16px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;
    margin-left: 10px; /* 버튼 간 간격 */
    margin: 0
}

/* 댓글 수정 입력 폼 스타일 */
.commentUp-section__comment-form {
  display: flex;
  flex-direction: column;
  
  
  
}

.commentUp-section__textarea {
  width: 200px;
  height: 300px;
  padding: 12px;
  font-size: 14px;
  margin-top: 10px;
  margin-bottom: 15px;
  border: 1px solid #ddd;
  border-radius: 5px;
  resize: vertical;
  box-sizing: border-box;
  margin-left: 10px;
  
   
}

.commentUp-section__submit-comment-btn {
   background-color: #FED856;
   color: #fff;
   border: none;
   padding: 8px 16px;
   border-radius: 20px;
   cursor: pointer;
   font-size: 14px;
   width: 60px;




</style>

<script type="text/javascript">



$(document).ready(function() {
	var commSeq = $(this).find("input[name='commSeq']").val();  // 해당 댓글의 commSeq 값 가져오기
	
	
    // 버튼 클릭 시 숨겨진 내용을 토글
    $(document).on('click', '.comment-show-button', function() {
        // 클릭한 버튼과 같은 부모 요소의 숨겨진 내용을 토글
        $(this).closest('.comment').find('.comment-hidden-content').toggle();
    });


   $("#btnList").on("click", function() {
		document.boardForm.action = "/board/boardList";
		document.boardForm.submit();
   });
   
   <c:if test="${boardMe eq 'Y'}">
   $("#btnUpdate").on("click", function() {
		document.boardForm.action = "/board/updateForm";
		document.boardForm.submit();
  });
   
   $("#btnDelete").on("click", function(){
	if(confirm("해당 게시물을 삭제 하시겠습니까?") == true)
	{
		$.ajax({
			type:"POST",
			url:"/board/delete",
			data:{
				boardSeq:<c:out value="${boardSeq}"/>
			},
			datatype:"JSON",
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					alert("게시물이 삭제 되었습니다.");
					location.href = "/board/boardList";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");	
				}
				else if(response.code == 403)
				{
					alert("본인 글이 아니므로 삭제 할 수 없습니다.");
				}
				else if(response.code == 404)
				{
					alert("해당 게시물을 찾을 수 없습니다.");
					location.href = "/board/boardList";
				}
				else
				{
					alert("게시물 삭제시 오류가 발생하였습니다.");
				}
					
			},
			error:function(xhr,status, error)
			{
				icia.common.error(error);
			}
		});
		}
  });
   </c:if>
   
  
   $("#btnComm").on("click", function(){
	
	   $.ajax({
	    	type:"POST",
	    	enctype:"multipart/form-data",
	    	url:"/board/commProc",
	    	data:{
	    		
	    		boardSeq:${boardSeq},
	    		commContent:$("#commContent").val()
	    		
	    	},
	 	    datatype:"JSON",
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response)
	    	{
	    		if(response.code == 0)
	    		{
	    			alert("댓글이 완료되었습니다.");
	    			document.boardForm.action = "/board/boardView";
    				document.boardForm.submit();    				
	    		}
	    		else if(response.code == 400)
	    		{
	    			alert("파라미터 값이 올바르지 않습니다.");
	    			$("#btnComm").prop("disabled", false);	    
	    		}
	    		else if(response.code == 404)
	    		{
	    			alert("해당 게시물을 찾을 수 없습니다.");
	    			location.href = "/board/boardList";
	    		}
	    		else
	    		{
	    			alert("게시물 댓글 중 오류가 발생하였습니다.");
	    			$("#btnComm").prop("disabled", false);	    
	    		}
	    		
	    	},
	    	error:function(error)
	    	{
	    		icia.common.error(error);
	    		alert("게시물 댓글 중 오류가 발생하였습니다.");
	    		$("#btnComm").prop("disabled", false);  // 답변 버튼 활성화
	    	}
	    });
   });
   
  
  
  
   		
   

	    // 댓글 추가 버튼 클릭 시
	    $(document).on('click', '#btnTwoComm', function() {
	        var commSeq = $(this).closest('.comment').find('input[name="commSeq"]').val();  // 해당 댓글의 commSeq 값 가져오기
	        var twoCommContent = $(this).closest('.comment').find('#twoCommContent').val();  // 대댓글 내용 가져오기
	        
	        // AJAX로 대댓글 추가
	        $.ajax({
	            type: "POST",
	            url: "/board/twoCommProc",
	            data: {
	                boardSeq: ${boardSeq},
	                commSeq: commSeq,
	                twoCommContent: twoCommContent
	            },
	            dataType: "JSON",
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader("AJAX", "true");
	            },
	            success: function(response) {
	                if (response.code == 0) {
	                    alert("(최신)대댓글 완료되었습니다.");
	                    location.reload(); // 대댓글이 추가되었으므로 페이지를 새로고침하거나 동적으로 추가
	                } else {
	                    alert("(최신)대댓글 추가에 실패했습니다.");
	                }
	            },
	            error: function(xhr, status, error) {
	                alert("대댓글 추가 중 오류가 발생했습니다.");
	            }
	        });
	    });

	    // 댓글 추가 버튼 클릭 시 댓글 작성 폼 토글
	    $(document).on('click', '#add-comment-btn', function() {
	        var commentForm = $(this).siblings('.comment-section__comment-form');
	        commentForm.toggle(); // 해당 댓글의 폼만 보이거나 숨겨짐
	    });

	    // 댓글 작성 버튼 클릭 시 댓글을 추가
	    $(document).on('click', '#submit-comment', function() {
	        var commentText = $(this).siblings('#comment-text').val().trim(); // 댓글 텍스트
	        if (commentText !== '') {
	            alert('댓글이 작성되었습니다: ' + commentText);

	           
	            // 댓글 입력 폼 초기화
	            $(this).siblings('#comment-text').val('');  // 텍스트박스 비우기
	            $(this).closest('.comment-section__comment-form').hide();  // 폼 숨기기
	        } else {
	            alert('댓글을 입력해주세요.');
	        }
	    });
	    
	    
	    

	    // 대댓글 버튼 클릭 시 해당 댓글에 대댓글 폼 보이기/숨기기
	    $(document).on('click', '.reply-btn', function() {
	        var replyForm = $(this).siblings('.reply-form'); // 해당 댓글의 대댓글 폼
	        replyForm.toggle(); // 대댓글 폼 보이기/숨기기
	    });

	    // 대댓글 작성 버튼 클릭 시 대댓글을 추가
	    $(document).on('click', '.submit-reply-btn', function() {
	        var replyText = $(this).siblings('.reply-text').val().trim(); // 대댓글 텍스트
	        if (replyText !== '') {
	            alert('대댓글이 작성되었습니다: ' + replyText);

	            // 대댓글 HTML을 생성
	            var newReplyHtml = `<li class="reply">${replyText}</li>`;

	            // 대댓글 입력 폼 초기화
	            $(this).siblings('.reply-text').val(''); // 대댓글 입력창 비우기
	            $(this).closest('.reply-form').hide(); // 대댓글 폼 숨기기
	        } else {
	            alert('대댓글을 입력해주세요.');
	        }
	    });
	
	// ready 바로 실행
	
	   $.ajax({
        	type:"POST",
        	url:"/board/likeCheckHeart",
        	data:{
        		
        		boardSeq:${boardSeq}    		
        	},
     	    datatype:"JSON",
    		beforeSend:function(xhr)
    		{
    			xhr.setRequestHeader("AJAX", "true");
    		},
    		
    		
    		
    		success:function(response)
        	{
        		if(response.code == 0)
        		{
        			alert("하트 레드 완료.");
        			$("#like").css('fill', '#e74c3c');  // 하트 색상 빨간색으로 변경
        		}
        		else if(response.code == 1)
        		{
        			alert("하트색 그레이 완료.");
        			$("#like").css('fill', 'black');  // 하트 색상 원래대로        			        		  
        		}
        		else if(response.code == 400)
        		{
        			alert("파라미터 값이 올바르지 않습니다.");
        				    
        		}
        		else if(response.code == 404)
        		{
        			alert("해당 게시물을 찾을 수 없습니다.");
        			
        		}
        		else if(response.code == 500)
        		{
        			alert("좋아요 DB 오류 입니다.");
        			
        		}
        		else
        		{
        			alert("좋아요 중 오류가 발생하였습니다.");
        			   
        		}
        		
        	},
        	error:function(error)
        	{
        		icia.common.error(error);
        		alert("게시물 좋아요 중 오류가 발생하였습니다.");
        		
        	}
        });
		
	
   

    // 좋아요 클릭 시
    $('#like').click(function() {
        $.ajax({
        	type:"POST",
        	url:"/board/likeCheckProc",
        	data:{
        		
        		boardSeq:${boardSeq}    		
        	},
     	    datatype:"JSON",
    		beforeSend:function(xhr)
    		{
    			xhr.setRequestHeader("AJAX", "true");
    		},
    		
    		
    		
    		success:function(response)
        	{
        		if(response.code == 0)
        		{
        			alert("좋아요 완료.");
        			$("#likeCount").text(response.data); 
        			$("#like").css('fill', '#e74c3c');  // 하트 색상 빨간색으로 변경
        		}
        		else if(response.code == 1)
        		{
        			alert("좋아요 취소 완료.");
        			$("#likeCount").text(response.data); 
        			$("#like").css('fill', 'black');  // 하트 색상 원래대로   
        				    
        		}
        		else if(response.code == 400)
        		{
        			alert("파라미터 값이 올바르지 않습니다.");
        				    
        		}
        		else if(response.code == 404)
        		{
        			alert("해당 게시물을 찾을 수 없습니다.");
        			
        		}
        		else if(response.code == 500)
        		{
        			alert("좋아요 DB 오류 입니다.");
        			
        		}
        		else
        		{
        			alert("좋아요 중 오류가 발생하였습니다.");
        			   
        		}
        		
        	},
        	error:function(error)
        	{
        		icia.common.error(error);
        		alert("게시물 좋아요 중 오류가 발생하였습니다.");
        		
        	}
        });

    });


    // 댓글 수정 버튼 클릭 시
    $('.com-update').on('click', function() {
        var commSeq = $(this).attr('id').split('-')[1]; // commSeq 추출 현재 누른 요소의 id - 를 스플릿해서 배열 2인덱스로 만든값
        var commentContent = $('#commentContent-' + commSeq).text(); // 댓글 내용 가져오기
        var $textarea = $('#commContentUp-' + commSeq);
        var $form = $('#commentUp-form-' + commSeq);

        // 댓글 내용 수정 폼에 채우기
        $textarea.val(commentContent);
        // 수정 폼 토글하기 (보이거나 숨기기)
        $form.toggle();  // 여기서 toggle 사용
    });

    // 댓글 삭제 버튼 클릭 시
    $('.com-delete').on('click', function() {
        var commSeq = $(this).attr('id').split('-')[1]; // commSeq 추출

        // 삭제 확인
        if (confirm('정말로 삭제하시겠습니까?')) {
            
        	$.ajax({
                type: "POST",
                url: "/board/commDelProc",
                data:{  
                	boardSeq:${boardSeq},  
                	commSeq: commSeq,                 
                },
                datatype:"JSON",  
                success:function(response)
    	    	{
    	    		if(response.code == 0)
    	    		{
    	    			alert("댓글 삭제 완료되었습니다.");
    	    			location.reload(); 
    	    							
    	    		}
    	    		else if(response.code == 500)
    	    		{
    	    			alert("success error.");
    	    			   
    	    		}
    	    		else if(response.code == 403)
    	    		{
    	    			alert("내 댓글 아닌거 같은데.");
    	    			   
    	    		}
    	    		else if(response.code == 400)
    	    		{
    	    			alert("파라미터 값이 올바르지 않습니다.");
    	    			   
    	    		}
    	    		else if(response.code == 404)
    	    		{
    	    			alert("해당 게시물을 찾을 수 없습니다.");
    	    			
    	    		}
    	    		else
    	    		{
    	    			alert("게시물 댓글 삭제 중 오류가 발생하였습니다.");
    	    			    
    	    		}
    	    		
    	    	},
    	    	error:function(error)
    	    	{
    	    		icia.common.error(error);
    	    		alert("게시물 댓글 삭제 중 오류가 발생하였습니다.");	    	
    	    	}
    	    });
        }
    });

    // 수정된 댓글 등록 버튼 클릭 시
    $('.commentUp-section__submit-comment-btn').on('click', function() {
        var commSeq = $(this).attr('id').split('-')[1]; // commSeq 추출
        var updatedContent = $('#commContentUp-' + commSeq).val(); // 수정된 댓글 내용 가져오기

        // 서버에 수정된 댓글 보내기 (Ajax 사용)
        $.ajax({
            type: "POST",
            url: "/board/commUpdateProc",
            data:{  
            	boardSeq:${boardSeq},  
            	commSeq: commSeq,
                upCommContent: updatedContent
            },
            datatype:"JSON",  
            success:function(response)
	    	{
	    		if(response.code == 0)
	    		{
	    			alert("댓글 수정이 완료되었습니다.");
	    			location.reload(); 
	    							
	    		}
	    		else if(response.code == 400)
	    		{
	    			alert("파라미터 값이 올바르지 않습니다.");
	    			   
	    		}
	    		else if(response.code == 404)
	    		{
	    			alert("해당 게시물을 찾을 수 없습니다.");
	    			
	    		}
	    		else
	    		{
	    			alert("게시물 댓글 중 오류가 발생하였습니다.");
	    			    
	    		}
	    		
	    	},
	    	error:function(error)
	    	{
	    		icia.common.error(error);
	    		alert("게시물 댓글  수정 중 오류가 발생하였습니다.");	    	
	    	}
	    });
    });
	     
	      
	   
	    	

	

  		      
  		      
  		      
// ready...
});

function fn_list(cmCurPage)
{
	document.boardForm.boardSeq.value = ${boardSeq};
	document.boardForm.cmCurPage.value = cmCurPage;
	document.boardForm.action = "/board/boardView";
	document.boardForm.submit();
}
	    			
	    		    
	    		    
	    		 
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="write-container">
    <h2>글 보기</h2>
    <hr>
    <form name="viewForm" id="viewForm" method="post" enctype="multipart/form-data">
        <div class="form-group1">
            <input type="text" id="userNickname" name="userNickname" value="${board.userNickname}" readonly>&nbsp;
            <input type="text" id="userEmail" name="userEmail" value="${board.userEmail}" readonly>
       <c:if test="${!empty board.boardFile}">     
                  &nbsp;&nbsp;&nbsp;<a href="/board/download?boardSeq=${board.boardFile.boardSeq}" style="color:#000;">[첨부파일]</a>
	   </c:if>  	
            
            <span scope="col"  class="right-float1">
                  <i class="fa-solid fa-eye"></i> <fmt:formatNumber type="number" maxFractionDigits="3" groupingUsed="true" value="${board.boardReadCnt}" /><br/>
                   
                  <c:choose>
				    <c:when test="${!empty board.boardModiDate}">
				        <!-- 조건1이 참일 때 실행할 코드 -->
				         ${board.boardModiDate}
				    </c:when>		
					<c:otherwise>
				        <!-- 모든 조건이 거짓일 때 실행할 코드 -->
				        ${board.boardRegDate}		
				    </c:otherwise>	
				</c:choose>
            </span>                              
        </div>
        <div class="form-group">
            <label for="boardTitle">제목</label>
            <input type="text" id="boardTitle" name="boardTitle" value="${board.boardTitle}" readonly>
        </div>
        <div class="form-group">
            <label for="boardContent">내용</label>
            <textarea id="boardContent" name="boardContent" readonly>${board.boardContent}"</textarea>
        </div>
        </form>
        
         <!-- 좋아요!! -->
		<div class="like-container">
		    <svg id="like" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
		        <path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/>
		    </svg> 
		    <span id="likeCount" class="like-count">${board.likeCount}</span>		    
		</div>
		
		 
		
        <div class="button-group">
        
            <button type="button" id="btnList">목록</button>
      
<c:if test="${boardMe eq 'Y'}">        
            <button type="button" id="btnUpdate" class="btn btn-secondary">수정</button>
   			<button type="button" id="btnDelete" class="btn btn-secondary">삭제</button>
</c:if>
        </div>
<c:if test='${!empty cmList}'>
	<c:forEach var="comm" items="${cmList}" varStatus="status">
	 <c:if test="${comm.commParent eq boardSeq}">        
   		<!-- 댓글 목록 -->
		<div id="commentList" class="comment-list">
		    <!-- 예시 댓글 -->
		    <div class="comment">
		        <img src="/resources/board/ball.png" alt="User Image" class="comment-image" />
		        <div class="comment-details">
		            <div class="comment-header">
		                <span class="nickname">${comm.userNickname}</span>
		                <span class="comment-date">${comm.commRegDate}</span>
		            </div>
		            <div class="comment-content">${comm.commContent}</div>   
					
					<input type="hidden" name="commSeq" value="${comm.commSeq}"/>
					
					
					
					
<div class="comment-action">
			
			<!-- 대댓글 추가 폼 -->
			<div class="comment-section">
		    <!-- 댓글 추가 버튼 -->
		    <button id="add-comment-btn" class="comment-section__add-comment-btn">댓글</button>
		    
		    		  <!-- 클릭 버튼 -->
  			<button class="showButton comment-show-button">보이기</button>
		    
		    <!-- 댓글 작성 폼 -->
		    <div id="comment-form" class="comment-section__comment-form" style="display: none;">
		        <textarea id="twoCommContent" name="twoCommContent" class="comment-section__textarea" placeholder="댓글을 입력하세요..."></textarea>
		        <button id="btnTwoComm" class="comment-section__submit-comment-btn">등록</button>
		    </div>
		    
		    
		    
		    
		
	
		

<!-- 대댓글 히든 -->
<c:if test='${!empty replies}'>
 <c:forEach var="reply" items="${replies}" varStatus="status">
 <c:if test="${reply.commParent eq comm.commSeq}">
 <div class="hiddenContent comment-hidden-content" style="display: none;">
    <div class="comment-header">
        <span class="nickname">${reply.userNickname}</span> &nbsp;&nbsp;&nbsp;
        <span class="comment-date">${reply.commRegDate}</span>
    </div>
    <div class="comment-content">${reply.commContent}</div>
</div>
</c:if>
</c:forEach>
</c:if>
			  
			  
			  
	</div>
					
<c:if test="${comm.commMe eq 'Y'}">
    <div class="comment-action2" data-commSeq="${comm.commSeq}">
        <button class="com-update" id="commUp-${comm.commSeq}">수정</button>
        <button class="com-delete" id="commDel-${comm.commSeq}">삭제</button>
    </div>
</c:if>

<div class="commentUp-section">
    <!-- 댓글 수정 폼 -->
    <div id="commentUp-form-${comm.commSeq}" class="commentUp-section__comment-form" style="display: none;">
        <textarea id="commContentUp-${comm.commSeq}" name="commContentUp" class="commentUp-section__textarea" placeholder="댓글을 입력하세요..."></textarea>
        <button id="btnCommUp-${comm.commSeq}" class="commentUp-section__submit-comment-btn">등록</button>
    </div>
</div>




		    
</div>
			       	 
			
		        </div>
		    </div>    
		</div>	
		
	 </c:if>
	 </c:forEach>
</c:if>


		
         <!-- 댓글 입력 폼 -->
         <form name="commForm" id="commForm" method="POST">
   		 <div class="comment-container">
         <h3>댓글</h3>
       		 <div class="comment-form-group">
            	<textarea id="commContent" placeholder="댓글을 입력하세요..." rows="3"></textarea>
       		 </div>
         	 <div class="comment-form-group">
           	 	<button type="button" id="btnComm">댓글 등록</button>
        	 </div>
    	</div>
    	<input type="hidden" name="boardSeq" value="${boardSeq}"/>
    	</form>
    	
    	
    	
    	
    	
    <div class="bottom-menu">
         <nav>
            <ul class="pagination justify-content-center">
               <c:if test="${!empty paging}">
                  <c:if test="${paging.prevBlockPage gt 0}">
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
                  </c:if>
                  
                  <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
                     <c:choose>
                        <c:when test="${i ne cmCurPage}">
                           <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
                        </c:when>
                        <c:otherwise>
                           <li class="page-item active"><a class="page-link" href="javascript:void(0)" style="cursor: default;">${i}</a></li>                     
                        </c:otherwise>
                     </c:choose>
                  </c:forEach>
                  <c:if test="${paging.nextBlockPage gt 0}">
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})">다음블럭</a></li>
                  </c:if>         
               </c:if>
            </ul>
         </nav>
      </div>
      
      
      
</div>




<form name="boardForm" id="boardForm" method="POST">
		<input type="hidden" name="boardSeq" value="${boardSeq}"/>
   		<input type="hidden" name="searchType" value="${srarchType}"/>
   		<input type="hidden" name="searchValue" value="${searchValue}"/>
   		<input type="hidden" name="curPage" value="${curPage}"/>
   		<input type="hidden" name="cmCurPage" value="${cmCurPage}"/>
</form>



</body>
</html>
