<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
            padding-top : 50px;
        }
    </style>

<script type="text/javascript" src="../javascript/calendar.js"></script>
<script type="text/javascript">

function fncUpdateProduct(){
	//Form 유효성 검증
//  	var name = document.detailForm.prodName.value;
// 	var detail = document.detailForm.prodDetail.value;
// 	var manuDate = document.detailForm.manuDate.value;
// 	var price = document.detailForm.price.value;

	var name = $("input[name=prodName]").val();
	var detail = $("input[name=prodDetail]").val();
	var manuDate = $("input[name=manuDate]").val();
	var price = $("input[name=price]").val();

	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}
		
// 	document.detailForm.action='/product/updateProduct';
// 	document.detailForm.submit();

	$("form").attr("method", "POST").attr("action", "/product/updateProduct").submit();
}

$(function(){
	$("button.btn.btn-primary").on("click",function(){
		fncUpdateProduct();
	})

	$("a[href='#']").on("click",function(){
		history.go(-1);
	})
});

$(function() {
    // 파일 선택 시 미리보기 업데이트
    $('#fileName').on('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#img-preview').attr('src', e.target.result); // 새로운 파일로 미리보기 변경
            }
            reader.readAsDataURL(file); // 파일을 읽어서 base64로 변환
        }
    });

    // 파일 삭제 버튼 클릭 시
    $('#deleteFile').on('click', function() {
        $('#img-preview').attr('src', ''); // 미리보기 이미지를 삭제
        $('#fileName').val(''); // 파일 input 초기화
    });
});

</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   	
   	   	<h1 class="bg-primary text-center">상 품 수 정</h1>
   		
   		<form class="form-horizontal" enctype="multipart/form-data">   		
   		
   			<input type="hidden" class="form-control" id="prodNo" name="prodNo" value="${product.prodNo }">
   			
	   		<div class="form-group">
			    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName }">
			    </div>
			 </div>
			 
			 <div class="form-group">
			    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail }">
			    </div>
			 </div>
			 
			 <div class="form-group">
			    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}"  readonly>
			    </div>
			    <div class="col-sm-3">
			      <button type="button" class="btn btn-info">
			      	<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
			      </button>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="price" name="price" value="${product.price}">
			    </div>
			  </div>
			  
	        <div class="form-group">
	            <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상품 이미지</label>
	            <div class="col-sm-4">
	                <!-- 이미지 미리보기 -->
	                <img id="img-preview" class="img-preview" src="../images/uploadFiles/${product.fileName}" alt="상품 이미지 미리보기">
	                <input type="file" class="form-control" id="file" name="file">
	            </div>
	            <div class="col-sm-3">
	                <button type="button" class="btn btn-danger" id="deleteFile">파일 삭제</button>
	            </div>
	        </div>
	        
	       <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수정</button>
			  <a class="btn btn-primary btn" href="#" role="button">취소</a>
		    </div>
		  </div>
   			
   		</form>
   		
   	
   	</div>

</body>
</html>
