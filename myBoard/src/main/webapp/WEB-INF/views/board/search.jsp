<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../header/header.jsp"%>

<table class="table mt-3">
<thead>
  <tr>
  	<th scope="col">번호</th>
  	<th scope="col">제목</th>
  	<th scope="col">작성자</th>
 	<th scope="col">작성일</th>
 	<th scope="col">수정일</th>
  	<th scope="col">조회수</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${list}" var="board">
  <tr>
  <th scope="row"><c:out value="${board.num}" /></th>
  <td><a class="text-decoration-none" href='<c:out value="${board.num}"/>'>
  <c:out value="${board.title}" /></a></td>
  <td><c:out value="${board.user}" /></td>
  <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
  value="${board.regdate}"/></td>
  <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
  value="${board.updatedate}"/></td>
  <td><c:out value="${board.viewcnt}" /></td>
  </tr>
  </c:forEach>
  </tbody>
</table>

<div class="modal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

 	<form id="actionForm" action="/board/search" method="get">
    	<input type="hidden" name="pageNum" value="${pager.search.pageNum}">
    	<input type="hidden" name="amount" value="${pager.search.amount}">
    </form>
    
    <script>
 
   var actionForm = $("#actionForm");
    
    $(".paginate_button a").on("click", function(e) {
		e.preventDefault();
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		actionForm.submit();
    });
    
	$(".text-decoration-none").on("click", function(e){
		
		e.preventDefault();
		
		actionForm.append("<input type='hidden' name='num' value='"+
				$(this).attr("href")+"'>");
					
		actionForm.attr("action","/board/read")
		
		actionForm.submit();
	});
    </script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  </body>
</html>