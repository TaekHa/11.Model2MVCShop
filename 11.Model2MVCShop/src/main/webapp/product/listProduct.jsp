<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
<script type="text/javascript">
function fncGetList(currentPage){
	$("#currentPage").val(currentPage)
	$("form").attr("method","POST").attr("actrion","product/listProduct?menu=${menu}").submit();
}

//============= "검색"  Event  처리 =============	
$(function() {
	 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	 //$( "button.btn.btn-default" ).on("click" , function() {
	//	fncGetList(1);
	//});
});
  
$(function(){
	$("td:nth-child(2)").on("click", function(){
		self.location="/product/getProduct?prodNo="+$("td:nth-child(6)>input").val()+"&menu=${menu}";
	});
	
	$( "td:nth-child(2)" ).css("color" , "red");
});

$(function(){
	 $( "#sorting" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
			fncGetList(1);
		});
});

$(function(){
	$('select[name="searchCondition"]').on("change", function(){
		fncGetList(1);
	});
});


$(function(){
	$("td:nth-child(6) > i").on("click", function(){
		var prodNo = $(this).parent().children().eq(1).text().trim();
		$.ajax({
			url : "/product/json/getProduct/"+prodNo,
			method : "GET",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			success:function(JSONData, status){
				
// //					Debug...
// 					alert(status);
// //					Debug...
// 					alert("JSONData : \n"+JSONData);
// 					alert(JSONData.regDateString);
					
				var displayValue = "<h6>"
											+"상품번호 : "+JSONData.prodNo+"<br/>"
											+"상 품 명  : "+JSONData.prodName+"<br/>"
											+"이 미 지  : "+JSONData.fileName+"<br/>"
											+"등 록 일  : "+JSONData.regDateString+"<br/>"
											+"</h6>";
				
				$("h6").remove();
				$("#"+prodNo+"").html(displayValue);
			}
		});
		
	});
});

</script>
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class="page-header text-info">
			<c:if test="${menu.equals('manage')}">
				<h3>상품관리</h3>
			</c:if>
			<c:if test="${!menu.equals('manage')}">
				<h3>상품 목록조회</h3>
			</c:if>
	    </div>
	    
	    <div class="row">
	    
	    	<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
			    		
			    
			 	<div class="form-group">
					<select name="searchCondition" class="form-control" style="width:120px">
						<option value = "0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
						<option value = "1" ${!empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
						<option value = "2" ${!empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
					</select>
				</div>
				  
				 <c:if test="${search.searchCondition eq 2}">											
						<div class = form-group>
							<input type="number" name="minPrice" value="${!empty search.minPrice ? search.minPrice:0}">
							~
							<input type="number" name="maxPrice" value="${!empty search.maxPrice ? search.maxPrice:100000000}">
							<input type="hidden" class="form-control" id="searchKeyword" name="searchKeyword" value="">
						</div>				
				</c:if>
				
				<c:if test="${search.searchCondition ne 2}">
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				 </c:if>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <div class="radio">
					 		<label class="radio-inline">
					 			<input type="radio" name="sortingOption" value="ASC" ${empty search.sortingOption || search.sortingOption eq 'ASC' ? "checked" : ""}>오름차순
					 		</label>
							<label class="radio-inline">
								<input type="radio" name="sortingOption" value="DESC" ${!empty search.sortingOption && search.sortingOption eq 'DESC' ? "checked" : ""}>내림차순
							</label>							
						</div>
						
					<button type="button" class="btn btn-default" id="sorting">정렬</button>
						
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		

		
		<table class="table table-hover talbe-striped">
			<thead>
				<tr>
					<th align="center">No</th>
					<th align="left">상품명</th>
					<th align="left">가격</th>
					<th align="left">등록일</th>
					<th align="left">현재상태</th>
				</tr>
			</thead>
			
			<tbody>
				<c:set var="i" value="0" />
				  <c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
					  <td align="center">${ i }</td>
					  <td align="left"  title="Click : 상품정보 확인">${product.prodName}</td>
					  <td align="left">${product.price}</td>
					  <td align="left">${product.regDate}</td>
						<td align="left">
							<c:if test="${empty session.user || session.user.role eq 'user'}">
								<c:choose>
									<c:when test="${empty product.proTranCode || product.proTranCode eq '0'}">
										판매중
									</c:when>
									<c:when test="${product.proTranCode ne '0' }">
										재고없음
									</c:when>
								</c:choose>
							</c:if>
							<c:if test="${!empty session.user && session.user.role ne 'user' }">
								<c:choose>
									<c:when test="${product.proTranCode eq '1'}">
										구매완료
										<c:if test="${menu eq 'manage' }">
											<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo }&tranCode=2&currentPage=${ resultPage.currentPage}">배송하기</a>
										</c:if>
									</c:when>
									<c:when test="${product.proTranCode eq '2'}">
										배송중
									</c:when>
									<c:when test="${product.proTranCode eq '3'}">
										배송완료
									</c:when>
									<c:otherwise>
										판매중
									</c:otherwise>
								</c:choose>
							</c:if>							
		
						</td>
					  <td align="left">
					  	<i class="glyphicon glyphicon-ok" id= "${product.prodNo }"></i>
					  	<input type="hidden" value="${product.prodNo }">
					  </td>
					</tr>
		          </c:forEach>
		          
			</tbody>
			
		</table>		
	
	</div>
	
	<jsp:include page="../common/pageNavigator_new.jsp"/>	

</body>

</html>