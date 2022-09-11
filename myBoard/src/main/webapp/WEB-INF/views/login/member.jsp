<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@include file="../header/header.jsp"%>

	
 <h1 class="h1 mt-3 text-center text-primary" style="width: 18rem; margin: 0 auto; float: none; margin-bottom: 10px" >가입정보</h1>
 
 <div class="card mt-5 text-center" style="width: 18rem; margin: 0 auto; float: none; margin-bottom: 10px">
  <div class="card-header text-center text-primary">
    ID : <sec:authentication  property="principal.member.ID" />
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item ">user : <sec:authentication property="principal.member.user" /></li>
    <li class="list-group-item"> 가입일 :  <sec:authentication property="principal.member.regdate" /></li>
    <li class="list-group-item" >수정일 : <sec:authentication property="principal.member.updatedate" /></li>
  </ul>
</div>

<div class="col text-center mt-5">
 <button type="button" id="modi2" class="btn btn-primary btn-lg">정보수정</button>
 <button type="button" id="dele2" class="btn btn-danger btn-lg">회원탈퇴</button>
</div>


    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script>
$("#modi2").on("click", function(e){
	
	location.replace("/membermodify");
})

$("#dele2").on("click", function(e){
	   var csrfHeaderName = "${_csrf.headerName}";
		
	   var csrfTokenValue = "${_csrf.token}";
	   
	   if (confirm("회원탈퇴 하시겠습니까?") == true){
		   
		   alert('회원 탈퇴 완료')
		   
		   $.ajax({
				url : "/deleteid",
				type : "post",
				beforeSend: function(xhr){
		            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
		        },
				dataType : "json",
				data : {"ID" : '<sec:authentication  property="principal.member.ID" />'},
				success : location.replace('/board/list')
				})
	   }
	
})

</script>
  	 
  </body>
</html>