<%@page import="com.min.utility.VisitorCount"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html lang="en">
  <head>
  <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
  <link rel="icon" href="/resources/img/favicon.png">
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	  <!-- csrf -->
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
      <title>민게시판</title>
   
  </head>
  <body>
    <nav class="navbar navbar-expand-lg  navbar-dark bg-dark opacity-75">
      <div class="container-fluid">
        <a class="navbar-brand" href="/board/list">민게시판</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-5 mb-lg-0">
           	<li class="nav-item">
              <a class="nav-link ms-4" href="/login/regi">회원가입</a>
			</li>
            <li class="nav-item">
              <a class="nav-link ms-4" href="/board/list">목록</a>
            </li>
            <li class="nav-item">
              <a class="nav-link ms-4" href="/board/register">글 쓰기</a>
            </li>
           <sec:authorize access="isAnonymous()">
            <li class="nav-item">
              <a class="nav-link ms-4" href="/login/form">로그인</a>
            </li>
           </sec:authorize>
           <sec:authorize access="isAuthenticated()">
           	 <li class="nav-item">
              <a class="nav-link ms-4" id="logout" href="">로그아웃</a>
            </li>
           </sec:authorize>
           <sec:authorize access="isAuthenticated()">
           	 <li class="nav-item">
              <a class="nav-link ms-4"  href="/memberinfo">회원정보</a>
            </li>
           </sec:authorize>
           <sec:authorize access="hasRole('ROLE_ADMIN')">
           	 <li class="nav-item">
              <a class="nav-link ms-4"  href="/admin">관리자페이지</a>
            </li>
           </sec:authorize>
          </ul>
          <form class="d-flex " id="searchForm" action="/board/search" method="get">
            <select class="form-select  bg-dark bg-opacity-50 text-white md-2" name='type' aria-label="Default select example">
  				<option value="T">제목</option>
  				<option value="TC">제목+내용</option>
  				<option value="C">내용</option>
  				<option value="U">작성자</option>
			</select>
            <input class="form-control me-2 bg-dark bg-opacity-70 text-white" type="text" placeholder="검색" 
             name="keyword" id="keyword" aria-label="Search">
            <button class="btn btn-outline-success" type="submit">Search</button>
          </form>
        </div>
      </div>
    </nav>

    <div class="a me-3" style="float: right;" >접속자수 : <%=VisitorCount.getvisitorcount()%></div>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    
   	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  	
  	<script type="text/javascript">
  	 $(".btn-outline-success").on("click", function(e) {
  		 if(document.getElementById("keyword").value == "" ) {
  			  alert("검색어를 입력하세요");
  			  return false;
  			 }
     });
  
  	 $("#logout").on("click", function(e){
  	    var csrfHeaderName = "${_csrf.headerName}";
  	    var csrfTokenValue = "${_csrf.token}";
  	    
  		$.ajax({
			type : "POST",
			url : "/Logout",
			beforeSend: function(xhr){
	            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
	        },
			success : function() {
				
				location.replace("/board/list")
				
				alert("로그아웃 되었습니다");
			}
		})
  	})
  	 
  	</script>
  </body>
</html>