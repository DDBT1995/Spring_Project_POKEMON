<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티 게시판</title>
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
          border-color: #FED856; 
          cursor: pointer;
      }       
    </style>
</head>

<body>
    <div class="post-container">
        <!-- 게시글 리스트 -->
        <div class="post-item">
            <div class="post-icon">
               <img src="/resources/board/ball.png" alt="프로필 이미지" onerror="this.onerror=null; this.src='/resources/board/ball.png'" />
            </div>
            <div class="post-content">
                <a href="javascript:fn_view(시퀀스)" class="post-title">타이틀</a><br />
                <p class="post-description">내용</p>
                <p class="post-meta">닉네임 &nbsp;&nbsp; 조회수 &nbsp;&nbsp; 좋아요 &nbsp;&nbsp; 날짜</p>             
            </div>
            <img src="/resources/board/ball.png" alt="고양이 이미지" class="post-image" onerror="this.onerror=null; this.src='/resources/images/noimage.jpg'" />
        </div><br /><br />
      
      <!-- 글쓰기 버튼 -->
      <div class="write-btn">
         <button type="button" class="btn-write" id="btnWrite">글쓰기</button>
      </div>
   </div>
</body>
</html>