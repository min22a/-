<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="icon" href="/resources/img/favicon.png">
    <title>로그인 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

  </head>

  <body>

    <div class="container">

      <form class="form-signin" action="/login" method="post">
        <div class="col text-center">
        <div class="alert alert-info" role="alert">로그인 하세요</div></div>
        <label for="inputEmail" class="sr-only mt-3">ID</label>
        <input type="text" id="ID" class="form-control" name="ID"
        placeholder="ID" autocomplete="off">
        <label for="inputPassword" class="sr-only mt-3">Password</label>
        <input type="password" id="PW" name="PW"
        class="form-control" placeholder="Password" autocomplete="off">
        <div class="checkbox mt-3">
          <label>
            <input type="checkbox" name="remember-me">기억하기
          </label>
        </div>
        <div class="col text-center">
       <button class="btn btn-lg btn-outline-info btn-block mt-5" id="loginform" 
       type="button">회원가입</button>
       <button class="btn btn-lg btn-primary btn-block mt-5" id="send" type="submit">로그인</button>
       <button class="btn btn-lg btn-outline-warning btn-block mt-5"  id="golist"
       type="button">목록으로가기</button>
        </div>
        
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      </form>

    </div> <!-- /container -->


    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script>
    $("#loginform").on("click",function(e){
    	self.location="/login/regi";
    });
    $("#golist").on("click",function(e){
    	self.location="/board/list";
    });
   
    
    </script>
  </body>
</html>
