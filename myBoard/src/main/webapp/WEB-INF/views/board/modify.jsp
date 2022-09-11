<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../header/header.jsp"%>	

    
<form action="/board/modify" method="post" role="form">	
	<input type='hidden' name='pageNum' value='<c:out value="${search.pageNum}"/>'>
    <input type='hidden' name='amount' value='<c:out value="${search.amount}"/>'>
    <input type='hidden' name='num' value='<c:out value="${list.num}"/>'>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    
    
    <div class="col mb-3 mt-4 bg-light text-dark border border-primary border-2">
      <h5 for="exampleFormControlInput1" class="form-label align-baseline ms-3" 
      	style="height:10px; font-size:19px;" >
      	<input class="form-control" style="font-size:19px;" 
      	name="title" id="exampleFormControlTextarea3" 
      value=<c:out value="${list.title}"></c:out>></h5>
      <div class="d-flex flex-row-reverse bd-highlight" readonly="readonly" 
      disabled="disabled" style=" font-size:19px;">
       <span class="span viewcnt me-2"><c:out value="조회수: ${list.viewcnt}" /></span>
       <span class="span repcnt me-2" ><c:out value="댓글수: ${list.replycnt}" /></span>
      </div>
    </div>
    
    <div class="mb-3">
      <label for="exampleFormControlTextarea1" class="form-label ms-3"
      style=" font-size:19px;">내용</label>
      <input class="form-control" style="height:200px;font-size:19px;" id="exampleFormControlTextarea3" 
      name="content" value=<c:out value="${list.content}"></c:out>  rows="3"></textarea>
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
    <div class="input-group input-group-lg mt-3" >
      <span class="input-group-text" id="inputGroup-sizing-lg">업로드파일</span>
      <input type="file" class="form-control" id="uploadFile" multiple="multiple"
      aria-describedby="inputGroupFileAddon04" aria-label="Upload">
    </div>
    
      <label for="exampleFormControlInput1" class="form-label ms-3" style=" font-size:19px;">첨부파일</label>
      <div class="form-control" id="uploadResult" rows="3" 
      style="height:200px;" readonly="readonly">
      <ul>
      </ul>
      </div>
     </div>
    </div>
   
    <div class="col text-center mt-4">
   		<button type="submit" id="submit2" class="btn btn-primary me-4">수정하기</button>
   		<button type="button" id="back" class="btn btn-danger me-4">돌아가기</button>
    </div>
  </form>
 		
 	
    
    <!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  
<script>
$(document).ready(function(e) {
	

	var formobj = $("form")
		
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	
	var maxSize = 5242880;
		
	function checkExtension(fileName, fileSize) { // 파일 체크
		
		if(fileSize >= maxSize){
			alert('파일 사이즈 초과입니다');
			
			return false;
		}
		
		if(regex.test(fileName)){
			alert('해당종류의 파일은 업로드 할 수 없습니다');
			
			return false;
		}
		
		return true;
	}
	
	function showUploadResult(uploadResultArr) {
		if(!uploadResultArr || uploadResultArr.length == 0){return;}
		
		var uploadUL = $("#uploadResult ul");
		
		var str = "";
		
		var csrfHeaderName = "${_csrf.headerName}";
		
		var csrfTokenValue = "${_csrf.token}";
		
		$(uploadResultArr).each(function(i, obj) { // 파일 업로드시 업로드 파일 보여주기
			if(obj.image){
				var fileCallPath = encodeURIComponent(obj.uploadPath+
						"/s_"+obj.uuid+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"
				str += obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"
				str += obj.image+"'><div>";
				str += "<span>"+obj.fileName+"</span>";
				str += "<button type='button' class='btn-close' data-file=\'"
				str += fileCallPath+"\' data-type='image'"
				str += "<i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div></li>";
			}else{
				var fileCallPath = encodeURIComponent(obj.uploadPath+
						"/"+obj.uuid+"_"+obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"
				str += obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"
				str += obj.image+"'><div>";
				str += "<span>"+obj.fileName+"</span>";
				str += "<button type='button' class='btn-close' data-file=\'"
				str += fileCallPath+"\' data-type='file'"
				str += "<i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'>";
				str += "</div></li>";
			}
		})
		
		uploadUL.append(str);
	}
	
	$("input[type='file']").change(function(e) { // 파일 선택시 ajax로 업로드 
		
		var formData = new FormData();
		
		var inputFile = $("input[id='uploadFile']");
		
		var files = inputFile[0].files;
		
		for(var i = 0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false
			}
			formData.append("uploadFile",files[i]);
		}
		
		$.ajax({
			url:'/uploadAjaxAction',
			processData: false,
			contentType: false,
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			data: formData,
			type:'POST',
			dataType:'json',
			success: function(result) {
				console.log(result);
				showUploadResult(result);
			}
	})
})

		$("button[type='submit']").on("click",function(e){ // 작성버튼
			e.preventDefault();
			
			var str = "";
		
		$("#uploadResult ul li").each(function(i,obj) {
			var jobj = $(obj);
			
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='";
			str += jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='";
			str += jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='";
			str += jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].filetype' value='";
			str += jobj.data("type")+"'>";
		});
	formobj.append(str).submit();
	formobj.submit();
	
	alert('수정 완료');
});
	
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
				str += "' data-type='"+attach.filetype+"'><div>"
				str += "<span>"+attach.fileName+"</span>"
				str += "<button type='button' class='btn-close' data-file=\'"
				str += fileCallPath+"\' data-type='image'"
				str += "<i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div></li>";
			}else{
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"
				str += attach.uuid+"' data-fileName='"+attach.fileName
				str += "' data-type='"+attach.filetype+"'><div>";
				str += "<span>"+attach.fileName+"</span>"
				str += "<button type='button' class='btn-close' data-file=\'"
				str += fileCallPath+"\' data-type='image'"
				str += "<i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'>";
				str += "</div></li>";
			}
		})
		$("#uploadResult ul").html(str);	
	})
	
	$("#uploadResult").on("click", "button", function(e) { //x표시 버튼 클릭시 파일 다시 삭제
	if (confirm("삭제 취소 하시겠습니까?") == true) {
	
		var targetLi = $(this).closest("li");
		
		targetLi.remove();}
})

})
</script>

<script>
	
$(".btn-danger").on("click", function(e) {
		e.preventDefault();
		
		if (confirm("수정을 취소하고 돌아가시겠습니까?") == true) {
			
			self.location ="/board/list?pageNum=${search.pageNum}&amount=${search.amount}";
			
		} else {
			return false;
		}
    });
</script>

  </body>
</html>

