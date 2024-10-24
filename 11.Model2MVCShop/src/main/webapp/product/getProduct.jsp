<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang ="ko">
<head>
	<meta charset = "EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css">
	
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

	
	<!--  CSS -->
	    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	$(function(){
		$( "button:contains('확인')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('확인')" ).html() );
			self.location="/product/listProduct?menu=manage"
		});
		
		$( "button:contains('이전')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('확인')" ).html() );
			self.location="/product/listProduct?menu=${menu}"
		});
		
		$( "button:contains('구매')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('확인')" ).html() );
			self.location="/purchase/addPurchase?prodNo=${product.prodNo}"
		});
	});
	</script>
	

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">
		
		<div class="page-header">
			<h3 class="text-info">상품 상세조회</h3>
		</div>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>상 품 명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
			 <div class="col-xs-8 col-md-4">
         		 <img src="../images/uploadFiles/${product.fileName}" class="featurette-image img-responsive center-block" alt="Generic placeholder image">
        	</div>
        </div>
        
        <hr/>
        
        <div class="row">
        	<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
        	<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
        </div>
        
        <hr/>
        
        <div class="row">
        	<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
        	<div class="col-xs-8 col-md-4">${product.manuDate}</div>
        </div>
        
        <hr/>
        
        <div class="row">
        	<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
        	<div class="col-xs-8 col-md-4">${product.price}</div>
        </div>
        
        <hr/>
        
        <div class="row">
        	<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
        	<div class="col-xs-8 col-md-4">${product.regDate}</div>
        </div>    
        
        <hr/>
        
        <div class="row">
        	<div class="col-md-12 text-center">
        		<c:if test = 	"${!empty sessionScope.user && menu.equals('search')}">
        			<button type="button" class="btn btn-primary">구매</button>
        		</c:if>
        		<c:if test = "${menu.equals('ok') }">
					<button type="button" class="btn btn-primary">확인</button>
				</c:if>
				<c:if test = "${!menu.equals('ok') }">
					<button type="button" class="btn btn-primary">이전</button>
				</c:if>
        	</div>
        </div>
		
	</div>
	
</body>
</html>