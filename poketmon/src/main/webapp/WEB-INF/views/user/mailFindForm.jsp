<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포켓몬 이메일 찾기</title>
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
       
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#userName").focus();
	
	$("#reg-button").on("click", function(){
		location.href = "/user/regForm";
	});
	
	$("#btnMailFind").on("click",function(){
		
		//공백체크
		var emptCheck = /\s/g;
		
		// 영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
		var idPwCheck = /^[a-zA-Z0-9]{4,12}$/;
		
		if($.trim($("#userName").val()).length <= 0)
		{
			alert("사용자 이름을 입력하세요.");
			$("#userName").val("");
			$("#userName").focus();
			return;
		}
		
		if(emptCheck.test($("#userName").val()))	
		{
			alert("사용자 이름은 공백을 포함할수 없습니다.");
			$("#userName").focus();
			return;
		}
		
		
		if($.trim($("#userTel").val()).length <= 0)
		{
			alert("사용자 휴대폰 번호를 입력하세요.");
			$("#userTel").val("");
			$("#userTel").focus();
			return;
		}
		
		if(emptCheck.test($("#userTel").val()))	
		{
			alert("사용자 휴대폰 번호는 공백을 포함할수 없습니다.");
			$("#userTel").focus();
			return;
		}
		
		fn_userMailFind();
		
	});	
});

function fn_userMailFind()
{
	$.ajax({
		type:"POST",
		url:"/user/mailFindProc",
		data:{
			userName:$("#userName").val(),
			userTel:$("#userTel").val()
		},
		datatype:"JSON",
		beforeSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response)
		{
			alert($("#userName").val());
			alert($("#userTel").val());
			var data = icia.common.objectValue(response, "data")
			
			alert(response.code);
			if(response.code == 0)
			{
				alert("이메일을 찾았습니다. 이메일: " + data);
				location.href = "/";
			}
			else if(response.code == -99)
			{
				alert("정지된 회원입니다.");
				$("#userName").focus();
			}
			else if(response.code == 400)
			{
				alert("!!!파라미터 값이 올바르지 않습니다.");
				$("#userName").focus();	
			}
			else if(response.code == 404)
			{
				alert("이메일 찾기 중 오류가 발생하였습니다.");
				$("#userName").focus();	
			}
			else
			{
				alert("이메일 찾기 중 알수없는 오류가 발생하였습니다.");
				$("#userName").focus();	
			}
		},
		error:function(xhr, status, error)
		{
			icia.common.error(error);
		}
	});
}

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
    <div class="register-container">
        <h2 class="text-center mb-4" style="font-weight: 1000;">이메일 찾기</h2>
        <form action="/register" method="post">
		       <div class="input-group">
		         <label for="userName">이름</label>
		         <input type="text" id="userName" name="userName" placeholder="이름을 입력해주세요." required>
		       </div>
	           <div class="input-group">
	           	 <label for="userTel">연락처</label>
	             <input type="text" id="userTel" name="userTel" placeholder="연락처를 입력해주세요." required>
	           </div>
            
             <button type="button" class="login-button" id="btnMailFind"><span>찾기</span></button>
        </form>
    </div>
    <hr>
		
    	<button class="reg-button" id="reg-button">아직 회원이 아니신가요?</button>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>


