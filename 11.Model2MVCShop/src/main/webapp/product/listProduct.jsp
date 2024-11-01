<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
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

//============= "�˻�"  Event  ó�� =============	
$(function() {
	 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	 //$( "button.btn.btn-default" ).on("click" , function() {
	//	fncGetList(1);
	//});
});
  
$(function(){
	$("td[name='sellProd']").on("click", function(){
		self.location="/product/getProduct?prodNo="+$("td:nth-child(6)>input").val()+"&menu=${menu}";
	});
	
	$( "td[name='sellProd']" ).css("color" , "red");
});

$(function(){
	 $( "#sorting" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
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
											+"��ǰ��ȣ : "+JSONData.prodNo+"<br/>"
											+"�� ǰ ��  : "+JSONData.prodName+"<br/>"
											+"�� �� ��  : "+JSONData.fileName+"<br/>"
											+"�� �� ��  : "+JSONData.regDateString+"<br/>"
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
				<h3>��ǰ����</h3>
			</c:if>
			<c:if test="${!menu.equals('manage')}">
				<h3>��ǰ �����ȸ</h3>
			</c:if>
	    </div>
	    
	    <div class="row">
	    
	    	<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
			    		
			    
			 	<div class="form-group">
					<select name="searchCondition" class="form-control" style="width:120px">
						<option value = "0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value = "1" ${!empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value = "2" ${!empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
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
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				 </c:if>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <div class="radio">
					 		<label class="radio-inline">
					 			<input type="radio" name="sortingOption" value="ASC" ${empty search.sortingOption || search.sortingOption eq 'ASC' ? "checked" : ""}>��������
					 		</label>
							<label class="radio-inline">
								<input type="radio" name="sortingOption" value="DESC" ${!empty search.sortingOption && search.sortingOption eq 'DESC' ? "checked" : ""}>��������
							</label>							
						</div>
						
					<button type="button" class="btn btn-default" id="sorting">����</button>
						
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		

		
		<table class="table table-hover talbe-striped">
			<thead>
				<tr>
					<th align="center">No</th>
					<th align="left">��ǰ��</th>
					<th align="left">����</th>
					<th align="left">�����</th>
					<th align="left">�������</th>
				</tr>
			</thead>
			
			<tbody>
				<c:set var="i" value="0" />
				  <c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
					  <td align="center">${ i }</td>
						  <c:if test="${empty product.proTranCode || product.proTranCode eq '0' }">
						  	<td align="left"  title="Click : ��ǰ���� Ȯ��" name="sellProd">${product.prodName}</td>
						  </c:if>
						  <c:if test="${!empty product.proTranCode && product.proTranCode ne '0' }">
						  	<td align="left"  title="Click : ��ǰ���� Ȯ��" name="noProd">${product.prodName}</td>
						  </c:if>	  
					  
					  <td align="left">${product.price}</td>
					  <td align="left">${product.regDate}</td>
						<td align="left">
							<c:if test="${empty session.user || session.user.role eq 'user'}">
								<c:choose>
									<c:when test="${empty product.proTranCode || product.proTranCode eq '0'}">
										�Ǹ���
									</c:when>
									<c:when test="${product.proTranCode ne '0' }">
										������
									</c:when>
								</c:choose>
							</c:if>
							<c:if test="${!empty session.user && session.user.role ne 'user' }">
								<c:choose>
									<c:when test="${product.proTranCode eq '1'}">
										���ſϷ�
										<c:if test="${menu eq 'manage' }">
											<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo }&tranCode=2&currentPage=${ resultPage.currentPage}">����ϱ�</a>
										</c:if>
									</c:when>
									<c:when test="${product.proTranCode eq '2'}">
										�����
									</c:when>
									<c:when test="${product.proTranCode eq '3'}">
										��ۿϷ�
									</c:when>
									<c:otherwise>
										�Ǹ���
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