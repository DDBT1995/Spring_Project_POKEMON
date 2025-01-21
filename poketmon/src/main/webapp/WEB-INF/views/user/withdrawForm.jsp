<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
 <title>포켓몬 회원탈퇴</title>
<style>        
.register-container {
    max-width: 600px;
    margin: 50px auto;
    padding: 30px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 0px;
    background-color: #fff;
}

.btn-custom {
    background-color: #e60000;
    color: white;
}
      
#btnDel {
   height: 60px;
   padding: 1rem;
   border-radius: 0px;
   transform: skew(-20deg); /* 평행사변형 */
   font-size: 20px;
   font-weight: bold;
   text-transform: none;
  }
  
#btnDel p {
   display: block;
   transform: skew(20deg); /* 텍스트를 원래 각도로 */
}
      
hr {
   border: 0;
   height: 1px;
   background-color: #ddd;
   margin: 20px 0;
}

.form-control {
   height: 50px;
   border-radius: 0px;
}

.btn-secondary {
   border-radius: 0px;
}
</style>

<script>
$(document).ready(function(){   
   $("#btnDel").on("click",function(){   
      //비밀번호 입력체크
      if($.trim($("#userPwd").val()).length <= 0)
      {
         alert("비밀번호를 입력하세요.");
         $("#userPwd").val("");
         $("#userPwd").focus();
         return;
      }
      
      //회원탈퇴 aJax
      $.ajax({
    	  type:"POST",
	      url:"/user/withdrawProc",
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
	               alert("회원탈퇴 성공");
	               location.href = "/index";
	            }
	            else
	            {	
	            	if(code == -1)
	            	{
	            		alert("비밀번호가 올바르지 않습니다.");
	            		$("#userPwd").focus();
	            	}
	            	else if(code == 1)
	            	{
	            		alert("회원탈퇴중 오류 발생.");
	            		$("#userPwd").focus();
	            	}
	            	else if(code == -99)
	            	{
	            		alert("정지된 사용자 입니다.");
	            		$("#userEmail").focus();
	            	}
	            	else if(code == 404)
	            	{
	            		alert("이메일과 일치하는 사용자 정보가 없습니다.");
	            		$("#userEmail").focus();
	            	}
	            	else if(code == 400)
	            	{
	            		alert("파라미터 값이 올바르지 않습니다.");
	            		$("#userEmail").focus();
	            	}
	            	else
	            	{
	            		alert("오류가 발생하였습니다. (코드 오류)");
	            		$("#userEmail").focus();
	            	}
	            }
	         }
	         else
	         {
	            alert("오류가 발생하였습니다. (response 오류)");
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
   });   
});
</script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<div class="container">
    <div class="register-container">
        <h2 class="text-center mb-4"><b>회원탈퇴</b></h2>
        <form method="get">
            <div class="form-group">
                <label for="email">이메일 주소</label>
                <input type="text" class="form-control" id="userEmail" name="userEmail" value="${user.userEmail}" placeholder="이메일 주소를 입력해주세요." readonly/>
            <small id="userEmailChk"></small>
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" class="form-control" id="userPwd" name="userPwd" value="" placeholder="비밀번호를 입력해주세요." />           
            </div>
            
            <button type="button" id="btnDel" class="btn btn-custom btn-block"><p>탈퇴하기</p></button><br />
      </form>
   </div>
</div>
 <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>