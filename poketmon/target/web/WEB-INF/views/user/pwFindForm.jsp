<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
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


</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
    <div class="register-container">
        <h2 class="text-center mb-4">비밀번호 찾기</h2>
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
          
            <button type="button" class="btn btn-custom btn-block" id="btn">찾기</button>
        </form>
    </div>
</div>
</body>
</html>


