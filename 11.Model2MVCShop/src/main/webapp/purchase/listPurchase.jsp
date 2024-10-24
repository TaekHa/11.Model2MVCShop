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
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("from").attr("method","POST").attr("action", "purchase/listPurchase").submit();
	}
	
	$(function(){
		 $( "td.ct_btn01:contains('����')" ).on("click" , function() {
				//Debug..
				//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
				fncGetList(1);
			});
	});
</script>
</head>

<body>

		<jsp:include page="/layout/toolbar.jsp" />
	
		<div class="container">
		
			<div class="page-header text-info">
				<h3>���� ��� ��ȸ</h3>
			</div>
			
			<div class="row">
			
				<div class="col-md-6 text-left">
			    	<p class="text-primary">
			    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
			    	</p>
			    </div>
			    
			    <div class="col-md-6 text-right">
				    <form class="form-inline" name="detailForm">
				    
					 	<div class="radio">
					 		<label class="radio-inline">
					 			<input type="radio" name="sortingOption" value="ASC" ${empty search.sortingOption || search.sortingOption eq 'ASC' ? "checked" : ""}>��������
					 		</label>
							<label class="radio-inline">
								<input type="radio" name="sortingOption" value="DESC" ${!empty search.sortingOption && search.sortingOption eq 'DESC' ? "checked" : ""}>��������
							</label>							
						</div>
						
						<button type="button" class="btn btn-default">����</button>
						
						<input type="hidden" id="currentPage" name="currentPage" value=""/>						
						
					</form>
				</div>
			
			</div>
			
			<table class="table table-hover talbe-striped">
				<thead>
					<tr>
						<th align="center">No</th>
						<th align="left">ȸ��ID</th>
						<th align="left">ȸ����</th>
						<th align="left">��ȭ��ȣ</th>
						<th align="left">�����Ȳ</th>
						<th align="left">��������</th>
					</tr>
				</thead>
				
				<tbody>
		
				  <c:set var="i" value="0" />
				  <c:forEach var="purchase" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
					  <td align="center">${ i }</td>
					  <td align="left" >${purchase.buyerId}</td>
					  <td align="left">${purchase.receiverName}</td>
					  <td align="left">${purchase.receiverPhone}</td>
					  <td align="left">����
						<c:choose>
							<c:when test="${purchase.tranCode eq '1'}">
								���ſϷ�
							</c:when>
							<c:when test="${purchase.tranCode eq '2'}">
								�����
							</c:when>
							<c:when test="${purchase.tranCode eq '3'}">
								��ۿϷ�
							</c:when>
						</c:choose>
					���� �Դϴ�.</td>
					  <td align="left">
					  	<c:if test = "${purchase.tranCode eq '2'}">
					  		<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3&currentPage=${resultPage.currentPage}">���ǵ���</a>
					  	</c:if>
					  </td>
					</tr>
		          </c:forEach>        
		        </tbody>
				
				
			</table>
		
		
		</div>
	
	<jsp:include page="../common/pageNavigator_new.jsp"/>


</body>
</html>