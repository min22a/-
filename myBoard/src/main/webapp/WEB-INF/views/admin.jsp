<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="header/header.jsp"%>

<table class="table mt-3 bg-light bg-opacity-75">
<thead>
  <tr>
  	<th scope="col"><input class="form-check-inputall" type="checkbox" 
  	value="" id='flexCheckDefaultall'
  	onclick="location.href='/admin?pageNum=${pager.search.pageNum}&amount=${pager.search.amount}&sort=num'"/>번호</th>
  	<th scope="col">제목</th>
  	<th scope="col">작성자</th>
 	<th scope="col" onclick="location.href='/admin?pageNum=${pager.search.pageNum}&amount=${pager.search.amount}&sort=regdate'">작성일</th>
 	<th scope="col" onclick="location.href='/admin?pageNum=${pager.search.pageNum}&amount=${pager.search.amount}&sort=updatedate'">수정일</th>
  	<th scope="col" onclick="location.href='/admin?pageNum=${pager.search.pageNum}&amount=${pager.search.amount}&sort=viewcount'">조회수</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${list}" var="board">
  
  <tr>
  <th scope="row"><input class="form-check-input" type="checkbox" 
  value='<c:out value="${board.num}" />' id='flexCheckDefault <c:out value="${board.num}" />'/><c:out value="${board.num}" /></th>
  <td ><a class="link-info" id='numtage' href='<c:out value="${board.num}"/>'>
  <c:out value="${board.title}" /><b>[<c:out value="${board.replycnt}"/>]</b></a></td>
  <td style="width:  11.33%"><c:out value="${board.user}" /></td>
  <td style="width:  20.33%"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
  value="${board.regdate}"/></td>
  <td style="width: 20.66%"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
  value="${board.updatedate}"/></td>
  <td style="width: 10.33%"><c:out value="${board.viewcnt}" /></td>
  </tr>
  </c:forEach>
  </tbody>
</table>
		<button type="button" id="remove" class="btn btn-danger me-4" 
		onclick="boardDelete()">삭제</button>
		
<div class="pull-right ">
      <ul class="pagination justify-content-center mt-5">
        <c:if test="${pager.prev}">
        	<li class="paginate_button previous">
          		<a href="${pager.start-1}" class="page-link page-link bg-dark text-white bg-opacity-25">이전</a>
        	</li>
        </c:if>
        
        <c:forEach var="num" begin="${pager.start}" end="${pager.last}">
     		<li class="paginate_button ${pager.search.pageNum == num ? "active":""}">
     		<a class="page-link page-link bg-dark text-white bg-opacity-25 " href="${num}"> ${num} </a>
     		</li>
        </c:forEach>
        
        <c:if test="${pager.next}">
        	<li class="paginate_button next">
          		<a href="${pager.last+1}" class="page-link bg-dark text-white bg-opacity-25">다음</a>
        	</li>
        </c:if>
      </ul>
</div>
    
    <form id="actionForm" action="/admin" method="get">
    	<input type="hidden" name="pageNum" value="${pager.search.pageNum}">
    	<input type="hidden" name="amount" value="${pager.search.amount}">
    	<input type="hidden" name="sort" value="${pager.search.sort}">
    </form>
    
    
    <script>
    var actionForm = $("#actionForm");
    
	var csrfHeaderName = "${_csrf.headerName}";
	
	var csrfTokenValue = "${_csrf.token}";
    
    $(".paginate_button a").on("click", function(e) {
		e.preventDefault();
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		
		actionForm.submit();
    });

	$("a#numtage").on("click", function(e){
		
		e.preventDefault();
		
		actionForm.append("<input type='hidden' name='num' value='"+
				$(this).attr("href")+"'>");
					
		actionForm.attr("action","/board/read")
		
		actionForm.submit();
	});
	
	
	$("#flexCheckDefaultall").click(function() {
		if($("#flexCheckDefaultall").is(":checked")){
			
			$(".form-check-input").prop("checked", true);
		}else { 
			
			$(".form-check-input").prop("checked", false);
		}
	}); //체크박스 전체선택 해제
	
	//일괄삭제
	function boardDelete(){
	
	var boardIdxArray = [];
	
	$(".form-check-input:checked").each(function(){
		boardIdxArray.push($(this).val());
	});
	
	console.log(boardIdxArray);
	
	if(boardIdxArray == ""){
		alert("삭제할 항목을 선택해주세요.");
		return false;
	}
	
	var confirmAlert = confirm('정말로 삭제하시겠습니까?');

	if(confirmAlert){
		
		$.ajax({
	        type : 'POST',
	       	url : '/admindel',
	       	beforeSend: function(xhr){
	            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
	        },
	       	dataType : 'json',
	       	data : JSON.stringify(boardIdxArray),
	       	contentType: 'application/json',
	       	success : function(result) {
				alert("해당글이 정상적으로 삭제되었습니다.");
				location.replace("/admin");
	       },
	       error: function(request, status, error) {
	    	   alert("실패.");
	       }
	   })	
	}
}
	
	
    </script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  </body>
</html>