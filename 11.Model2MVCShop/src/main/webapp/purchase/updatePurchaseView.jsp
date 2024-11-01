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
function fncUpdatePurchase(){
	$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
}

$(function(){
	$( "button.btn.btn-primary" ).on("click" , function() {
			fncUpdatePurchase();
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

$(document).ready(function() {
    var dateValue = $("#divyDate").val(); // yyyy-mm-dd hh:mm:ss 형식
    if (dateValue) {
        var formattedDate = dateValue.split(' ')[0].replace(/-/g, ''); // yyyyMMdd 형식으로 변환
        $("#divyDate").val(formattedDate);
    }
});

</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   	
   		<h1 class="bg-primary text-center">구매정보수정</h1>
   		
   		<form class="form-horizontal" enctype="multipart/form-data">   
   		
	   		<div class="form-group">			
			    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
			    <div class="col-sm-4">
			    	<input type="hidden" class="form-control" id="buyerId" name="buyerId" value="${purchase.buyer.userId}"/>
			       ${purchase.buyer.userId}
			    </div>		    
			 </div>
			 
			<div class="form-group">
			    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
			    <div class="col-sm-4">
			      	<select name="paymentOption" class="form-control"  id="paymentOption" style="width:120px" >
						<option value = "1" ${purchase.paymentOption.equals("1") ? "selected" : "" }>현금구매</option>
						<option value = "2" ${purchase.paymentOption.equals("2") ? "selected" : "" }>신용구매</option>
					</select>
			    </div>
		  </div>
		  
		  <div class="form-group">			
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		   		 <input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}" />
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone}"/>
		    </div>		    
		 </div>
	   		
   		<div class="form-group">			
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}"/>
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest }" />
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="divyDate" name="divyDate" value="${purchase.divyDate }" readonly/>
		    </div>	
		    <div class="col-sm-3">
		      <button type="button" class="btn btn-info">
		      	<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
		      </button>
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
