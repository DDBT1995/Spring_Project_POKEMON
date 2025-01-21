<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
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
            margin-top: 200px;
        }
        .btn-custom {
            background-color: #e60000;
            color: white;
        }
       
    </style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

var result = {}; // 전역 변수 선언
var resultAddr = "";

$(document).ready(function() {
	
	$("#userEmail").focus();
	
	

	$("#btn").on("click",function(){
		//공백체크
		var emptCheck = /\s/g;
		
		//영문 대소문자, 숫자로만 이루어진 4~12자리 정규식
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
		
		if($.trim($("#userPwd1").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요");
			$("#userPwd1").val("");
			$("#userPwd1").focus();
			return;
		}
		
		if(!idPwCheck.test($("#userPwd1").val()))
		{
			alert("비밀번호는 영문대소문자 숫자로 4~12자리로만 입력가능합니다.");
			$("#userPwd2").val("");
			$("#userPwd2").focus();
			return;
		}
		
		if($.trim($("#userPwd2").val()).length <= 0)
		{
			alert("비밀번호확인을 입력하세요.");
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
		
		$("#userPwd").val($("#userPwd1").val());
		
		if($.trim($("#userName").val()).length <= 0)
		{
			alert("사용자 이름을 입력하세요.");
			$("#userName").val("");
			$("#userName").focus();
			return;
		}
		if($.trim($("#userNickname").val()).length <= 0)
		{
			alert("사용자 별명을 입력하세요.");
			$("#userNickname").val("");
			$("#userNickname").focus();
			return;
		}
		
		if($.trim($("#userTel").val()).length <= 0)
		{
			alert("사용자 휴대폰 번호를 입력하세요.");
			$("#userTel").val("");
			$("#userTel").focus();
			return;
		}
		
		if($.trim($("#userBirth").val()).length <= 0)
		{
			alert("사용자 생년월일을 입력하세요.");
			$("#userBirth").val("");
			$("#userBirth").focus();
			return;
		}
		
		
		if($.trim($("#userPostcode").val()).length <= 0)
		{
			alert("사용자 우편번호를 입력하세요.");
			$("#userPostcode").val("");
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
		
		

		// 하이픈 제거 함수 실행 예제
        result = removeHyphens();
        console.log("전화번호: " + result.userTel);  // 결과를 콘솔에 출력
        console.log("생년월일: " + result.userBirth);  // 결과를 콘솔에 출력
        alert("전화번호: " + result.userTel + "\n생년월일: " + result.userBirth);  // 결과를 알림으로 표시
	   

		// 아아디 중복체크 aJax
		$.ajax({
			type:"POST",
			url:"/user/idCheck",
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
				if(response.code == 0)
				{
					alert("중복메일 아님. 회원가입 가능합니다.");
					fn_userReg();
				}
				else if(response.code == 100)
				{
					alert("중복메일 입니다.");
					$("#userEmail").focus();
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#userEmail").focus();
				}
				else
				{
					alert("오류가 발생하였습니다.");
					$("#userEmail").focus();
				}
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
			
			
			
		});
		
	});
	
	$("#btnAddr").on("click",function(){
		daumPost()
	});
	
	//인증하기 버튼을 눌렀을 때 동작
	
	//인증하기 버튼을 눌렀을 때 동작
	$("#userEmailCheck").click(function() {
    	const email = $("#userEmail").val(); //사용자가 입력한 이메일 값 얻어오기
    		
    	//Ajax로 전송
        $.ajax({
        	url : '/EmailAuth',
        	data : {
        		email : email
        	},
        	type : 'POST',
        	dataType : 'json',
        	success : function(result) {
        		console.log("result : " + result);
        		$("#authCode").attr("disabled", false);
        		code = result;
        		alert("인증 코드가 입력하신 이메일로 전송 되었습니다.");
       		}
        }); //End Ajax
    });
});


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

function fn_userReg()
{
	$.ajax({
		type:"POST",
		url:"/user/regProc",
		data:{
			userEmail: $("#userEmail").val(),
            userPwd: $("#userPwd").val(),
            userName: $("#userName").val(),
            userNickname: $("#userNickname").val(),
            userTel: result.userTel,
            userBirth: result.userBirth,
            userAddr: $("#userAddr").val(),
            userPostcode: $("#userPostcode").val(),
            userDetailaddr: $("#userDetailaddr").val()
			
		},
		datatype:"JSON",
		beforeSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response)
		{
			if(response.code == 0)
			{
				alert("회원가입이 되었습니다.");
				location.href = "/";
			}
			else if(response.code == 100)
			{
				alert("회원 아이디가 중복되었습니다.");
				$("#userEmail").focus();
			}
			else if(response.code == 400)
			{
				alert("파라미터 값이 올바르지 않습니다.");
				$("#userEmail").focus();	
			}
			else if(response.code == 500)
			{
				alert("회원 가입 중 오류가 발생하였습니다.");
				$("#userEmail").focus();	
			}
			else
			{
				alert("회원 가입 중 알수없는 오류가 발생하였습니다.");
				$("#userEmail").focus();	
			}
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

function removeHyphens() {
    // jQuery로 input 요소의 값 가져오기 (id가 number와 birth인 요소)
    var userTelInput = $("#userTel").val();
    var userBirthInput = $("#userBirth").val();
    
    // 하이픈(-) 제거
    var cleanedTel = userTelInput.replace(/-/g, "");
    var cleanedBirth = userBirthInput.replace(/-/g, "");
    
    // 결과를 반환 (필요에 따라 객체로 반환)
    return {
        userTel: cleanedTel,
        userBirth: cleanedBirth
    };
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
    <div class="register-container">
        <h2 class="text-center mb-4">회원가입</h2>
        <form action="/register" method="post">
             <div class="form-group">
                <label for="userEmail">이메일 주소</label>
                <div class="input-group">
                    <input type="email" class="form-control" id="userEmail" name="userEmail" placeholder="이메일 주소를 입력해주세요." required>
                    <div class="input-group-append">
                        <button type="button" class="btn btn-secondary" name="userEmailCheck" id="userEmailCheck">인증</button>
                    </div>
           
                </div>
            </div>
           		<div>
                 <input class="form-control" placeholder="인증 코드 6자리를 입력해주세요." maxlength="6" disabled="disabled" name="authCode" id="authCode" type="text" autofocus>
            	</div>
            <div class="form-group">
                <label for="userPwd1">비밀번호</label>
                <input type="password" class="form-control" id="userPwd1" name="userPwd1" placeholder="8-20자의 비밀번호를 입력해주세요." required>
                <small class="form-text text-muted">비밀번호는 영문대소문자 숫자로 4~12자리로 입력해주세요.</small>
            </div>
            <div class="form-group">
                <label for="userPwd2">비밀번호 확인</label>
                <input type="password" class="form-control" id="userPwd2" name="userPwd2" placeholder="비밀번호를 다시 입력해주세요." required>
            </div>
            <div class="form-group">
                <label for="userName">이름</label>
                <input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력해주세요." required>
            </div>
             <div class="form-group">
                <label for="userNickname">별명</label>
                <input type="text" class="form-control" id="userNickname" name="userNickname" placeholder="별명을 입력해주세요." required>
            </div>
             <div class="form-group">
                <label for="userTel">휴대폰 번호</label>
                <input type="tel" class="form-control" id="userTel" name="userTel" placeholder="휴대폰 번호를 입력해주세요." required pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}">
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="userBirth">생년월일</label>
                    <input type="date" class="form-control" id="userBirth" name="userBirth" required>
                </div>            
            </div>
            <div class="form-group">
                <label for="userPostcode">우편번호</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="userPostcode" name="userPostcode" placeholder="우편번호를 입력해주세요." required>
                    <div class="input-group-append">
                        <button type="button" class="btn btn-secondary" id="btnAddr">주소찾기</button>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="userAddr">기본주소</label>
                <input type="text" class="form-control" id=userAddr name="userAddr" placeholder="기본주소를 입력해주세요." required>
            </div>
            <div class="form-group">
                <label for="userDetailaddr">상세주소</label>
                <input type="text" class="form-control" id="userDetailaddr" name="userDetailaddr" placeholder="상세주소를 입력해주세요.">
            </div>
            <input type="hidden" id="userPwd" name="userPwd" value="" />
            <button type="button" class="btn btn-custom btn-block" id="btn">가입</button>
        </form>
    </div>
</div>
</body>
</html>


