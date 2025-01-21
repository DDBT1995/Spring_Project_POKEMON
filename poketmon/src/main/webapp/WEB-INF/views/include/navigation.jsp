<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    text-decoration: none;
    list-style: none;
    font-family: 'Noto Sans KR', sans-serif;
    
}

body {
    overflow-y: scroll;
    padding-top: 120px;
}

a {
    color: black;
}

/* header */

header {
    height: 120px;
    display: flex;
    position: fixed;
    top: 0;
    width: 100%;
    background-color: white;
    z-index: 100;
    box-shadow: 0 1px 20px 1px rgba(0, 0, 0, 0.3);
    font-weight: 1000;
}

.headerLogo {
    width: 360px;
    height: 100%;
    background-color: white;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 0;
   line-height: 0;
}

.headerBox {
    display: flex;
    justify-content: space-between;
    width: 70%;
}

.headerNav {
    width: 60%;
}

.navList {
    display: flex;
    height: 100%;
    border-left: 2px solid #eee;
    margin-bottom: 0;
}

.navList > li {
    width: 25%;
    height: 100%;
    border-right: 1px solid #eee;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: 0.5s;
}

.navList > li > a {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    color: #000;
    width: 100%;
    height: 100%;
    text-decoration: none;
}

.navList > li:nth-child(1):hover {
    background-color: cadetblue;
    cursor: pointer;
    color: #fff;
}

.navList > li:nth-child(1):hover i {
    background: url(/resources/index/logo/icon_news_w.png) no-repeat !important;
    padding: 20px;
    background-size: contain !important;
}

.navList > li:nth-child(2):hover {
    background-color: blue;
    cursor: pointer;
    color: #fff;
}

.navList > li:nth-child(2):hover i {
    background: url(/resources/index/logo/icon_card_w.png) no-repeat !important;
    padding: 20px;
    background-size: contain !important;
}

.navList > li:nth-child(3):hover {
    background-color: blueviolet;
    cursor: pointer;
    color: #fff;
}

.navList > li:nth-child(3):hover i {
    background: url(/resources/index/logo/icon_ball_w.png) no-repeat !important;
    padding: 20px;
    background-size: contain !important;
}

.navList > li:hover a {
    color: #fff;
}

.iconNews {
    background: url(/resources/index/logo/icon_news.png) no-repeat !important;
    padding: 20px;
    background-size: contain !important;
}

.iconBoard {
    background: url(/resources/index/logo/icon_card.png) no-repeat !important;
    padding: 20px;
    background-size: contain !important;
}

.iconProduct {
    background: url(/resources/index/logo/icon_ball.png) no-repeat !important;
    padding: 20px;
    background-size: contain !important;
}

.headerNavRight {
    width: 400px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 0;
}

.headerNavRight > li {
    width: 30%;
}

.headerNavRight > li > a {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    cursor: pointer;
}

.headerNavRight > li > a:hover {
   text-decoration: none !important;
   color: black !important;
}

.headerNavRight i {
    margin-bottom: 5px;
}

.dogamIcon {
    background: url(/resources/index/logo/icon_ball_c.png) no-repeat !important;
    padding: 23px;
    background-size: contain !important;
}
.myPageIcon{
    background: url(/resources/index/logo/icon_login.png) no-repeat !important;
    padding: 23px;
    background-size: contain !important;
}

.loginIcon {
    background: url(/resources/index/logo/icon_login.png) no-repeat !important;
    padding: 23px;
    background-size: contain !important;
}

.loginOutIcon{
    background: url(/resources/index/logo/icon_loginOut.png) no-repeat !important;
    padding: 23px;
    background-size: contain !important;
}

.searchIcon {
    background: url(/resources/index/logo/icon_search.png) no-repeat !important;
    padding: 23px;
    background-size: contain !important;
}

.headerRightLink {
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: yellow;
}

</style>


<header>
   <h1 class="headerLogo">
      <a href="/"> <img
         src="/resources/index/logo/main_logo.png" />
      </a>
   </h1>
   <div class="headerBox">
      <nav class="headerNav">
         <ul class="navList">
            <li><a href="te.html"> <i class="iconNews"></i> <span>소식</span>
            </a></li>
            <li><a> <i class="iconBoard"></i> 게시판
            </a></li>
            <li><a> <i class="iconProduct"></i> 상품
            </a></li>
         </ul>
      </nav>
      <ul class="headerNavRight">
         <li><a href="/"> <i class="dogamIcon"></i> 포켓몬도감
         </a></li>
         <li><a href="/user/loginForm"> <i class="loginIcon"></i> 로그인
         </a></li>
         <li><a> <i class="searchIcon"></i> 검색
         </a></li>
      </ul>
   </div>

   <div class="headerRightLink">
      <img src="/resources/index/logo/a-store.png" />
   </div>
</header>
<div class="headerEnd"></div>

</head>
<body>
<%
	if(com.sist.web.util.CookieUtil.getCookie(request, 
			(String)request.getAttribute("AUTH_COOKIE_NAME")) != null) 
	{
%>
	  <header>
         <h1 class="headerLogo">
            <a href="/index.html">
               <img src="/resources/index/logo/main_logo.png"/>
            </a>
         </h1>

         <div class="headerBox">
            <nav class="headerNav">
               <ul class="navList">
                  <li>
                     <a href="te.html">
                        <i class="iconNews"></i>
                        <span>소식</span>
                     </a>
                  </li>
                  <li>
                     <a href="/board/boardList">
                        <i class="iconBoard"></i>
                        게시판
                     </a>
                  </li>
                  <li>
                     <a>
                        <i class="iconProduct"></i>
                        상품
                     </a>
                  </li>
               </ul>
            </nav>
            <ul class="headerNavRight">
               <li>
                  <a href="/">
                     <i class="dogamIcon"></i>
                     포켓몬도감
                  </a>
               </li>
               <li>
                  <a href="/user/myPageForm">
                    <i class="myPageIcon"></i>
                    마이페이지
                  </a>
               </li>
               <li>
              		<a href="/user/loginOut">
                    <i class="loginOutIcon"></i>
                    로그아웃
                   </a>             
               </li>
               <li>
                  <a>
                     <i class="searchIcon"></i>
                     검색
                  </a>
               </li>
            </ul>
         </div>

         <div class="headerRightLink">
            <img src="/resources/index/logo/a-store.png" />
         </div>
      </header>
 
      
<%
	}
	else
	{
%>
	  <header>
         <h1 class="headerLogo">
            <a href="/index.html">
               <img src="/resources/index/logo/main_logo.png"/>
            </a>
         </h1>

         <div class="headerBox">
            <nav class="headerNav">
               <ul class="navList">
                  <li>
                     <a href="te.html">
                        <i class="iconNews"></i>
                        <span>소식</span>
                     </a>
                  </li>
                  <li>
                      <a href="/board/boardList">
                        <i class="iconBoard"></i>
                        게시판
                     </a>
                  </li>
                  <li>
                     <a>
                        <i class="iconProduct"></i>
                        상품
                     </a>
                  </li>
               </ul>
            </nav>
            <ul class="headerNavRight">
               <li>
                  <a href="/">
                     <i class="dogamIcon"></i>
                     포켓몬도감
                  </a>
               </li>
               <li>
                  <a href="/user/loginForm">
                    <i class="loginIcon"></i>
                    로그인
                  </a>
               </li>
               <li>
                  <a>
                     <i class="searchIcon"></i>
                     검색
                  </a>
               </li>
            </ul>
         </div>

         <div class="headerRightLink">
            <img src="/resources/index/logo/a-store.png" />
         </div>
      </header>

<%
	}
%>
</body>
</html>