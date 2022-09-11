<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../header/header.jsp"%>

 <form role="form" action="/board/register" method="post">
    <div class="input-group input-group-lg mt-5" >
      <span class="input-group-text" id="inputGroup-sizing-lg">제목</span>
      <input type="text" class="form-control" aria-label="Sizing example input" 
      aria-describedby="inputGroup-sizing-lg" placeholder="제목을 작성하세요" name="title">
    </div>
   	
   <div class="input-group input-group-lg mt-3" >
      <span class="input-group-text" id="inputGroup-sizing-lg">작성자</span>
      <input type="text" class="form-control" aria-label="Sizing example input" 
      aria-describedby="inputGroup-sizing-lg" value='<sec:authentication 
      property='principal.member.user' />' placeholder="제목을 작성하세요" 
      name="user" readonly="readonly">
    </div>
   
    <div class="input-group input-group-lg mt-3" >
      <span class="input-group-text" row="3" id="inputGroup-sizing-lg">내용</span>
      <textarea class="form-control " rows="3" placeholder="내용을 작성하세요" name="content"></textarea>
    </div>

    <div class="input-group input-group-lg mt-3" >
      <span class="input-group-text" id="inputGroup-sizing-lg">업로드파일</span>
      <input type="file" class="form-control" id="uploadFile" multiple="multiple"
      aria-describedby="inputGroupFileAddon04" aria-label="Upload">
    </div>
    
      <div class="uploadResult">
      	<ul>
      		
      	</ul>
      </div>
    
    <div class="col text-center">
    <button type="submit" class="btn btn-primary btn-lg mt-5">작성</button>
    </div>
    
     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
     
    </form>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  
  	<script>
	$(document).ready(function(e) {
		
	var formobj = $("form[role='form']")
		
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	
	var maxSize = 5242880;
	
	var csrfHeaderName = "${_csrf.headerName}";
	
	var csrfTokenValue = "${_csrf.token}";
		
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
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
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

$(".uploadResult").on("click", "button", function(e) { //x표시 버튼 클릭시 파일 다시 삭제
	if (confirm("삭제 취소 하시겠습니까?") == true) {
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");

		
		$.ajax({
			url:'/deleteFile',
			data:{fileName: targetFile, type:type},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			dataType:'text',
			type:'POST',
			success: function(result) {
				alert('삭제 완료');
				targetLi.remove();
				$('#uploadFile').val('');
			}
		})
		
	} else {
		return false;
	}
})
		
		$("button[type='submit']").on("click",function(e){ // 작성버튼
			e.preventDefault();
			
			var str = "";
		
		$(".uploadResult ul li").each(function(i,obj) {
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
	alert('작성완료');
		});
}) 
	</script>
  </body>