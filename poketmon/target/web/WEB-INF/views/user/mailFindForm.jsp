<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
        .register-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            background-color: #fff;
            margin-top: 40px;
        }
        .btn-custom {
            background-color: #e60000;
            color: white;
        }
       
    </style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#userName").focus();
	
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
		
		if($.trim($("#userTel").val()).length <= 0)
		{
			alert("사용자 휴대폰 번호를 입력하세요.");
			$("#userTel").val("");
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
				alert("아이디 찾기 중 오류가 발생하였습니다.");
				$("#userName").focus();	
			}
			else
			{
				alert("아이디 찾기 중 알수없는 오류가 발생하였습니다.");
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
        <h2 class="text-center mb-4">이메일 찾기</h2>
        <form action="/register" method="post">
             <div class="form-group">
             
            <div class="form-group">
                <label for="userName">이름</label>
                <input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력해주세요." required>
            </div>
            
             <div class="form-group">
                <label for="userTel">휴대폰 번호</label>
                <input type="tel" class="form-control" id="userTel" name="userTel" placeholder="휴대폰 번호를 입력해주세요." required pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}">
            </div>
          
            <button type="button" class="btn btn-custom btn-block" id="btnMailFind">찾기</button>
        </form>
    </div>
</div>
</body>
</html>


