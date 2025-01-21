<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Footer</title>
  <style>
    /* 전체 푸터 스타일 */
    footer {
    width: 100%;
    background-color: #1a1a1a;
    color: #fff;
    padding: 20px;
    font-family: Arial, sans-serif;
    text-align: center; /* 중앙 정렬 */
    z-index: 100;
}

    /* 로고 및 상단 메뉴 */
    .footer-top {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #333;
      padding-bottom: 10px;
      margin-bottom: 10px;
    }

    .footer-top a {
      color: #fff;
      text-decoration: none;
      margin-left: 15px;
      font-size: 14px;
    }

    /* 텍스트 정보 섹션 */
    .footer-info {
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
      font-size: 13px;
    }

    .footer-info div {
      margin-bottom: 10px;
      max-width: 45%; /* 줄넘김 방지 */
      
    }

    /* 소셜 아이콘들 */
    .social-icons {
      display: flex;
      gap: 10px;
    }

    .social-icons a {
      text-decoration: none;
      font-size: 24px;
    }

    /* 하단 저작권 섹션 */
    .copyright {
      margin-top: 10px;
      font-size: 11px;
      color: #aaa;
    }
    
  </style>
</head>
<body>

<!-- Footer 시작 -->
<footer>
  <div class="footer-top">
    <div class="logo">
      <strong>Pokémon Korea, Project.</strong>
    </div>
    <div class="footer-menu">
      <a href="#">회사소개</a>
      <a href="#">사업내용</a>
      <a href="#">제휴안내</a>
      <a href="#">이용약관</a>
      <a href="#">개인정보처리방침</a>
      <a href="#">이메일무단수집거부</a>
      <a href="#">고객센터</a>
    </div>
  </div>
   
  <div class="footer-info">
    <div>
      <p>(주)포켓몬코리아 서울 마포구 월드컵북로 21 풍성빌딩 2층<br>
      대표이사: 홍길동 &nbsp; 게임물관리위원회확인증번호: 123-45-67890</p>
      <p>고객센터 운영시간: 평일 15시 ~ 18시<br>
      전화: 031-272-0000</p>
      <p>카드 게임 및 기타 이벤트: 1588-도미노피자<br>
      이메일: <a href="mailto:webmaster@pokemonkorea.co.kr">webmaster@pokemonkorea.co.kr</a></p>
      <p>※ 본 사이트에서는 Pokémon GO 관련 문의를 받지 않습니다.</p>
    </div>
    <div class="social-icons">
      <a href="#" target="_blank">
       <img src="/resources/index/logo/.png" alt="포스트 이미지" onerror="this.onerror=null; this.src='/resources/board/ball.png'" />
      </a>
      <a href="#" target="_blank">
       <img src="/resources/board/ball.png" alt="포스트 이미지" onerror="this.onerror=null; this.src='/resources/board/ball.png'" />
      </a>
      <a href="#" target="_blank">
       <img src="/resources/index/logo/icon_poke.png" alt="포스트 이미지" onerror="this.onerror=null; this.src='/resources/board/ball.png'" />
      </a>
      <a href="#" target="_blank">
       <img src="/resources/board/ball.png" alt="포스트 이미지" onerror="this.onerror=null; this.src='/resources/board/ball.png'" />
      </a>
      <a href="#" target="_blank">
       <img src="/resources/board/ball.png" alt="포스트 이미지" onerror="this.onerror=null; this.src='/resources/board/ball.png'" />
      </a>
    </div>
  </div>
</footer>

</body>
</html>
