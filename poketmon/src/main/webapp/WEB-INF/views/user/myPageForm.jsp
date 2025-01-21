<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포켓몬 마이페이지</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column; /* 세로로 쌓이도록 설정 */
            align-items: center; /* 중앙 정렬 */
            min-height: 100vh; /* 화면 전체 높이 사용 */
        }

        .container {
            width: 700px;
            background-color: white;

            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            padding: 40px;
            box-sizing: border-box;
            margin-top: 40px; /* 필요한 경우 조정 */
        }

        .unique-header {
            font-size: 24px;
            margin-bottom: 20px;
            border-bottom: 3px solid #f1c40f;
            padding-bottom: 10px;
            font-weight:1000;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input {
            width: 97%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .info-table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        .info-table th,
        .info-table td {
            padding: 10px;
        }

        .info-table th {
            width: 120px;
            background-color: #f9f9f9;
            text-align: left;
            font-weight: normal;
        }

        .address-group {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-bottom: 10px;
            margin-top: 20px;
        }

        .address-group input {
            flex: 1;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .address-btn {
            background-color: #f1c40f;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 8px;
            transition: background-color 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .address-btn:hover {
            background-color: #2980b9;
        }

        .address-input {
            margin-bottom: 10px;
        }

        .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .btn {
            width: 48%;
            padding: 15px;
            font-size: 18px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
            font-weight: bold;
            cursor: pointer;
            transform: skew(-15deg); /* 평행사변형 */
        }

        .btn-update {
            background-color: #e74c3c;
            color: white;
            box-shadow: 0 4px 8px rgba(231, 76, 60, 0.3);
        }

        .btn-update:hover {
            background-color: #c0392b;
        }

        .btn-delete {
            background-color: #7f8c8d;
            color: white;
            box-shadow: 0 4px 8px rgba(127, 140, 141, 0.3);
        }

        .btn-delete:hover {
            background-color: #636e72;
        }

        footer {
            width: 100%; /* 전체 너비 사용 */
            background-color: #1a1a1a;
            color: #fff;
            padding: 20px;
            font-family: Arial, sans-serif;
            text-align: center; /* 중앙 정렬 */
            position: relative; /* 필요 시 추가 */
            left: 0; /* 필요 시 추가 */
        }
    </style>
    
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>    
<script type="text/javascript">

var result = {}; // 전역 변수 선언
    
$(document).ready(function(){
	
	// 모든 공백 체크 정규식
	var emptCheck = /\s/g;
	// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
	var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
	// 숫자 5자리 정규식
	var postCodeCheck = /^[0-9]{5}$/;
	// 휴대폰 번호 정규식
	var telPattern = /^(\d{3}-\d{3,4}-\d{4})$/;
	
	$("#userPwd1").focus();
	
	$("#btnUserWd").on("click",function(){
		location.href="/user/withdrawForm";
	});
	
	$("#btnAddr").on("click",function(){
		daumPost()
	});
	
	$("#btnUserUpdate").on("click", function(){
		
		if($.trim($("#userPwd1").val()).length <= 0)
		{
			  alert("비밀번호를 입력하세요.");
			  $("#userPwd1").val("");
			  $("#userPwd1").focus();
			  return;
		}

		if(!idPwCheck.test($("#userPwd1").val()) && !emptCheck.test($("#userPwd1").val()))
		{
			  alert("비밀번호는 영문 대소문자와 숫자로 4~12자리입니다.");
			  $("#userPwd1").focus();
			  return;
		}
		
		if($.trim($("#userPwd2").val()).length <= 0)
		{
			  alert("비밀번호를 확인하세요.");
			  $("#userPwd2").val("");
			  $("#userPwd2").focus();
			  return;
		}

		if($("#userPwd1").val() != $("#userPwd2").val())
		{
			alert("비밀번호가 일치하지 않습니다.");
			$("#userPwd2").focus();
			return;
		}
		
		$("#userPwd").val($("#userPwd1").val())
		
		if($.trim($("#userNickname").val()).length <= 0)
		{
			alert("사용자 별명을 입력하세요.");
		 	$("#userNickname").val("");
		 	$("#userNickname").focus();
		 	return;
		}
		
		if($.trim($("#userTel").val()).length <= 0)
		{
			alert("사용자 별명을 입력하세요.");
		 	$("#userNickname").val("");
		 	$("#userNickname").focus();
		 	return;
		}
		
		if($.trim($("#userTel").val()).length <= 0)
		{
			alert("사용자 연락처를 입력하세요.");
			$("#userTel").val("");
			$("#userTel").focus();
			return;
		}
		
		if(!telPattern.test($("#userTel").val()))
		{
			  alert("연락처는 010-000-0000 \n  010-0000-0000 입니다.");
			  $("#userPwd1").focus();
			  return;
		}
		
		if($.trim($("#userPostcode").val()).length <= 0)
		{
			alert("사용자 우편번호를 입력하세요.");
			$("#userPostcode").val("");
			$("#userPostcode").focus();
			return;
		}
		
		if(!postCodeCheck.test($("#userPostcode").val()))
		{
			  alert("우편번호는 숫자로 5자리입니다.");
			  $("#userPostcode").focus();
			  return;
		}

		if($.trim($("#userAddr").val()).length <= 0)
		{
			alert("사용자 기본주소를 입력하세요.");
			$("#userAddr").val("");
			$("#userAddr").focus();
			return;
		}
		
		if($.trim($("#userDetailaddr").val()).length <= 0)
		{
			alert("사용자 상세주소를 입력하세요.");
			$("#userDetailaddr").val("");
			$("#userDetailaddr").focus();
			return;
		}
		
		// 하이픈 제거 함수 실행
        result = removeHyphens();
        console.log("전화번호: " + result.userTel);  // 결과를 콘솔에 출력
        alert("전화번호: " + result.userTel);  // 결과를 알림으로 표시
		
		
		  $.ajax({
			  type:"POST",
			  url:"/user/myPageProc",
			  data:{
				userEmail:$("#userEmail").val(),
				userPwd:$("#userPwd").val(),
				userNickname:$("#userNickname").val(),
				userTel: result.userTel,
				userPostcode:$("#userPostcode").val(),
				userAddr:$("#userAddr").val(),
				userDetailaddr:$("#userDetailaddr").val(),
			  },
			  datatype:"JSON",
			  beforeSend:function(xhr)
			  {
				  xhr.setRequestHeader("AJAX","true")
			  },
			  success:function(response)
			  {
				if(response.code == 0)
				{
					alert("회원 정보가 수정되었습니다.");
					location.href = "/user/myPageForm";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#userPwd1").focus();
				}
				else if(response.code == 404)
				{
					alert("회원정보가 존재하지 않습니다.");
					location.href = "/";
				}
				else if(response.code == 410)
				{
					alert("로그인을 먼저하세요.");
					location.href = "/";
				}
				else if(response.code == 430)
				{
					alert("아이디 정보가 다릅니다.");
					location.href = "/";
				}
				else if(response.code == 500)
				{
					alert("회원정보 수정 중 오류가 발생하였습니다.");
					$("#userPwd1").focus();
				}
				else
				{
					alert("회원정보 수정 중 오류발생");
					$("#userPwd1").focus();
				}
			  },
			  error:function(xhr, status, error)
			  {
				  icia.common.error(error);
			  }

		  });
	});
	
});

//주소 선택 펑션
function daumPost()
{
    new daum.Postcode
    ({
        oncomplete: function(data) 
        {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
            
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            
            $("#userPostcode").val(data.zonecode)
            $("#userAddr").val(addr)
            $("#userDetailaddr").attr("readonly", false);
            $("#userDetailaddr").focus();
        }
    }).open();
}

//하이픈 제거 펑션
function removeHyphens() {
    // jQuery로 input 요소의 값 가져오기 (id가 userTel)
    var userTelInput = $("#userTel").val();
   
    
    // 하이픈(-) 제거
    var cleanedTel = userTelInput.replace(/-/g, "");
   
    
    // 결과를 반환 (필요에 따라 객체로 반환)
    return {
        userTel: cleanedTel
    };
}
</script>


</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
    <div class="container">
        <h1 class="unique-header">마이페이지</h1>

        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" id="userEmail" name="userEmail" value="${user.userEmail}" readonly>
        </div>

        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="userPwd1" name="userPwd1" placeholder="비밀번호를 입력해주세요.">
        </div>
        
         <div class="form-group">
            <label for="confirmPassword">비밀번호 확인</label>
            <input type="password" id="userPwd2" name="userPwd2" placeholder="비밀번호 확인">
        </div>
        
        <div class="form-group">
            <label for="userNickname">닉네임</label>
            <input type="text" id="userNickname" name="userNickname" placeholder="별명을 입력해주세요.">
        </div>
        
         <div class="form-group">
            <label for="userTel">연락처</label>
            <input type="text" id="userTel"  name="userTel" placeholder="연락처를 입력해주세요.">
        </div>

       

        <table class="info-table">
            <tr>
                <th>이름</th>
                <td>${user.userName}</td>
            </tr>
            <tr>
                <th>가입일</th>
                <td>${user.userRegDate}</td>
            </tr>
            <tr>
                <th>생일</th>
                <td>${user.userBirth}</td>
            </tr>
        </table>

        <div class="address-group">
            <input type="text" placeholder="우편번호" id="userPostcode" name="userPostcode" value="" placeholder="우편번호를 입력해주세요.">
            <button class="address-btn" id="btnAddr">주소찾기</button>
        </div>
         <div class="address-group">
          <input type="text" class="address-input" placeholder="주소" id="userAddr" name="userAddr" value="" placeholder="주소를 입력해주세요.">     
        </div>
        <div class="address-group">
          <input type="text" class="address-input" placeholder="상세 주소" id="userDetailaddr" name="userDetailaddr" value="" placeholder="상세주소를 입력해주세요.">    
        </div>
      
        <div class="actions">
            <button class="btn btn-delete" id="btnUserWd">회원탈퇴</button>
            <button class="btn btn-update" id="btnUserUpdate">수정</button>
        </div>
   		</div>
   		<input type="hidden" id="userPwd" name="userPwd" value="" />
   		<%@ include file="/WEB-INF/views/include/footer.jsp" %>
   			
</body>

</html>
