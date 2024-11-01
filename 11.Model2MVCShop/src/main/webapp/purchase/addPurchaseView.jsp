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

function fncAddPurchase() {
	$("form").attr("method","POST").attr("action", "/purchase/addPurchase").submit();
}

$(function(){
	$( "button.btn.btn-primary" ).on("click" , function() {
			fncAddPurchase();
		});

	$("a[href='#' ]").on("click" , function() {
		history.go(-1);
	});
});

$(function(){
	$("button.btn.btn-info").on("click", function(){
		show_calendar('divyDate', $('#divyDate').val());
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
   	
   	<!-- form Start /////////////////////////////////////-->
	<form class="form-horizontal">
	
		<div class="form-group">			
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
		    <div class="col-sm-4">
		    	<input type="hidden" name="prodNo" value="${product.prodNo}">
		       ${product.prodNo}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		       ${product.prodName}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		       ${product.prodDetail}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		       ${product.manuDate}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		       ${product.price}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
		    <div class="col-sm-4">
		       ${product.regDate}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
		    <div class="col-sm-4">
		    	<input type="hidden" class="form-control" id="buyerId" name="buyerId" value="${user.userId}">
		       ${user.userId}
		    </div>		    
		 </div>
		 
		 <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		    <div class="col-sm-4">
		      	<select name="paymentOption" class="form-control"  id="paymentOption" style="width:120px" >
					<option value = "1" selected>���ݱ���</option>
					<option value = "2">�ſ뱸��</option>
				</select>
		    </div>
		  </div>
		  
		  <div class="form-group">			
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    <div class="col-sm-4">
		   		 <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="�����ô� ���� �̸��� �Է����ּ���."/>
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="�����ô� ���� ����ó�� �Է����ּ���."/>
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="��� ���� �ּҸ� �Է����ּ���."/>
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="��û ������ �Է����ּ���."/>
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="YYYY-MM-DD" readonly/>
		    </div>	
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-info">
		      	<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
		      </button>
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