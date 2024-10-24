<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
	//Form ��ȿ�� ����
//  	var name = document.detailForm.prodName.value;
// 	var detail = document.detailForm.prodDetail.value;
// 	var manuDate = document.detailForm.manuDate.value;
// 	var price = document.detailForm.price.value;

	var name = $("input[name=prodName]").val();
	var detail = $("input[name=prodDetail]").val();
	var manuDate = $("input[name=manuDate]").val();
	var price = $("input[name=price]").val();

	if(name == null || name.length<1){
		alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
		return;
	}
	if(price == null || price.length<1){
		alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
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
    // ���� ���� �� �̸����� ������Ʈ
    $('#fileName').on('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#img-preview').attr('src', e.target.result); // ���ο� ���Ϸ� �̸����� ����
            }
            reader.readAsDataURL(file); // ������ �о base64�� ��ȯ
        }
    });

    // ���� ���� ��ư Ŭ�� ��
    $('#deleteFile').on('click', function() {
        $('#img-preview').attr('src', ''); // �̸����� �̹����� ����
        $('#fileName').val(''); // ���� input �ʱ�ȭ
    });
});

</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   	
   	   	<h1 class="bg-primary text-center">�� ǰ �� ��</h1>
   		
   		<form class="form-horizontal" enctype="multipart/form-data">   		
   		
   			<input type="hidden" class="form-control" id="prodNo" name="prodNo" value="${product.prodNo }">
   			
	   		<div class="form-group">
			    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName }">
			    </div>
			 </div>
			 
			 <div class="form-group">
			    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail }">
			    </div>
			 </div>
			 
			 <div class="form-group">
			    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
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
			    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="price" name="price" value="${product.price}">
			    </div>
			  </div>
			  
	        <div class="form-group">
	            <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ �̹���</label>
	            <div class="col-sm-4">
	                <!-- �̹��� �̸����� -->
	                <img id="img-preview" class="img-preview" src="../images/uploadFiles/${product.fileName}" alt="��ǰ �̹��� �̸�����">
	                <input type="file" class="form-control" id="file" name="file">
	            </div>
	            <div class="col-sm-3">
	                <button type="button" class="btn btn-danger" id="deleteFile">���� ����</button>
	            </div>
	        </div>
	        
	       <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >����</button>
			  <a class="btn btn-primary btn" href="#" role="button">���</a>
		    </div>
		  </div>
   			
   		</form>
   		
   	
   	</div>

</body>
</html>
