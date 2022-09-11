<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../header/header.jsp"%>
    <form class="row g-3 mt-4" action="/login/regi" method="post" autocomplete="off">
      <div class="col-md-6">
        <label for="inputid" class="form-label ms-2">ID</label>
        <input type="text" name="ID" class="form-control" id="inputEmail4">
        <button type="button" id="checkID" 
        class="btn btn-secondary btn-sm">중복검사</button>
      	<input class="form-check-input" type="checkbox" value="" id="2">
      </div>
      <div class="col-md-6">
        <label for="inputemail" class="form-label">USER</label>
        <input type="text"  name="user" class="form-control" id="inputPassword4">
      </div>
      <div class="col-md-6">
        <label for="inputpw" class="form-label ms-2">비밀번호</label>
        <input type="password" name="PW" class="form-control" id="inputPassword2">
      </div>
  
      <div class="col-md-6">
        <label for="inpupwcheck" class="form-label">비밀번호 확인</label>
        <input type="password" class="form-control" id="inputPassword3">
      </div>
      
      <div class="col-12">
        <div class="form-check ms-2">
          <input class="form-check-input" type="checkbox" id="gridCheck">
          <label class="form-check-label" for="gridCheck">
            개인정보제공동의
          </label>
        </div>
      </div>
      <div class="col-12 text-center">
        <button type="submit" id="sub" class="btn btn-lg btn-primary">회원가입</button>
        <button class="btn btn-lg btn-outline-warning btn-block" id="golist"
         type="button">목록으로가기</button>
      </div>
      <input type="hidden" name="${_csrf.parameterName}" id="token"
      value="${_csrf.token}"/>

    </form>

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
    $("#golist").on("click",function(e){
    	self.location="/board/list";
    });
    
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    
  
    console.log(csrfHeaderName);
    console.log(csrfTokenValue);
    
     $("#checkID").on("click",function(e){
     if ($('#inputEmail4').val() == '') {
        alert('이메일을 입력해주세요.')
        return;
      }
     $.ajax({
			url : "/IDcheck",
			type : "post",
			beforeSend: function(xhr){
	            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
	        },
			dataType : "json",
			data : {"ID" : $("#inputEmail4").val()},
			success : function(data){
				if(data == 1){
					alert("중복된 아이디입니다.");
				}else if(data == 0){
					$("#2").prop("checked", true);
					alert("사용가능한 아이디입니다.");
				}
			}	
     	})
     });
    $("#sub").on("click",function(e){
    	var pwd1=$("#inputPassword2").val();
        var pwd2=$("#inputPassword3").val();
        var id=$("#inputEmail4").val();
        var user=$("inputPassword4").val();
       
       if(pwd1 != ""||pwd2 != ""){
       if(pwd1 == pwd2){
        			
       }else if(pwd1 != pwd2){
            	
    	   		alert("비밀번호가 다릅니다 다시확인해주세요");
                
    	   		return false;
       }else if(id == "" || user == ""){
            	
    	   		alert("공백은 사용할수 없습니다");
            	
            	return false;
            }
       }else{
    	   alert("공백은 사용할수 없습니다");
    	   
    	   return false;
       }
       
       if($("#gridCheck").is(":checked") == false){
    	  
    	   alert("개인정보 동의에 동의해주세요");
    	   
    	   return false;
       }
    });
</script>​
</body>
</html>


