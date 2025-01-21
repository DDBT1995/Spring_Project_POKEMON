<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Document</title>
      <link rel="stylesheet" href="/index.css" />
      <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<style>
   * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    text-decoration: none;
    font-weight: 1000;
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

.mainSearchLeft {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 170px;
}

.mainSearchRight {
    width: 90%;
}

.mainSearchRightInputBox {
    display: flex;
}

.mainSearchRightInputBox > input {
    background-color: #0E0E0E;
    color: #FFFFFF;
    font-size: 18px;
    width: 95%;
    padding: 10px;
    border: none;
    border-radius: 5px;
    outline: none;
}

.mainSearchRightInputBox > button {
    background-color: #DA343C;
    padding: 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
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
    translate: 50%;
    background: url(/resources/index/logo/icon_close2.png) no-repeat !important;
    border: none;
    cursor: pointer;
    padding-bottom: 10px;
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

.searchPoketmonCheckBox {

}

.searchMenuTypeCheck {
    width: 17%;
    height: 80px;
    margin-bottom: 10px;
    color: #000;
    background-color: white;
}

.searchMenuTypeCheck > label {
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
}

.searchMenuTypeImg {
    padding: 25px;
    background-color: white;
    background-size: contain !important;
    
   
    
    
}

.searchMenuTypeImgBox {
   display: flex;
    justify-content: center;
    align-item: center;
    flex-direction: column;
    position: absolute;
}

.searchMenuTypeImgBox {
   text-align: center;
}


.searchMenuTypeImgBoxSelect {
  display: block;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  position: absolute;
  width: 100%;
  height: 100%;
}

.searchMenuTypeImgSelect {
  display: none;
  width: 100%;
  height: 100%;
  background-size: contain !important;  /* 이미지의 비율을 유지하면서 부모 크기에 맞추기 */
  background-position: center;         /* 이미지가 부모 요소의 중앙에 배치되도록 */
  background-repeat: no-repeat;        /* 이미지가 반복되지 않도록 */
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
}

.mainListItemBox {
    max-width: 16%;
    margin: 30px 2% 0 2%;
    padding: 10px 20px;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
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
    width: 45%;
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

.mainListItemBox:hover {
   transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
}






body>section {
   margin: 45px 0 190px;
   padding: 0 60px;
}

/* KSW 정렬 div css */
.sortingBar {
   width: 380px;
   height: auto;
   border: 3px solid #000;
   border-radius: 8px;
   float: right;
   position: relative; /* 부모 요소 기준으로 정렬 */
}

/* KSW 정렬 셀렉트 박스 css */
.custom-select {
   width: 90% !important;
   float: right !important;
   padding: 15px 15px 15px 60px;
   font-size: 18px;
   border: 1px solid #bbb;
   -webkit-appearance: none;
   -moz-appearance: none;
   background-color: #fff;
   box-sizing: border-box;
   cursor: pointer;
}

/* KSW 정렬 셀렉트 박스 앞에 이미지 추가 */
.sortingBar::before {
   content: "";
   position: absolute;
   top: 50%;
   transform: translateY(-50%);
   width: 10%;
   height: 100%;
   background: black url('/resources/index/logo/icon_dropdown.png') no-repeat center;
}

</style>

   </head>
   <body>
      <%@ include file="/WEB-INF/views/include/head.jsp" %>
      <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
      
         <div class="mainSearch">
            <div class="mainSearchLeft">
               <img src="/resources/index/logo/icon_ball_b.png" />
               <h2>포켓몬 도감</h2>
            </div>
            <div class="mainSearchRight">
               <div class="mainSearchRightInputBox">
                  <input id=pokeSearch placeholder="포켓몬 이름 또는 설명 키워드를 입력해주세요." />
                  <button id="searchIndex" onclick="">
                     <img src="/resources/index/logo/search.png" alt="searchBtb" />
                  </button>
               </div>
            </div>
            
         </div>

         <div class="searchMenuBox">
         <div class="searchMenu">
            <form class="searchMenuForm">
               
               <div class="searchMenuLeft">
                  <div class="searchMenuDogam">
                     <p>키</p>
                     <div class="searchMenuDogamInputBox">
                        <input type="text" name="startHeightInput" id="startHeightInput"/>
                        <span>-</span>
                        <input type="text" name="endHeightInput" id="endHeightInput"/>
                     </div>
                  </div>
                  <div class="searchMenuDogam">
                     <p>몸무게</p>
                     <div class="searchMenuDogamInputBox">
                        <input type="text" name="startWeightInput" id="startWeightInput"/>
                        <span>-</span>
                        <input type="text" name="endWeightInput" id="endWeightInput"/>
                     </div>
                  </div>
                  <div class="searchMenuDogam">
                     <p>도감번호</p>
                     <div class="searchMenuDogamInputBox">
                        <input type="text" name="startDogamInput" id="startDogamInput"/>
                        <span>-</span>
                        <input type="text" name="endDogamInput" id="endDogamInput"/>
                     </div>
                  </div>
               </div>
				
										
               <div class="searchMenuRight">
                  <p>타입</p>
                  <div class="searchMenuTypeCheckBox">
                     
                     <c:forEach var="typeList" items="${pokeTypeList}" varStatus="status">
                        <div class="searchMenuTypeCheck">
                        <label for="${typeList.pokeType}">
                              <input type="checkbox" class="searchPoketmonCheckBox" id="${typeList.pokeType}" value="${typeList.pokeType}">
                              <span class="searchMenuTypeImgBox">
                                 <img class="searchMenuTypeImg" style="background: url(/resources/index/poType/${typeList.pokeEnTypeName}.png) no-repeat !important;">
                                 <span>${typeList.pokeTypeName} </span>
                              </span>
                              <span class="searchMenuTypeImgBox">
                                 <img class="searchMenuTypeImg" style="background: url(/resources/index/poType/${typeList.pokeEnTypeName}.png) no-repeat !important;">
                                 <span>${typeList.pokeTypeName} </span>
                              </span>
                              <span class="searchMenuTypeImgBoxSelect">
                                 <img class="searchMenuTypeImgSelect" style="background: url(/resources/index/poType/${typeList.pokeEnTypeName}Select.png) no-repeat !important;">
                              </span>
                              
                        </label>
                        </div>
                     </c:forEach>
                     
                     
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
         <select class="custom-select" id="pokeSortValue">
            <option value="1">도감번호 순서</option>
            <option value="2">도감번호 반대순서</option>
            <option value="3">무거운 순서</option>
            <option value="4">가벼운 순서</option>
            <option value="5">키 큰 순서</option>
            <option value="6">키 작은 순서</option>
         </select>
      </div>

      <div class="clear"></div>

      <div id="mainListBox" class="mainListBox"></div>
   </section>
   
      <div class="loading" style="text-align: center; padding: 10px; width: 200px;">loading</div>
      
      <form id="pokeViewForm" name="pokeViewForm">
         <input name="startDogam" id="startDogam" type="hidden" value=0>
         <input name="endDogam" id="endDogam" type="hidden" value=0>
         <input name="startWeight" id="startWeight" type="hidden" value=0>
         <input name="endWeight" id="endWeight" type="hidden" value=0>
         <input name="startHeight" id="startHeight" type="hidden" value=0>
         <input name="endHeight" id="endHeight" type="hidden" value=0>
         <input name="pokeId" id="pokeId" type="hidden" value="">
      </form>
      <script>
         let page = 1;
         let listStatus = true;
         let listStatusAjax = 0;
      
         $(document).ready(function() {
            
            $("#searchIndex").on("click", function() {
               $("#startDogam").val($("#startDogamInput").val());
               $("#endDogam").val($("#endDogamInput").val());
               $("#startWeight").val($("#startWeightInput").val());
               $("#endWeight").val($("#endWeightInput").val());
               $("#startHeight").val($("#startHeightInput").val());
               $("#endHeight").val($("#endHeightInput").val());
               
               $(".mainListBox").html("");
               
               page = 1;
               
               $(".loading").show();
               
            });
            
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

            $(".searchPoketmonCheckBox").on("click", function(e) {
               //e.stopPropagation();
               const isCheck = $(this).prop("checked");
               const isCheck1 = $(e.target).prop("checked");
               const chVal = $(this).val();
               console.log("노말" + isCheck + " val : " + chVal);
               console.log(e.target);
               
               //console.log($(".searchMenuTypeImgBox")[0]);
               //console.log($(".searchMenuTypeImgBox"));
               
               const test = $(e.target);
               
               const parentElement = $(this).closest(".searchMenuTypeCheck");
               //console.log(parentElement);
               
               const parentElement1 = test.closest(".searchMenuTypeCheck");
               //console.log(parentElement1);

               if(isCheck) {
                  parentElement.find(".searchMenuTypeImgBox").hide();
                  parentElement.find(".searchMenuTypeImgSelect").css({
                      "display": "block",
                      "background-size": "contain",   // !important는 사용하지 않음
                      "background-position": "center",
                      "background-repeat": "no-repeat"
                  });
               } else {
                  parentElement.find(".searchMenuTypeImgBox").show();
                  parentElement.find(".searchMenuTypeImgSelect").css("display", "none");
               }
            });
            
            
            
            $(".loading").on("click", function() {
               fn_loadData();
            });
            
         });
         
         function fn_loadData() {
            
            $.ajax({
              type: "POST",
              url: "/mainList",
              data: {
                 page: page,
                 startDogam: $("#startDogam").val(),
                   endDogam: $("#endDogam").val(),
                   startWeight: $("#startWeight").val(),
                   endWeight: $("#endWeight").val(),
                   startHeight: $("#startHeight").val(),
                   endHeight: $("#endHeight").val(),
                   pokeSortValue: $("#pokeSortValue").val(),
                   pokeSearch: $("#pokeSearch").val(),
                   typeList: $(".searchPoketmonCheckBox:checked").map(function() {
                       return this.value;
                   }).get()
              },
              datatype: "JSON",
              success: function(res) {
                 if(res.code == 1) {
                    $(".loading").hide();
                 }
                                  
                 let listResult = res.data.list;
                 
                 listResult.forEach(item =>  {
                      $(".mainListBox").append("<div class='mainListItemBox'>" +
                                 "<a href='javascript:fn_pkView(" + item.pokeId + ")'>" +
                        "<div class='mainListItemImg'>" +
                           "<img src='/resources/images/poketmonImg/" + item.pokeImg  + "'>" +
                        "</div>" +
                        "<div class='mainListItemTitle'>" +
                           "<span>No." + item.pokeId + "</span>" +
                           "<h3>" + item.pokeName + "</h3>" +
                        "</div>" +
                        "<div class='mainListItemTypeBox'>" +
                           "<div class='grassType' style='background-color: "+ item.pokeTypeColorFirst + ";'>" + item.pokeTypenameFirst + "</div>" +
                           (item.pokeTypeSecond != 0 ?
                           "<div class='poisonType' style='background-color: "+ item.pokeTypeColorSecond + ";'>" + item.pokeTypenameSecond + "</div>"
                           : "<div></div>") +
                        "</div>" +
                     "</a>" +
                  "</div>")
                   });
                 page++;
              },
            error: function(xhr, status, error) {
               
            }
            });

         }
         
         const loading = $(".loading");
         
         if(listStatus) {
             // Intersection Observer 생성
            const observer = new IntersectionObserver(
              (entries, observer) => {
                entries.forEach(entry => {
                  if (entry.isIntersecting) {
                    fn_loadData(); // 데이터 로드
                    console.log(loading);
                    console.log(loading[0]);
                  }
                });
              },
              {
                root: null, // 브라우저의 viewport가 root가 됨
                rootMargin: "0px",
                threshold: 0.5 // 요소의 100%가 보일 때 트리거
              }
            );
             
             
   
            // loading 요소를 관찰 대상으로 설정
            observer.observe(loading[0]);
            
         }

         
         
         //fn_loadData();
         
         function fn_pkView(pokeId) {
            document.pokeViewForm.pokeId.value = pokeId;
            document.pokeViewForm.action = "/indexView";
            document.pokeViewForm.submit();
         }

      </script>
      
      
      
   </body>
</html>
