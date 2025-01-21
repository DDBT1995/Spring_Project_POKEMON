<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포켓몬 코리아 로그인</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <style>
   		
   		
        body {
            font-family: 'Noto Sans KR', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f7f7f7;
            
        }

        /* 메인 컨테이너 */
        .container {
            width: 25%; /* 화면의 80%를 차지 */
            max-width: 600px; /* 최대 폭 */
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
    </style>
</head>


<script>

$(document).ready(function(){
	
 $("#userEmail").focus();
   
   $("#userEmail").on("keypress", function(e){
      if(e.which == 13)
      {
         fn_loginCheck();
         
        
      }
   });
   
   $("#userPwd").on("keypress", function(e){
      if(e.which == 13)
      {
         fn_loginCheck();
      }
   });
   
   $("#login-button").on("click", function(){
      fn_loginCheck();
   });
	
	$("#reg-button").on("click", function(){
		location.href = "/user/regForm";
	});
});

function fn_loginCheck()
{
   if($.trim($("#userEmail").val()).length <= 0)
   {
      alert("이메일을 입력하세요.");
      $("#userEmail").val("");
      $("#userEmail").focus();
      return;
   }
   
   if(!fn_validateEmail($("#userEmail").val()))
	{
		alert("사용자 이메일 형식이 올바르지 않습니다.");
		$("#userEmail").focus();
		return;
	}
   
   if($.trim($("#userPwd").val()).length <= 0)
   {
      alert("비밀번호를 입력하세요.");
      $("#userPwd").val("");
      $("#userPwd").focus();
      return;
   }   
   
   $.ajax({
	      type:"POST",
	      url:"/user/loginProc",
	      data:{
	         userEmail:$("#userEmail").val(),
	         userPwd:$("#userPwd").val()
	      },
	      datatype:"JSON",
	      beforeSend:function(xhr){
	         xhr.setRequestHeader("AJAX", "true");
	      },
	      success:function(response){
	         if(!icia.common.isEmpty(response))
	         {
	            icia.common.log(response);
	            
	            var code = icia.common.objectValue(response, "code", -500);
	            
	            if(code == 0)
	            {
	               alert("로그인성공");
	               location.href = "/index";
	            }
	            else
	            {	
	            	if(code == -1)
	            	{
	            		alert("비밀번호가 올바르지 않습니다.");
	            		$("#userPwd").focus();
	            	}
	            	else if(code == -99)
	            	{
	            		alert("정지된 사용자 입니다.");
	            		$("#userEmail").focus();
	            	}
	            	else if(code == 404)
	            	{
	            		alert("아이디와 일치하는 사용자 정보가 없습니다.");
	            		$("#userEmail").focus();
	            	}
	            	else if(code == 400)
	            	{
	            		alert("파라미터 값이 올바르지 않습니다.");
	            		$("#userEmail").focus();
	            	}
	            	else
	            	{
	            		alert("오류가 발생하였습니다.(1)");
	            		$("#userEmail").focus();
	            	}
	            }
	         }
	         else
	         {
	            alert("오류가 발생하였습니다.");
	            $("#userEmail").focus();
	         }
	      },
	      complete:function(data)
	      {
	         //응답이 종료되면 실행함(잘 사용하지 않음)
	         icia.common.log(data);
	      },
	      error:function(xhr, status, error)
	      {
	         icia.common.error(error);
	      }
	   });
   
}

function fn_validateEmail(value)
{
   var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
   
   return emailReg.test(value);
}


</script>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
    <div class="container">
        <img src="/resources/user/logo.png" alt="포켓몬 코리아 로고">

       
            <div class="input-group">
                <input type="email" id="userEmail" name="userEmail" placeholder="이메일" required>
            </div>
            <div class="input-group">
                <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호" required>
            </div>
            <button type="button" class="login-button" id="login-button"><span>로그인</span></button>
      
        <div class="additional-options">
            <a href="/user/mailFindForm">아이디 찾기</a>
            <span>|</span>
            <a href="/user/pwFindForm">비밀번호 찾기</a>
        </div>

        <hr>
		
        <button class="reg-button" id="reg-button">아직 회원이 아니신가요?</button>
    </div>
</body>
</html>
