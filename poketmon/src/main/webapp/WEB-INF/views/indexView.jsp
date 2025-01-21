<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/index.css">
    
    <script type="text/javascript">
    
    function pokeView(pokeId) {  
    	       
        document.pkForm.pokeId.value = pokeId;  
        document.pkForm.action.value = "/indexView";  
        document.pkForm.submit();  
    }

    
    
    </script>
</head>
<style>
    * {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

.viewTop {
    width: 100%;
    height: 130px;
    display: flex;
    justify-content: space-between;
}

.viewTop > div {
    background-color: #393939;
    width: 48%;
    position: relative;
    color: aliceblue;
    transition: 0.2s;
}

.viewTop > div:hover {
    background-color: black;
}

.viewTop > div > div {
    display: flex;
    justify-content: space-around;
    align-items: center;
    width: 250px;
}

.viewTop > div > div > i {
    background: url(/resources/index/indexView/icon_prev_book.png) no-repeat;
    width: 56px;
    height: 56px;
}

.bookIconNext {
    transform: rotate(180deg);
}

.viewTopLeft > div {
    position: absolute;
    top: 20px;
    left: 20px;
}

.viewTopRight > div {
    position: absolute;
    top: 20px;
    right: 20px;
}

.viewTopTitle {
    font-size: 1.5em;
    font-weight: 1000;
}

.contentBox {
    width: 100%;
    border-top: 0px;
    position: relative;
    background: url(/resources/index/indexView/bg_pattern2.jpg);
    padding-bottom: 100px;
}

.contentBar {
    background: url(/resources/index/indexView/content_top.png) no-repeat 100% center;
    background-size: cover;
    width: 70%;
    height: 40px;
    position: absolute;
    top: -40px;
    left: 50%;
    transform: translateX(-50%);
    background-color: #393939;
}

.contentMainBox {
    width: 70%;
    height: auto;
    margin: auto;
    background-color: white;
}

.contentScriptBox {
    display: flex;
    height: 610px;
    padding: 15px 50px 50px 50px;
    border-right: 2px solid #393939;
    border-left: 2px solid #393939;
    border-bottom: 2px solid #393939;
}

.contentScriptBox > div {
    width: 50%;
}
.contentScriptBox > div:nth-child(1) {
    width: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
}
.contentScriptBox > div:nth-child(2) {
    width: 50%;
}

.contentScriptDetail {
    display: flex;
    justify-content: space-around;
}

.contentScript > h3 {
    margin-top: 40px;
    font-size: 1.5em;
    color: #999;
}

.contentScript > h2 {
    font-size: 2em;
}

.contentScript > p {
    margin-top: 40px;
    font-size: 1.5em;
    font-weight: 400;
}

.contentScriptDetail {
    margin-top: 100px;
    border: 1px solid #e8e8e8;
    border-radius: 7px;
    padding: 8px 30px 20px;
}

.contentScriptDetail > div {
    height: 80px;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
}

.contentScriptDetail > div > span {
    color: #999;
}

.contentScriptDetail > div > p {
    font-weight: bold;
}

.poketmonClassBox {
    width: 70%;
    height: 550px;
    margin: 40px auto 40px auto;
    padding: 40px 35px;
    background-color: white;
}

.poketmonClassBoxTitle {
    display: flex;
}

.poketmonClassIconBox {
    background: url(/resources/index/indexView/icon_ball_c.png) no-repeat;
    width: 40px;
    height: 40px;
}

.poketmonCard {
    border-radius: 7px;
    padding: 10px 20px;
    width: 28%;
}

.poketmonCardList {
    display: flex;
    justify-content: space-around;
}

.poketmonCardImgBox {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #e8e8e8;
    height: 300px;
}

.poketmonCardImg {
    width: 80%;
}

.poketmonCardTitle {
    margin-top: 20px;
}

.poketmonCardTitle > span {
    color: #999;
    font-size: 1em;
}

.poketmonCardTitle > p {
    margin-top: 5px;
    font-size: 1.5em;
    font-weight: bold;
}

.viewEnd {
    width: 100%;
    padding: 30px 0px 50px 0px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.viewEnd > a {
    width: 40px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-decoration: none;
    color: black;
    font-weight: bold;
}

.viewEnd img {
    width: 30px;
}

.store-button {
            width: 100%;
            height: 70px;
            padding: 1rem;
            background-color: #000;
            color: #fff;
            border: none;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            transform: skew(-15deg); /* 평행사변형 */
        }

        .store-button span {
            display: block;
            transform: skew(10deg); /* 텍스트를 원래 각도로 */
        }

        .store-button {
            background-color: #333;
        }
</style>
<body style="background-color: #F7F7F7;">
    <div class="viewTop">
        <div class="viewTopLeft" onClick="pokeView(${poketmonPrev.pokeId})">
            <div>
                <i class="bookIcon" ></i>
                <p>No.${poketmonPrev.pokeId}</p>
                <p class="viewTopTitle">${poketmonPrev.pokeName}</p>
            </div>
        </div>
        <div class="viewTopRight" onClick="pokeView(${poketmonNext.pokeId})">
            <div>
                <p class="viewTopTitle">${poketmonNext.pokeName}</p>
                <p>No.${poketmonNext.pokeId}</p>
                <i class="bookIconNext" ></i>
            </div>
        </div>
    </div>
    <div class="contentBox">
        <div class="contentBar"></div>
        <div class="contentMainBox">
            <div class="contentScriptBox">
                <div>
                    <img src="/resources/images/poketmonImg/${poketmon.pokeImg}" alt="포켓몬">
                </div>
                <div class="contentScript">
                    <h3>No.${poketmon.pokeId}</h3>
                    <h2>${poketmon.pokeName}</h2>
                    <p>${poketmon.pokeContent}</p>
                    <div class="contentScriptDetail" onClick= >
                        <div class="scriptType">
                            <span>타입</span>
                            <p>${poketmon.pokeTypenameFirst}&nbsp;${poketmon.pokeTypenameSecond}</p>
                        </div>
                        <div class="scriptHeight">
                            <span>키</span>
                            <p>${poketmon.pokeHeight}M</p>
                        </div>
                        <div class="scriptWeight">
                            <span>몸무게</span>
                            <p>${poketmon.pokeWeight}KG</p>
                        </div>
                    </div>
                </div>                
            </div>
             <button type="button" class="store-button" id="store-button"
             onclick="window.open('https://www.pokemonstore.co.kr/pages/product/list.html?keyword=${poketmon.pokeName}')"
              ><span>${poketmon.pokeName} 상품 쇼핑</span></button>
        </div>
    </div>

    <div class="poketmonClassBox">
        <div class="poketmonClassBoxTitle">
            <div class="poketmonClassIconBox"></div>
            <h2>진화</h2>
        </div>               
        <div class="poketmonCardList">
        
        
        <c:if test='${!empty poketmonEvo}'>
        
        <c:forEach var="poke" items="${poketmonEvo}" varStatus="status">
        
        
            <div class="poketmonCard">
                <div class="poketmonCardImgBox">
                    <img class="poketmonCardImg" src="/resources/images/poketmonImg/${poke.pokeImg}" alt="이미지">
                </div>
                <div class="poketmonCardTitle">
                    <span>No.${poke.pokeId}</span>
                    <p>${poke.pokeName}</p>
                </div>
                <div class="poketmonCardType">
                    <span>${poke.pokeTypenameFirst}</span>
                    <span>${poke.pokeTypenameSecond}</span>
                </div>
            </div>
         </c:forEach>
         </c:if>
           
        </div>
    </div>

    <div class="viewEnd">
        <a href="/index">
            <img src="/resources/index/indexView/icon_list.png" alt="목록 이미지">
            <span>목록</span>
        </a>
    </div>
    <form name="pkForm" id="pkForm" method="GET">
    <input type="hidden" name="pokeId" value=""/>
    </form>
</body>
</html>