<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

<title>포켓몬 커뮤니티</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f9f9f9;
}
.post-container {
    width: 80%;
    margin: 20px auto;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}
.post-item {
    border-bottom: 1px solid #e0e0e0;
    padding: 20px 0;
    display: flex;
}
.post-item:last-child {
    border-bottom: none;
}
.post-icon {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: #ffffff;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 24px;
    margin-right: 15px;                  
}

.post-icon > img {
    width: 50px;
    height: 50px;
    border-radius: 70%; 
    object-fit: cover;
}

.post-content {
    flex: 1;
}
.post-title {
    font-weight: bold;
    font-size: 18px;
    margin: 0;
    text-decoration: none; /* 밑줄 제거 */
    color: inherit; /* 링크의 글자색을 부모 요소에 상속 */
}
.post-description {
    margin: 8px 0;
    color: #555;
}
.post-meta {
    font-size: 12px;
    color: #999;
    grid-gap: 40px;
}
.post-image {
    width: 100px;
    height: 100px;
    object-fit: cover;
    border-radius: 10px;
    margin-left: 20px;
}

.write-btn {
  display: inline-block;
  margin-left: 30px;
  display: flex;
  justify-content: flex-end;
}

.btn-write {
    background-color: #FED856;
    color: white;
    font-size: 15px;
    font-weight: bold;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 50px;
    border: none;
    cursor: pointer;
}

hr {
   border: 0;
   height: 1px;
   background-color: #ddd;
   margin: 20px 0;
}

#btnSearch {
   background-color: #FED856;
    color: white;
    font-size: 15px;
    font-weight: bold;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 20px;
    border: none;
    cursor: pointer;
}

.search-bar {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}
.search-bar select,
.search-bar input[type="text"] {
    padding: 10px;
    margin-right: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}
.search-bar button {
    background-color: #FFD700;
    color: #333;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}
.bottom-menu {
   flex-direction: row !important; /* 가로 배치를 강제 */
   margin-left: 30px;
   display: flex;
   justify-content: center;
   margin-top: 10px;
   
}

.page-item {
    display: inline-block; /* 인라인 블록으로 설정하여 가로로 나열 */
    
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





</style>

<script>
$(document).ready(function() {
	
	$("#btnWrite").on("click",function() {
		document.boardForm.boardSeq.value = "";
	    document.boardForm.action = "/board/writeForm";
	    document.boardForm.submit();
	});$
	
	$("#btnSearch").on("click", function() {
		document.boardForm.boardSeq.value = "";
		document.boardForm.searchType.value = $("#_searchType").val();
		document.boardForm.searchValue.value = $("#_searchValue").val();
		document.boardForm.curPage.value = "1";
		document.boardForm.action = "/board/boardList";
		document.boardForm.submit();
   });
	
	
});
function fn_view(boardSeq)
{
	document.boardForm.boardSeq.value = boardSeq;
	document.boardForm.action = "/board/boardView";
	document.boardForm.submit();
}

function fn_list(curPage)
{
	document.boardForm.boardSeq.value = "";
	document.boardForm.curPage.value = curPage;
	document.boardForm.action = "/board/boardList";
	document.boardForm.submit();
}




</script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<div class="post-container">
    <!-- 게시글 리스트 -->
    <h3>  커뮤니티 게시판  </h3><br />
    
    <!-- 검색 바 -->
    <div class="search-bar">
        <form action="/board" method="get" style="display: flex; width: 100%;">
            <select name="searchOption" id="_searchType">
               <option value="">조회항목</option>
                <option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>닉네임</option>
                <option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>제목</option>
                <option value="3" <c:if test='${searchType eq "3"}'>selected</c:if>>내용</option>
            </select>
            <input type="text" id="_searchValue" name="_searchValue" placeholder="조회값을 입력하세요." style="flex: 1;">
            <button type="button" id="btnSearch">조회</button>
        </form>
    </div>
    
    <hr>
<!--  var: for문 내부에서 사용할 변수, items: 리스트가 받아올 배열이름, varStatus:상태용 변수 -->
<c:if test='${!empty list}'>
	<c:forEach var="board" items="${list}" varStatus="status">    
	    <div class="post-item">
	        <div class="post-icon">
	           <img src="/resources/board/ball.png" alt="포스트 이미지" onerror="this.onerror=null; this.src='/resources/board/ball.png'" />
	        </div>
	        <div class="post-content">
	            <a href="javascript:fn_view(${board.boardSeq})" class="post-title">${board.boardTitle}</a><br />
	             <p class="post-description">${fn:substring(board.boardContent, 0, 36)}</p> <!-- 10자리로 제한 -->
	            <p class="post-meta">${board.userNickname} &nbsp;&nbsp; <i class="fa-solid fa-eye"></i> <fmt:formatNumber type="number" maxFractionDigits="3" groupingUsed="true" value="${board.boardReadCnt}"/> &nbsp;&nbsp; 
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
				</p>	          	                         
	        </div>
	        <c:if test="${!empty board.boardModiDate}">
            <p>(수정)</p>
        	</c:if>
	       
	        <img src="/resources/board/ball.png" alt="포스트 이미지" class="post-image" onerror="this.onerror=null; this.src='/resources/images/noimage.jpg'" />
	    </div>
    </c:forEach>
</c:if>




    <br /><br />

    
    <div class="bottom-menu">
         <nav>
            <ul class="pagination justify-content-center">
               <c:if test="${!empty paging}">
                  <c:if test="${paging.prevBlockPage gt 0}">
                     <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})">이전블럭</a></li>
                  </c:if>
                  
                  <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
                     <c:choose>
                        <c:when test="${i ne curPage}">
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
  
  <!-- 글쓰기 버튼 -->
   <div class="write-btn">
      <button type="button" class="btn-write" id="btnWrite">글쓰기</button>
   </div>
</div>
<form name="boardForm" id="boardForm" method="post">
   		<input type="hidden" name="boardSeq" value="${boardSeq}"/>
   		<input type="hidden" name="searchType" value="${searchType}"/>
   		<input type="hidden" name="searchValue" value="${searchValue}"/>
   		<input type="hidden" name="curPage" value="${curPage}"/>
</form>
</body>
</html>