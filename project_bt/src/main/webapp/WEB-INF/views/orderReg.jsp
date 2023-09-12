<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/> 
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/apv_order.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<style>
.item_results span {
	text-align:center;
}

#employee_results{
	max-height:200px;
	overflow:auto;
}

.item_results {
   width: 100%;
   max-height:150px;
   overflow-y: auto;
}
#emptyBox {
	height:100px;
}
</style>

<div class="container mt-5">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">발주 입력</h1>
    </div>
    <form method="post" id="frm01" action="${path}/insertOrder">
    <div class="card border-left-primary shadow h-100 py-2">
        <div class="card-body">
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="date">발주 일자:</label>
                    <input type="date" class="form-control dateInput" id="start" name="start" onkeydown="return false">
                </div>
                <div class="form-group col-md-6">
                    <label for="deliveryDate">납기 일자:</label>
                    <input type="date" class="form-control dateInput" id="end" name="end" onkeydown="return false">
                </div>
            </div>
            <div class="form-row">
                <div class="form-group col-md-6">
				    <label for="personInCharge">담당자:</label>
				    <div class="dropdown" id="employeeDropdown">
				    	<input type="hidden" name="employee_num">
				        <input type="text" class="form-control" id="employee_name" name="employee_name" placeholder="담당자를 입력해주세요" data-toggle="dropdown" autocomplete="off">
				        <div class="dropdown-menu w-50" id="employee_results" aria-labelledby="employee_name">
				            <div class="d-flex justify-content-between px-3 py-1 bg-light border-bottom">
				                <span style="font-size:18px;">담당자명</span>
				                <span style="font-size:18px;">매장명</span>
				            </div>
				            <div id="searchResults"></div>
				        </div>
				    </div>
				</div>
                <div class="form-group col-md-6">
                    <label for="store">매장:</label>
                    <input type="text" class="form-control" id="store_name" readonly>
                </div>
            </div>
            <div class="mt-1 text-right">
                <button type="button" class="btn btn-success" onclick="addRow()">행 추가</button>
                <button type="button" class="btn btn-warning" onclick="delRow()">행 삭제</button>
            </div>
			<table class="table table-bordered mt-3" id="orderTable">
			    <thead class="thead-light text-center">
			        <tr>
			            <th>품목코드</th>
			            <th>품목명</th>
			            <th>수량</th>
			            <th>판매가</th>
			        </tr>
			    </thead>
			    <tbody id="orderRow">
			        <tr>
			            <td class="text-center"><input type="text" class="form-control product_num" name="product_num" readonly></td>
			            <td class="text-center dropdown">
			            	<input type="text" class="form-control item_name" name="item_name" data-toggle="dropdown" autocomplete="off">
			            	<div class="dropdown-menu item_results" aria-labelledby="item_name">
					            <div class="d-flex justify-content-between px-3 py-1 bg-light border-bottom">
					                <span style="font-size:18px;">브랜드</span>
					                <span style="font-size:18px;">품목명</span>
					            </div>
					            <div class="prdResults"></div>
				        	</div>
			            </td>
			            <td><input type="number" class="form-control text-right order_count" name="order_count"></td>
			            <td><input type="text" class="form-control text-right sale_price" data-price="" readonly></td>
			        </tr>
			    </tbody>
			</table>
			<div id="emptyBox"></div>
            <div class="mt-3 text-right">
                <button type="button" id="orderRegBtn" class="btn btn-primary">발주 신청</button>
                <button type="button" class="btn btn-secondary" onclick="frmReset()">다시 작성</button>
            </div>
        </div>
    </div>
    </form>
</div>
<script>
$(document).ready(function() {
	var msg = "${msg}"
	if(msg != ''){
		alert(msg)		
	}
	
	$.validator.setDefaults({
	    onkeyup: false,
	    onclick: false,
	    onfocusout: false,
	    showErrors: function(errorMap,errorList){
	        if(this.numberOfInvalids()){ // 에러가 있으면
	            alert(errorList[0].message); // 경고창으로 띄움
	        }
	    }
	});
	$("#frm01").validate({
		focusCleanup:true,
		rules: {
			start:{
				required:true
			},
			end:{
				required:true
			},
			employee_name:{
				required:true
			},
			item_name:{
				required:true
			},
			order_count:{
				required:true,
				number:true,
				max:1000
			}
		},
		messages:{
			start:{
				required: "발주일자는 필수 입력입니다."
			},
			end:{
				required: "납기일자는 필수 입력입니다."
			},
			employee_name:{
				required: "담당자명은 필수 선택입니다."
			},
			item_name:{
				required: "품목명은 필수 입력입니다."
			},
			order_count:{
				required: "수량 필수 입력입니다.",
				number: "숫자만 입력해주세요",
				max:"최대 1000개의 수량만 입력 가능합니다."
			}
		}
	})
	
	$("#orderRegBtn").click(function(){
		$('#orderRegBtn').attr('disabled',true);
		if($("#frm01").valid() && confirm("발주 신청하시겠습니까?")){
			$('[name=employee_name]').attr('disabled',true);
            $('[name=item_name]').attr('disabled',true);
            $.LoadingOverlay("show")
            $.ajax({
            	type:"post",
            	url:"insertOrder",
            	data:$("#frm01").serialize(),
            	success:function(data){
            		$.LoadingOverlay("hide")
            		alert(data)
            		location.reload()
            	},
            	error:function(err){
            		console.log(err)
            	}
            })
		}else{
			$('#orderRegBtn').attr('disabled',false);
		}
	})
	
	
	
	var today = new Date();
	var year = today.getFullYear();
	var month = String(today.getMonth() + 1).padStart(2, '0');
	var day = String(today.getDate()).padStart(2, '0');
	var minDate = year + '-' + month + '-' + day;
	// 시작날짜의 최소값 ==> 현재 날짜
	$("input[name='start']").attr("min", minDate);

	// 종료날짜의 최소값 ==> 선택한 시작날짜
	$(".dateInput").on("change", function() {
        var currentIndex = $(this).index(".dateInput");

        var selectedDate = $(this).val();
        $(".dateInput").eq(currentIndex + 1).attr("min", selectedDate);
    });
	
	$("#start").on("change", function() {
	    // 선택한 발주 일자 가져오기
	    var selectedDate = new Date($(this).val());

	    // 선택한 날짜에 7일 추가
	    selectedDate.setDate(selectedDate.getDate() + 7);

	    // YYYY-MM-DD 포맷으로 변환
	    var deliveryDate = selectedDate.toISOString().slice(0,10);

	    // 납기 일자 설정
	    $("#end").val(deliveryDate);
	});
	
	$("#employee_name").on('focus keyup',function(){
		var schTerm = $(this).val();
			$.ajax({
				method:"post",
				url:"${path}/schEmp",
				data:"employee_name="+schTerm,
				dataType:"json",
				success:function(data){
				    console.log(data);
				    $('#searchResults').empty();
					
				    data.forEach(function(result) {
				        var listItem = '<div class="dropdown-item d-flex justify-content-between">';
				        listItem += '<span style="font-size:15px;">' + result.employee_name + '</span>';
				        listItem += '<span style="font-size:15px;">' + result.store_name + '</span>';
				        listItem += '</div>';
				        listItem += '<input type="hidden" id="employee_num" value="'+result.employee_num+'">';
				        $('#searchResults').append(listItem);
				    });
				},
				error:function(err){
					console.log(err)
				}
				
			})
 
	})
	
})

$(document).on('focus keyup', '.item_name', function() {
    
    var schPrd = $(this).val();
    var parentRow = $(this).closest('tr');
    var targetPrdResults = parentRow.find('.prdResults');
    
    $.ajax({
        method: "post",
        url: "${path}/schPrd",
        data: "item_name=" + schPrd,
        dataType: "json",
        success: function(data) {
            console.log(data);
            targetPrdResults.empty();
            var prdItem = '';
            data.forEach(function(result) {
                prdItem += '<div class="dropdown-item d-flex justify-content-between">';
                prdItem += '<span style="font-size:13px;">' + result.brand + '</span>';
                prdItem += '<span style="font-size:13px;">' + result.item_name + ' ' + result.color + result.prd_size + '</span>';
                prdItem += '</div>';
                prdItem += '<input type="hidden" class="productNum" value="' + result.product_num + '">';
                prdItem += '<input type="hidden" class="price_hide" value="' + result.cost + '" data-price="'+result.cost+'">';

            });
            targetPrdResults.append(prdItem);
        },
        error: function(err) {
            console.log(err);
        }
    });
});


$(document).on('click', '#searchResults .dropdown-item', function() {
	var parentRow = $(this).closest('.form-group')
    var selectedEmployee = $(this).find('span:first').text();
    var selectedStore = $(this).find('span:last').text();
	var empNum = $(this).nextAll('#employee_num:first').val();
    
    $('#employee_name').val(selectedEmployee);
    $('#store_name').val(selectedStore);
    $('[name=employee_num]').val(empNum);
    $('#employeeDropdown .dropdown-menu').dropdown('hide');
    $('#employee_name').addClass('emp-clicked');
});

$(document).on('focusout blur', '#employee_name', function() {
    if (!$(this).hasClass('emp-clicked')) {
        $('#employee_name').val('');
        $('#store_name').val('');
    }
    $(this).removeClass('emp-clicked');
});

$(document).on('click', '.prdResults .dropdown-item', function() {
    var parentRow = $(this).closest('tr');
    var selectedPrd = $(this).find('span:last').text();
    var selectedNum = $(this).next('.productNum').val();
    var selectedPrice = $(this).nextAll('.price_hide:first').val();
    var salePri = parseInt(selectedPrice * 1.2);
    var format_salePri = salePri.toLocaleString();
    
    parentRow.find('.item_name').removeClass('text-center').val(selectedPrd);
    parentRow.find('.product_num').val(selectedNum);
    parentRow.find('.sale_price').val(format_salePri);
    parentRow.find('.order_count').val(1);
    parentRow.find('.sale_price').attr('data-price', selectedPrice);
    parentRow.find('.item_results .dropdown-menu').dropdown('hide');
    parentRow.find('.item_name').addClass('dropdown-clicked');
});

$(document).on('focusout blur', '.item_name', function() {
    if (!$(this).hasClass('dropdown-clicked')) {
        var parentRow = $(this).closest('tr');
        parentRow.find('.item_name').val('');
        parentRow.find('.product_num').val('');
        parentRow.find('.sale_price').val('');
        parentRow.find('.order_count').val('');
    }
    $(this).removeClass('dropdown-clicked');
});

$(document).on('input', '.order_count', function() {
    var parentRow = $(this).closest('tr');
    var salePriceInput = parentRow.find('.sale_price');
    var orderCount = parseInt($(this).val());
    if (orderCount < 1) {
        orderCount = 1;
        $(this).val(1);
    }
    var originalSalePrice = parseInt(salePriceInput.data('price'));
    var calPrice = originalSalePrice * orderCount * 1.2;
    var format_calPrice = calPrice.toLocaleString();
    salePriceInput.val(format_calPrice);
});




function addRow() {
    var rowItem = '<tr>';
    rowItem += '<td class="text-center"><input type="text" class="form-control product_num" name="product_num" readonly></td>';
    rowItem += '<td class="text-center dropdown">';
    rowItem += '<input type="text" class="form-control item_name" name="item_name" data-toggle="dropdown" autocomplete="off">';
    rowItem += '<div class="dropdown-menu item_results" aria-labelledby="item_name">';
    rowItem += '<div class="d-flex justify-content-around align-items-center bg-light border-bottom">';
    rowItem += '<span style="font-size:18px;">브랜드</span>';
    rowItem += '<span style="font-size:18px;">품목명</span>';
    rowItem += '</div>';
    rowItem += '<div class="prdResults"></div>';
    rowItem += '</div>';
    rowItem += '</td>';
    rowItem += '<td><input type="number" class="form-control text-right order_count" name="order_count"></td>';
    rowItem += '<td><input type="text" class="form-control text-right sale_price" readonly></td>';
    rowItem += '</tr>';

    $('#orderRow').append(rowItem);
}

function delRow(){
	var table = document.getElementById('orderTable');
	var rowCount = table.rows.length;
	
	if(rowCount > 2) {
		table.deleteRow(-1);	
	}
}

function frmReset(){
	document.getElementById("frm01").reset();
	$(".item_name").removeClass('text-center');
}
</script>
<!-- Bootstrap JS, Popper.js, and jQuery -->
<%@include file="footer.jsp" %>


