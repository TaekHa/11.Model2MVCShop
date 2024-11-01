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
   	
   	<h1 class="bg-primary text-center">상 품 구 매</h1>
   	
   	<!-- form Start /////////////////////////////////////-->
	<form class="form-horizontal">
	
		<div class="form-group">			
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-sm-4">
		    	<input type="hidden" name="prodNo" value="${product.prodNo}">
		       ${product.prodNo}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		       ${product.prodName}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		       ${product.prodDetail}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		       ${product.manuDate}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		       ${product.price}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
		    <div class="col-sm-4">
		       ${product.regDate}
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-sm-4">
		    	<input type="hidden" class="form-control" id="buyerId" name="buyerId" value="${user.userId}">
		       ${user.userId}
		    </div>		    
		 </div>
		 
		 <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    <div class="col-sm-4">
		      	<select name="paymentOption" class="form-control"  id="paymentOption" style="width:120px" >
					<option value = "1" selected>현금구매</option>
					<option value = "2">신용구매</option>
				</select>
		    </div>
		  </div>
		  
		  <div class="form-group">			
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		   		 <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="받으시는 분의 이름을 입력해주세요."/>
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="받으시는 분의 연락처를 입력해주세요."/>
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="배송 받을 주소를 입력해주세요."/>
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		    	<input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="요청 사항을 입력해주세요."/>
		    </div>		    
		 </div>
		 
		 <div class="form-group">			
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
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
		      <button type="button" class="btn btn-primary"  >구매</button>
			  <a class="btn btn-primary btn" href="#" role="button">취소</a>
		    </div>
		  </div>
	
		
	</form>
   	
   	</div>

</body>
</html>