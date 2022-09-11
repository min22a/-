<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@include file="../header/header.jsp"%>

	
 <h1 class="h1 mt-3 text-center text-primary"
 style="width: 18rem; margin: 0 auto; float: none; margin-bottom: 10px" >
 <c:out value="${ID.ID }의 가입정보"/></h1>
 
<form class="mt-5" action="/membermodify" method="post">

<div class="form-floating mb-3 mt-3">
  <input type="text" class="form-control" id="user" name="user" placeholder="${ID.user}">
  <label for="floatingInput"><c:out value="${ID.user}" /> </label>
</div>

<div class="form-floating">
  <input type="password" class="form-control" id="PW" name="PW" placeholder="${ID.PW}">
  <label for="floatingPassword" >새비밀번호를 입력하세요</label>
</div>
 
<div class="form-floating mt-3">
  <input type="password" class="form-control" id="PW" name="regdate" placeholder="${ID.regdate}" 
  readonly="readonly" disabled="disabled">
  <label for="floatingPassword" ><c:out value=" 가입일 : ${ID.regdate}" /></label>
</div>

<div class="form-floating mt-3">
  <input type="password" class="form-control" id="PW" name="regdate" placeholder="${ID.updatedate}"
   readonly="readonly" disabled="disabled">
  <label for="floatingPassword" ><c:out value=" 최근 수정일: ${ID.regdate}" /></label>
</div>
 
<input type="hidden" name="${_csrf.parameterName}" id="token" value="${_csrf.token}"/>
<input type="hidden" name="ID" id="ID" value="${ID.ID}"/>

<div class="col text-center mt-5">
 <button type="submit" class="btn btn-primary btn-lg"  >수정</button>
 <button type="button" id="back" class="btn btn-danger btn-lg" >취소</button>
 </div>
 </form>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
$("#back").on("click", function(e){
	
	location.replace("/memberinfo");
})
</script>
  </body>
</html>