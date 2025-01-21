<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Document</title>
      <link rel="stylesheet" href="/index.css" />
      <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
        crossorigin="anonymous"></script>

<style>
   * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    text-decoration: none;
    list-style: none;
}

a {
    color: black;
}

input[type="checkBox"] {
    display: none;
}



/* mainSearch */

.mainSearch {
    width: 100%;
    height: 100px;
    display: flex;
    background-color: #393939;
    padding: 30px 25px 20px;
    color: #FFFFFF;
    justify-content: space-around;
    align-items: center;
    padding-bottom: 80px;
    padding-top: 50px;
    
}

.icon_ball0810 {
	display: flex;
    width: 60px; /* 아이콘의 너비 */
    height: 70px; /* 아이콘의 높이 */
    margin-top: 10px; /* 검색바와의 간격 */
    margin-right: 10px; /* 아이콘과 글자 간의 간격 */
    padding-top: 10px; /* 글자를 아래로 내리기 위해 패딩 추가 */
    
}



.mainSearchLeft {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 140px;
    
}

.searchLabel {
 	display: flex;
    font-size: 26px; /* 글자 크기 조정 */
    margin-right: 5px; /* 검색바와의 간격 */
    padding-top: 20px; /* 글자를 아래로 내리기 위해 패딩 추가 */
    white-space: nowrap; /* 줄 바꿈 방지 */
    width: 300px;
    
}

.mainSearchRight {
    width: 85%;
}

.mainSearchRightInputBox {
    display: flex;
}

.mainSearchRightInputBox > input {
    background-color: #0E0E0E;
    color: #FFFFFF;
    font-size: 20px;
    width: 95%;
    padding: 20px;
    border: none;
    border-radius: 5px;
    outline: none;
    margin-top: 25px; /* 원하는 값으로 조정 */
    margin-left: 30px;
    
}

.mainSearchRightInputBox > button {
    background-color: #DA343C;
    padding: 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-top: 25px;
}

.mainSearchRightInputBox > button > img{
    width: 30px;
}

.searchMenuBox {
    position: relative;
}

.searchMenu {
    width: 100%;
    height: 425px;
    background-color: #393939;
    color: #fff;
    display: none;
}

.searchMenuForm {
    width: 60%;
    display: flex;
    margin: auto;
    justify-content: space-between;
}

.searchMenuLeft {
    width: 40%;
    height: 230px;
    justify-content: space-between;
    display: flex;
    flex-direction: column;
    
}

.searchMenuRight {
    width: 50%;
}

.searchMenuLeft input,select {
    background-color: #393939;
    border: 1px solid #BBBBBB;
    color: #fff;
    outline: none;
    padding: 18px;
    width: 70%;
    font-size: 15px;
}

.searchMenuLeft select {
    text-align-last: center;
    cursor: pointer;
}

.searchMenuNature, .searchMenuRegion {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.searchMenuDogam {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.searchMenuDogamInputBox {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 70%;
}

.searchMenuDogam input {
    width: 40%;
}

.mainSearchMenuShowBtn {
    
    color: #fff;
    width: 120px;
    height: 29px;
    margin: auto;
    position: absolute;
    bottom: -28px;
    right: 50%;
    transform: translate(50%);
    background: url(/resources/index/logo/icon_close2.png) no-repeat !important;
    border: none;
    cursor: pointer;
    padding-bottom: 10px;
    z-index: 1; /* 낮은 z-index 값 */


}

.mainSearchMenuHideBtn {
    color: #fff;
    width: 120px;
    height: 29px;
    margin: auto;
    position: absolute;
    bottom: -28px;
    right: 50%;
    translate: 50%;
    background: url(/resources/index/logo/icon_close2.png) no-repeat !important;
    border: none;
    cursor: pointer;
    padding-bottom: 10px;
}

.searchMenuTypeCheckBox {
    display: flex;
    flex-wrap: wrap;
    gap: 3%;
}

.searchMenuTypeCheck {
    width: 17%;
    height: 80px;
    background: blue;
    margin-bottom: 10px;
    color: #000;
}

.searchMenuTypeCheck > label {
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.searchMenuTypeImg {
    background: url(/resources/index/poType/nomal.png) no-repeat !important;
    padding: 25px;
    background-size: contain !important;
}

.searchMenuTypeImgSelect {
    position: absolute;
    top: 70%;
    left: 50%;
    translate: -50%;
    background: url(/resources/index/poType/nomalSelect.png) no-repeat !important;
    padding: 50%;
    background-size: contain !important;
    display: none;
}



/* section */

.sortingBar {
    margin-top: 60px;
    margin-right: 50px;
    float: right;
}

.sortingBar > select {
    width: 500px;
}

.clear {
    margin-bottom: 50px;
    clear: both;
}

.mainListBox {
    display: flex;
    flex-wrap: wrap;
    font-weight: 1000;
}

.mainListItemBox {
    max-width: 16%;
    margin: 30px 2% 0 2%;
}

.mainListItemImg {
    border: 1px solid #e8e8e8;
    display: flex;
    justify-content: center;
    align-items: center;
}

.mainListItemBox img {
    width: 80%;
}

.mainListItemBox span {
    color: #999;
}

.mainListItemTypeBox {
    display: flex;
    justify-content: space-around;
}

.mainListItemTitle {
    margin-left: 30px;
}

.mainListItemTitle > h3 {
    margin-top: 10px;
    margin-bottom: 20px;
}

.mainListItemTypeBox > div {
    width: 40%;
    display: flex;
    justify-content: center;
    align-items: center;
    color: #FFFFFF;
    border-radius: 10px;
    padding: 5px 20px;
}

.grassType {
    background-color: #42BF24;
}

.poisonType {
    background-color: #994DCF;
}
</style>

   </head>
   <body>
   <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
         <div class="mainSearch">
            <div class="mainSearchLeft">
              <div class="icon_ball0810"> 
              <img src="/resources/index/logo/icon_ball_b.png" />
              </div>
              <span class="searchLabel">
             	포켓몬 도감
             </span>
            </div>
            <div class="mainSearchRight">
               <div class="mainSearchRightInputBox">
                  <input placeholder="포켓몬 이름 또는 설명, 특성 키워드를 입력해주세요." />
                  <button>
                     <img src="/resources/index/logo/search.png" alt="searchBtb" />
                  </button>
               </div>
            </div>
            
         </div>

         <div class="searchMenuBox">
         <div class="searchMenu">
            <form class="searchMenuForm">
               
               <div class="searchMenuLeft">
                  <div class="searchMenuNature">
                     <p>특성</p>
                     <select>
                        <option value="d">전체</option>
                        <option value="d">dd</option>
                        <option value="d">dd</option>
                        <option value="d">dd</option>
                     </select>
                  </div>
                  <div class="searchMenuRegion">
                     <p>지방</p>
                     <select>
                        <option value="d">전체</option>
                        <option value="d">dd</option>
                        <option value="d">dd</option>
                        <option value="d">dd</option>
                     </select>
                  </div>
                  <div class="searchMenuDogam">
                     <p>도감번호</p>
                     <div class="searchMenuDogamInputBox">
                        <input type="text" />
                        <span>-</span>
                        <input type="text" />
                     </div>
                  </div>
               </div>

               <div class="searchMenuRight">
                  <p>타입</p>
                  <div class="searchMenuTypeCheckBox">
                     <div class="searchMenuTypeCheck">
                        <label>
                           <input type="checkbox" class="tt" value="nomal">
                           <div class="searchMenuTypeImgBox">
                              <img class="searchMenuTypeImg">
                              <p>노말</p>
                           </div>
                           <img class="searchMenuTypeImgSelect">
                        </label>
                     </div>
                     <div class="searchMenuTypeCheck">
                        <label>
                           <input type="checkbox" class="tt" value="nomal">
                           <div class="searchMenuTypeImgBox">
                              <img class="searchMenuTypeImg">
                              <p>노말</p>
                           </div>
                           <img class="searchMenuTypeImgSelect">
                        </label>
                     </div>
                     <div class="searchMenuTypeCheck">
                        <label>
                           <input type="checkbox" class="tt" value="nomal">
                           <div class="searchMenuTypeImgBox">
                              <img class="searchMenuTypeImg">
                              <p>노말</p>
                           </div>
                           <img class="searchMenuTypeImgSelect">
                        </label>
                     </div>
                     <div class="searchMenuTypeCheck">
                        <label>
                           <input type="checkbox" class="tt" value="nomal">
                           <div class="searchMenuTypeImgBox">
                              <img class="searchMenuTypeImg">
                              <p>노말</p>
                           </div>
                           <img class="searchMenuTypeImgSelect">
                        </label>
                     </div>
                     <div class="searchMenuTypeCheck">
                        <label>
                           <input type="checkbox" class="tt" value="nomal">
                           <div class="searchMenuTypeImgBox">
                              <img class="searchMenuTypeImg">
                              <p>노말</p>
                           </div>
                           <img class="searchMenuTypeImgSelect">
                        </label>
                     </div>
                     <div class="searchMenuTypeCheck">
                        <label>
                           <input type="checkbox" class="tt" value="nomal">
                           <div class="searchMenuTypeImgBox">
                              <img class="searchMenuTypeImg">
                              <p>노말</p>
                           </div>
                           <img class="searchMenuTypeImgSelect">
                        </label>
                     </div>
                     <div class="searchMenuTypeCheck">
                        <label>
                           <input type="checkbox" class="tt" value="nomal">
                           <div class="searchMenuTypeImgBox">
                              <img class="searchMenuTypeImg">
                              <p>노말</p>
                           </div>
                           <img class="searchMenuTypeImgSelect">
                        </label>
                     </div>
                  </div>
               </div>
            
            </form>
         </div>
         <button class="mainSearchMenuShowBtn">
            <p>상세검색</p>
         </button>
      </div>

      <section>
         <div class="sortingBar">
            <select>
               <option></option>
            </select>
         </div>

         <div class="clear"></div>

         <div class="mainListBox">
            <div class="mainListItemBox">
               <a href="#">
                  <div class="mainListItemImg">
                     <img src="/resources/index/poketmon/000101.png">
                  </div>
                  <div class="mainListItemTitle">
                     <span>No.0001</span>
                     <h3>이상해씨</h3>
                  </div>
                  <div class="mainListItemTypeBox">
                     <div class="grassType">풀</div>
                     <div class="poisonType">독</div>
                  </div>
               </a>
            </div>
            <div class="mainListItemBox">
               <a href="#">
                  <div class="mainListItemImg">
                     <img src="/resources/index/poketmon/000101.png">
                  </div>
                  <div class="mainListItemTitle">
                     <span>No.0001</span>
                     <h3>이상해씨</h3>
                  </div>
                  <div class="mainListItemTypeBox">
                     <div class="grassType">풀</div>
                     <div class="poisonType">독</div>
                  </div>
               </a>
            </div>
            <div class="mainListItemBox">
               <a href="#">
                  <div class="mainListItemImg">
                     <img src="/resources/index/poketmon/000101.png">
                  </div>
                  <div class="mainListItemTitle">
                     <span>No.0001</span>
                     <h3>이상해씨</h3>
                  </div>
                  <div class="mainListItemTypeBox">
                     <div class="grassType">풀</div>
                     <div class="poisonType">독</div>
                  </div>
               </a>
            </div>
            <div class="mainListItemBox">
               <a href="#">
                  <div class="mainListItemImg">
                     <img src="/resources/index/poketmon/000101.png">
                  </div>
                  <div class="mainListItemTitle">
                     <span>No.0001</span>
                     <h3>이상해씨</h3>
                  </div>
                  <div class="mainListItemTypeBox">
                     <div class="grassType">풀</div>
                     <div class="poisonType">독</div>
                  </div>
               </a>
            </div>
            <div class="mainListItemBox">
               <a href="#">
                  <div class="mainListItemImg">
                     <img src="/resources/index/poketmon/000101.png">
                  </div>
                  <div class="mainListItemTitle">
                     <span>No.0001</span>
                     <h3>이상해씨</h3>
                  </div>
                  <div class="mainListItemTypeBox">
                     <div class="grassType">풀</div>
                     <div class="poisonType">독</div>
                  </div>
               </a>
            </div>
            <div class="mainListItemBox">
               <a href="#">
                  <div class="mainListItemImg">
                     <img src="/resources/index/poketmon/000101.png">
                  </div>
                  <div class="mainListItemTitle">
                     <span>No.0001</span>
                     <h3>이상해씨</h3>
                  </div>
                  <div class="mainListItemTypeBox">
                     <div class="grassType">풀</div>
                     <div class="poisonType">독</div>
                  </div>
               </a>
            </div>
         </div>
      </section>

      <script>
         $(document).ready(function() {
            $(".mainSearchMenuShowBtn").on("click", function () {
               const searchMenu = $(".searchMenu");

               if(searchMenu.is(":visible")) {
                  searchMenu.slideUp();
                  $(".mainSearchMenuShowBtn").html("상세검색");
               } else {
                  searchMenu.slideDown();
                  $(".mainSearchMenuShowBtn").html("닫기");
               } 
            });

            $(".tt").on("click", function() {
               const isCheck = $(this).prop("checked");
               const chVal = $(this).val();
               console.log("노말" + isCheck + " val : " + chVal);
               
               const parentElement = $(this).closest(".searchMenuTypeCheck");

               if(isCheck) {
                  parentElement.find(".searchMenuTypeImgBox").hide();
                  parentElement.find(".searchMenuTypeImgSelect").show();
               } else {
                  parentElement.find(".searchMenuTypeImgBox").show();
                  parentElement.find(".searchMenuTypeImgSelect").hide();
               }
            });
         });

      </script>
   </body>
</html>
