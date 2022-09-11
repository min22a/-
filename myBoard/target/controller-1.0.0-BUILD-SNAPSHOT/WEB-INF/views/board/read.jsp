<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@include file="../header/header.jsp"%>	

    
	<form role="form" id="form">
    <div class="col mb-3 mt-4 bg-light text-dark border border-primary border-2">
      <h5 for="exampleFormControlInput1" class="form-label align-baseline ms-3" 
      	style="height:10px; font-size:19px;" ><c:out value="제목  |  ${list.title}" /></h5>
      <div class="d-flex flex-row-reverse bd-highlight" style=" font-size:19px;">
       <span class="span viewcnt me-2"><c:out value="조회수: ${list.viewcnt}" /></span>
       <span class="span repcnt me-2"><c:out value="댓글수: ${list.replycnt}" /></span>
      </div>
    </div>
    
    <div class="mb-3">
      <label for="exampleFormControlTextarea1" class="form-label ms-3"
      style=" font-size:19px;">내용</label>
      <input class="form-control" style="height:200px;font-size:19px;" id="exampleFormControlTextarea3" 
      value=<c:out value="${list.content}"></c:out> readonly="readonly" rows="3"></textarea>
    </div>
    
    <div class="mb-3">
      <label for="exampleFormControlInput1" class="form-label ms-3" style=" font-size:19px;">작성자</label>
      <input type="text" class="form-control" id="exampleFormControlInput4" 
      value=<c:out value="${list.user}"></c:out> readonly="readonly" disabled="disabled">
    </div>
    
    <div class="mb-3">
      <label for="exampleFormControlInput1" class="form-label ms-3" style=" font-size:19px;">작성일</label>
      <input type="text"  class="form-control" id="exampleFormControlInput5" 
      value="<fmt:formatDate value="${list.regdate}" pattern = "yyyy-MM-dd HH:mm:ss"/>" 
      readonly="readonly" disabled="disabled">
    </div>
    
      <div class="mb-3">
      <label for="exampleFormControlInput1" class="form-label ms-3" style=" font-size:19px;">수정일</label>
      <input type="text" class="form-control" id="exampleFormControlInput6" 
      value="<fmt:formatDate value="${list.updatedate}" pattern = "yyyy-MM-dd HH:mm:ss"/>" 
      readonly="readonly" disabled="disabled">
    </div>
    
    <div class="mb-3">
      <label for="exampleFormControlInput1" class="form-label ms-3" style=" font-size:19px;">첨부파일</label>
      <div class="form-control" id="uploadResult" rows="3" 
      style="height:200px;" readonly="readonly">
      <ul>
      </ul>
      </div>
     </div>
    </div>
    </form>
   
<div class="card">
  <div class="card-header" style=" font-size:19px;">
   댓글
  </div>
  <div class="card-body">
  	<ul class="list-group">
  		<li class="list-group-item" data-repnum='12'>
  		 <div>
  		 	<div class="header">
  		 	 <strong class="primary-font">user00</strong>
  		 	 <small class="pull-right text-muted"> 2022-08-25</small>
  		 	</div>
  		 	<p>good</p>
  		 </div>
  		</li>
  	</ul>	
  </div>
  </div>

<div class="card-footer ">

</div>

<div class="card-body" id='1'>
  <form class="form-horizontal">
    <div class="row">
      <div class="form-group col-sm-8">
        <input class="form-control input-sm" id="reply" type="text" placeholder="댓글 입력...">
      </div>
      <div class="form-group col-sm-2">
        <input class="form-control input-sm" id="replyer" type="text"  readonly="readonly"
        placeholder='user'>
      </div>
      <div class="form-group col-sm-2">
        <button type="button" class="btn btn-primary btn-sm btn-block replyAddBtn" id="register">
       <i class='fa fa-save'></i>작성 </button>
      </div>
    </div>	
  </form>	
</div>
 
    
    <div class="col text-center mt-4">
    <sec:authentication property="principal" var="userinfo"/>
    <sec:authorize access="isAuthenticated()">
    <c:if test="${userinfo.member.user eq list.user or fn:contains(userinfo.member.authlist,'ROLE_ADMIN')}">
    <button type="button"  id="modify21" class="btn btn-primary me-4">수정</button>
    <button type="button" id="remove" class="btn btn-danger me-4">삭제</button>
    </c:if>
    </sec:authorize>
    <button type="button" id= "list" class="btn btn-secondary me-4">목록</button>
    </div>
    

    
   	<form id='operForm' action="/board/modfiy" method="get">
    <input type='hidden' id='num' name='num' value='<c:out value="${list.num}"/>'>
    <input type='hidden' name='pageNum' value='<c:out value="${search.pageNum}"/>'>
    <input type='hidden' name='amount' value='<c:out value="${search.amount}"/>'>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
    
<script>
$(document).ready(function() {
		//첨부파일 표시
		var num = '<c:out value="${list.num}"/>';
		
		$.getJSON("/board/getAttachList", {num:num}, function(arr) {
			
			console.dir(arr);
			
			var str = "";
			
			$(arr).each(function(i,attach) {
				if(attach.filetype){
					var fileCallPath = encodeURIComponent(attach.uploadPath+
							"/s_"+attach.uuid+"_"+attach.fileName);
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"
					str += attach.uuid+"' data-fileName='"+attach.fileName
					str += "' data-type='"+attach.filetype+"'><div>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div></li>";
				}else{
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"
					str += attach.uuid+"' data-fileName='"+attach.fileName
					str += "' data-type='"+attach.filetype+"'><div>";
					str += "<span>"+attach.fileName+"</span><br/>"
					str += "<img src='/resources/img/attach.png'>";
					str += "</div></li>";
				}
			})
			$("#uploadResult ul").html(str);	
	})
	

	
	$("#uploadResult").on("click", "li", function(e) { //클릭시 다운로드 
		var liOjb = $(this);
		
		var path = encodeURIComponent(liOjb.data("path")+"/"+liOjb.data("uuid")+"_"
				+liOjb.data("filename"));
		if (confirm("첨부파일을 다운로드 하시겠습니까?") == true){
			self.location = "/download?fileName="+path;
			return true;
		} else{
			return false;
		}
	})
}) 
</script>
 

<script type="text/javascript" src="/resources/js/reply.js"></script>    
<script type="text/javascript" >
 $(document).ready(function() {
	 
	var numvalue = '<c:out value="${list.num}"/>';
	
	var replyUL = $(".list-group");
	
	var today = new Date();
	
	showList(1);
	
	var csrfHeaderName = "${_csrf.headerName}";
	
	var csrfTokenValue = "${_csrf.token}";
	
	var replyer = null;
	
	<sec:authorize access="isAuthenticated()">
	
	replyer = '<sec:authentication property="principal.member.user"/>'
	
	auth  = '<sec:authentication property="authorities"/>'
	
	</sec:authorize>
	
	$(document).ajaxSend(function(e,xhr,options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	//댓글 출력
	function showList(page) {
		replyService.getList({num:numvalue, page: page||1}, function(replyCnt,list) {
			
	
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str="";
			
			if(list == null || list.length == 0){
				replyUL.html("");
				
				return;
			}
			
			for(var i=0, len=list.length || 0; i<len; i++){
				
				
				var todayvalue = new Date(list[i].replydate)
				
				var updatevale1 = new Date(list[i].updatedate)
				
				var upgap = today.getTime() - updatevale1.getTime();

				var gap = today.getTime() - todayvalue.getTime();
				
				
				
				str += "<li class='list-group-item'>";
				
				str += "<div class='header'><strong class='primary-font me-3'>"+list[i].replyer+"</strong>";
				
				str += "<small class='pull-right text-muted me-3'>"+
				replyService.time(gap, todayvalue)+"</small>";
				
				str += "<small class='pull-right text-muted me-3'>수정일:"+replyService.time(upgap, updatevale1)+"</small></div>"
				
				str += "<p>"+list[i].reply+"</p>"
				
				str += "<button type='button' class='btn btn-success btn-sm me-3' data-repnum='"+list[i].repnum+"'  data-replyer='"+list[i].replyer+"'>수정하기</button>";
			    str += "<button type='button' class='btn btn-danger btn-sm me-3' id='del1' data-repnum='"+list[i].repnum+"' data-replyer='"+list[i].replyer+"'>삭제하기</button></div>";
			    str += "<div class='card-body"+list[i].repnum+"'  style='display:none'><form class='form-horizontal'><div class='row'>";
			    str += "<div class='form-group col-sm-8'><input class='form-control input-sm' id='reply"+list[i].repnum+"' type='text' value='"+list[i].reply+"'>";
			    str += "</div><div class='form-group col-sm-2'><input class='form-control input-sm' id='replyer' type='text' placeholder='작성자' value='"+list[i].replyer+"' readonly>";
			    str += "</div><div class='form-group col-sm-2'><button type='button' class='btn btn-primary btn-sm btn-block replyAddBtn' id='modi2'>";
			    str += "<i class='fa fa-save'></i>작성 </button>";
			    str += "<button type='button' class='btn btn-danger btn-sm btn-block' id='danger2'><i class='fa fa-save1'></i>취소"
			    str += "</div></div></form></div>";
			}
			replyUL.html(str);
			
			showReplyPage(replyCnt);
		})
	}
	//댓글 등록	
	document.querySelector('#register').addEventListener("click", function(e) {
		var reply = {
				reply : $("#reply").val(),
				replyer : replyer,
				num : numvalue
		};
		
		replyService.add(reply, function(result) {
			alert(result);
			showList(pageNum);
		})
	},false)
	//댓글수정
	$(".list-group").on("click",".btn-success",function(e){
		var repnum = $(this).data("repnum");
		var originalreplyer = $(this).data("replyer");
		
		if(originalreplyer != replyer && auth.indexOf("MEMBER") != -1){
			alert('본인이 작성한 댓글이 아닙니다')
			return;
			}else{
				if (confirm("게시글을 수정하시겠습니까?") == true) {
					
					$(".card-body"+repnum).show();
				
					$(document).on("click","#modi2", function(e) {
						var replyaa = $("#reply"+repnum).val();
						
						var reply2 = {
								repnum : repnum,
								reply : replyaa,
								num : numvalue
						};
						
						replyService.update(reply2, function(result) {
							console.log(reply2)
							alert(result);
							$(".card-body"+repnum).hide();
							showList(pageNum);
						})
					})
					
				}else{
					return false;
				}
			}

		$(document).on("click","#danger2", function(e) {
			$(".card-body"+repnum).hide();
		})
	})
	// 댓글삭제
		$(".list-group").on("click","#del1", function(e) {
			var originalreplyer = $(this).data("replyer");
			
			console.log(auth);
			
			
			if(confirm("'삭제하시겠습니까?'") == true){
				
				if(originalreplyer != replyer && auth.indexOf("MEMBER") != -1){
					alert('본인이 작성한 댓글이 아닙니다')
					return;
				}else{
					
					var repnum = $(this).data("repnum");
					
					console.log(repnum)
					
					replyService.remove(repnum, function(result) {
						
						alert(result);
						showList(pageNum);
					})
				}
			}
			else{
				return false;
			}
		})
	//댓글 페이징 처리
	var pageNum = 1;
	var replyPageFooter = $(".card-footer");
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum/10.0)*10;
		var startNum = endNum - 9;
		
		var prev = startNum !=1;
		var next = false;
		
		if(endNum * 10 >= replyCnt){
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt){
			next = true;
		}
		
		var str = "<ul class='pagination pull-right>";
		
		if(prev){
			str += "<li class='page-item'><a class='page-link' id='prevbtn' href='";
			
			str += (startNum-1)+"'>이전</a></li>";
		}
		
		for(var i = startNum; i<=endNum; i++){
			var active = pageNum == i? "active":"";
			
			str += "<li class='page-item "+ active+"'><a class='page-link' href='";
			
			str += i+"'>"+i+"</a></li>";
		}
		
		if(next){
			str += "<li class='page-item'><a class='page-link' href='";
			
			str += (endNum +1)+"'>다음</a></li>";
		}
		
		str += "</ul></li>";
		
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click","li a", function(e) {
		e.preventDefault();
		
		var targetPageNum = $(this).attr("href");
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	})
	
	replyPageFooter.on("click","#prevbtn", function(e) {
		e.preventDefault();
		
		var targetPageNum = $(this).attr("href");
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	})
})
</script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  </body>
  <script>
	   
   var csrfHeaderName = "${_csrf.headerName}";
	
   var csrfTokenValue = "${_csrf.token}";
 	
   var formObj = $("#form");
    
	document.querySelector('#list').addEventListener("click", function(e) {
		self.location = `/board/list?pageNum=${search.pageNum}&amount=${search.amount}`;
	},false)
	
	document.querySelector('#modify21').addEventListener("click", function(e) {
		self.location = `/board/modify?pageNum=${search.pageNum}&amount=${search.amount}&num=${list.num}`;
	},false)
	
	document.querySelector('#remove').addEventListener("click", function(e) {
		e.preventDefault();
		   
		if (confirm("게시글을 삭제하시겠습니까?") == true) {
			
			alert("게시글이 삭제되었습니다.");
			
			$.ajax({
				url : "/board/remove",
				type : "post",
				beforeSend: function(xhr){
		            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
		        },
				dataType : "json",
				data : {"num" : $("#num").val()},
				success : location.replace('/board/list')
				})
				
		} else {
			return false;
		}
	},false)
</script>
</html>

