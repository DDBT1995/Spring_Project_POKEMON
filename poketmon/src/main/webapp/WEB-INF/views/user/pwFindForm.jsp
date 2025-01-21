<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포켓몬 비밀번호 찾기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
 body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f7f7f7;
            flex-direction: column; /* 세로로 쌓이도록 설정 */
            margin-top: 2rem;
         
        }

        /* 메인 컨테이너 */
        .container {
            width: 25%; /* 화면의 80%를 차지 */
            max-width: 600px; /* 최대 폭 */
            margin-bottom: 2rem;
            
        }

        .input-group {
            margin-bottom: 1rem;
        }

        .input-group input {
            width: 100%;
            height: 60px;
            padding: 15px 20px;
            font-size: 18px;
            border: 1px solid #bbb;
            box-sizing: border-box;
        }

        .login-button {
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

        .login-button span {
            display: block;
            transform: skew(10deg); /* 텍스트를 원래 각도로 */
        }

        .login-button:hover {
            background-color: #333;
        }

        .additional-options {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 1rem;
            font-size: 14px;
            color: #666;
        }

        .additional-options a {
            color: #737373;
            text-decoration: none;
        }

        .additional-options a:hover {
            text-decoration: underline;
        }

        hr {
            border: 0;
            height: 1px;
            background-color: #ddd;
            margin: 20px 0;
        }

        .reg-button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            background-color: #fff;
            color: #000;
            border: 1px solid #bbb;
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .reg-button:hover {
            background-color: #000;
            color: #fff;
        }

        img {
            display: block;
            margin: 0 auto 0px;
            height: auto;
        }
        .navList > li > a{
        	font-weight: bold;
        }
        .btn-custom {
            background-color: #e60000;
            color: white;
        }
       
    </style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

$(document).ready(function(){
let code = "";
	$("#userEmail").focus();
	
	$("#reg-button").on("click", function(){
		location.href = "/user/regForm";
	});
	
	$("#btnPwFind").on("click",function(){
		
		//공백체크
		var emptCheck = /\s/g;
		
		// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
		var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
		
		if($.trim($("#userEmail").val()).length <= 0)
		{
			alert("사용자 이메일을 입력하세요.");
			$("#userEmail").val("");
			$("#userEmail").focus();
			return;
		}
		
		if(emptCheck.test($("#userEmail").val()))	
		{
			alert("사용자 이메일은 공백을 포함할수 없습니다.");
			$("#userEmail").focus();
			return;
		}
		
		if(!fn_validateEmail($("#userEmail").val()))
		{
			alert("사용자 이메일 형식이 올바르지 않습니다.");
			$("#userEmail").focus();
			return;
		}
		
		if($.trim($("#authCode").val()).length <= 0)
		{
			alert("인증번호를 입력하세요");
			$("#authCode").val("");
			$("#authCode").focus();
			return;
		}
		
		if(emptCheck.test($("#authCode").val()))
		{
			alert("사용자 이메일은 공백을 포함할수 없습니다.");
			$("#authCode").focus();
			return;
		}
		
	});	
	
	$("#userEmailCheck").click(function() {
		$.ajax({
			type:"POST",
			url:"/user/pwFindProc",
			data:{
				userEmail:$("#userEmail").val()
			},
			datatype:"JSON",
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response)
			{
				alert($("#userEmail").val());

				alert(response.code);
				if(response.code == 0)
				{
					alert("임시비밀번호 전송 완료.");
					location.href = "";
				}
				else if(response.code == 1)
				{
					alert("임시비밀번호 생성 에러.");
					$("#userEmail").focus();
				}
				else if(response.code == 2)
				{
					alert("임시비밀번호 변경 에러.");
					$("#userEmail").focus();
				}
				else if(response.code == -99)
				{
					alert("정지된 회원입니다.");
					$("#userEmail").focus();
				}
				else if(response.code == 400)
				{
					alert("존재하지 않는 이메일 입니다.");
					$("#userEmail").focus();	
				}
				else if(response.code == 404)
				{
					alert("비밀번호 찾기 중 오류가 발생하였습니다.");
					$("#userEmail").focus();	
				}
				else
				{
					alert("비밀번호 찾기 중 알수없는 오류가 발생하였습니다.");
					$("#userEmail").focus();	
				}
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
		});
	});
	
	
	
    		
    	
});



function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
    <div class="register-container">
        <h2 class="text-center mb-4" style="font-weight: 1000;">비밀번호 찾기</h2>
        <form action="/register" method="post">
            <div class="input-group">
		         <label for="userEmail">이메일 주소</label>
		         <input type="text" id="userEmail" name="userEmail" placeholder="이메일 주소를 입력해주세요." required>
		    </div>
		    	 <button type="button" class="login-button" id="userEmailCheck" name="userEmailCheck"><span>찾기</span></button>
        </form>
    </div>
    
    <hr>
		
    	<button class="reg-button" id="reg-button">아직 회원이 아니신가요?</button>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>


