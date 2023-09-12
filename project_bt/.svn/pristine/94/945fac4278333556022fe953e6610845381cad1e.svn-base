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
.miniBtn{
 	width:60%;
 	font-size:2px;
 	padding: 1px 4px;
 	margin:auto;
}
input[type='date'] {
  position: relative; 
  width: 100%;
  border-radius: 4px;
  color:#808080;
}
input[type='date']::-webkit-calendar-picker-indicator {
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background: transparent;
  color: transparent;
  cursor: pointer;
}
.errorMsg{
	display:inline-block;
	color: red;
	margin: 10px 5px 0 0;
	font-weight: bold;
	font-size: 13px;
}
</style>

<div class="container mt-5">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">판매내역 등록</h1>
    </div>
    <form method="post" id="frm01">
    <div class="card border-left-primary shadow h-100 py-2">
        <div class="card-body">
            <div class="form-row align-items-center">
                <div class="form-group col-md-3">
                    <label for="stName">점포 선택:</label>
                	<select class="form-control" id="stName" name="store_num">
                		<option value="0">선택</option>
                	</select>
                </div>
                <div class="form-group col-md-3">
                    <label for="deliveryDate">판매 일자:</label>
                    <input type="date" class="form-control dateInput" id="end" name="sale_date" onkeydown="return false">
                </div>
                <div class="mt-1" style="margin-left:30px;">
	                <button type="button" class="btn btn-success" onclick="addRow()" disabled>내역 추가</button>
	                <button type="button" class="btn btn-warning" onclick="delRow()" disabled>내역 삭제</button>
	            </div>
            </div>
			<table class="table table-bordered mt-3" id="saleHistoryTable">
			    <thead class="thead-light text-center">
			        <tr>
			            <th>상품명</th>
			            <th>상품ID</th>
			            <th>판매가</th>
			            <th>± 5%</th>
			            <th>개수</th>
			            <th>총가격</th>
			        </tr>
			    </thead>
			    <tbody id="tableRow">
			        <tr>
			            <td class="text-center dropdown">
			            	<input type="text" class="form-control item_name" name="item_name" data-toggle="dropdown" autocomplete="off" disabled>
			            	<div class="dropdown-menu item_results" aria-labelledby="item_name">
					            <div class="d-flex justify-content-between px-3 py-1 bg-light border-bottom">
					                <span style="font-size:18px;">브랜드</span>
					                <span style="font-size:18px;">품목명</span>
					            </div>
					            <div class="prdResults"></div>
				        	</div>
			            </td>
			            <td class="text-center"><input type="text" class="form-control store_product_id" name="store_product_id" readonly></td>
			            <td><input type="text" class="form-control text-right cost" data-cost="" readonly></td>
			            <td style="text-align:center">
			            	<div class="row">
				            	<button type="button" class="btn btn-danger miniBtn" disabled>▲</button>
			            	</div>
			            	<div class="row">
				            	<button type="button" class="btn btn-primary miniBtn" disabled>▼</button>
			            	</div>
			            </td>
			            <td><input type="number" class="form-control text-right sale_count" name="sale_count" disabled></td>
			            <td><input type="text" class="form-control text-right total_price" readonly>
							<input type="hidden" name="total_price"></td>
			        </tr>
			    </tbody>
			</table>
            <div class="mt-3 text-right" style="height:100px;"></div>
            <div class="mt-3 text-right">
            	<p class="errorMsg" id="errorMsg"></p>
            	<p class="errorMsg" id="errorMsg2"></p>
                <button type="button" id="saleRegBtn" class="btn btn-primary">내역 등록</button>
                <button type="button" class="btn btn-secondary" onclick="frmReset()">내역 초기화</button>
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
	
	rshStList();
	
	
	$.validator.setDefaults({
	    onkeyup: false,
	    onclick: false,
	    onfocusout: false,
	    showErrors: function(errorMap,errorList){
	        if(this.numberOfInvalids()){ // 에러가 있으면
				$("#errorMsg").text(errorList[0].message)
	        }
	    }
	});
	$("#frm01").validate({
		focusCleanup:true,
		rules: {
			store_num:{
				required:true
			},
			store_product_id:{
				required:true
			},
			sale_date:{
				required:true
			},
			sale_count:{
				required:true
			},
			total_price:{
				required:true
			}
		},
		messages:{
			store_num:{
				required: "점포를 선택해야합니다."
			},
			store_product_id:{
				required: "상품을 선택해야합니다."
			},
			sale_date:{
				required: "판매 날짜를 선택해야합니다."
			},
			sale_count:{
				required: "판매 수량이 있어야합니다."
			},
			total_price:{
				required: "총 판매액이 입력되어야합니다."
			}
		},
		submitHandler:function(){
			console.log('서밋핸들러')
			$("#errorMsg").text('')
		}
	})
	
	var today = new Date();
	var year = today.getFullYear();
	var month = String(today.getMonth() + 1).padStart(2, '0');
	var day = String(today.getDate()).padStart(2, '0');
	var maxDate = year + '-' + month + '-' + day;
	$('input[name=sale_date]').attr('max',maxDate);
	
})
// 초기 로딩 시 점포 리스트 출력 (select)
function rshStList(){
	$.ajax({
		url:"rshStList",
		type:"post",
		dataType:"json",
		success:function(stList){
			var show = "<option value=''>선택</option>"
			stList.forEach(function(st){
				show += '<option value='+st.store_num+'>'+st.store_name+'</option>'
			})
			$("#stName").html(show)
		},
		error:function(err){
			console.log("에러발생: "+err)
		}
	})
}
// 현재 선택되어있는 점포명 값
var selectedVal = '';
$("#stName").on('click',function(){
	selectedVal = $(this).val()
	console.log('현재 값: '+selectedVal)
})
// 점포명 변경 시 내역 초기화 처리
$("#stName").on('change',function(){
	var table = document.getElementById('saleHistoryTable');
	var rowCount = table.rows.length;
	var curVal = $(this).val()
	if(selectedVal!=''&&selectedVal!=curVal){
		console.log('점포명이 있고, 점포명 변경시')
		
		console.log('내역 행 삭제: '+rowCount)
		for(let i=rowCount; i>2; i--){
			table.deleteRow(-1)
		}
		$('.item_name').trigger('focusout');
		$('.item_name').attr('disabled',true);
		$('.sale_count').attr('disabled',true);
		
		$("#errorMsg").text('');
	}
	
	
	if($(this).val()!=''){
		console.log('점포명이 선택 되었을 때')
		$(".item_name").attr('disabled',false)
	}
	if($(this).val()==''){
		$(".item_name").attr('disabled',true)
	}
})
// 상품명 검색 ajax 처리
$(document).on('focus keyup', '.item_name', function() {
    var schPrd = $(this).val();
    var parentRow = $(this).closest('tr');
    var targetPrdResults = parentRow.find('.prdResults');
    var stNum = $("#stName").val()
    $.ajax({
        url: "schPrdByName",
        type: "post",
        data: "store_num="+stNum+"&item_name="+schPrd,
        dataType: "json",
        success: function(data) {
            console.log(data);
            targetPrdResults.empty();
            var prdItem = '';
            data.forEach(function(rs) {
                prdItem += '<div class="dropdown-item d-flex justify-content-between">';
                prdItem += '<span style="font-size:13px;">' + rs.brand + '</span>';
                prdItem += '<span style="font-size:13px;">' + rs.item_name + ' ' + rs.color + rs.size + '</span>';
                prdItem += '</div>';
                prdItem += '<input type="hidden" class="stPrdId" value="' + rs.store_product_id + '">';
                prdItem += '<input type="hidden" class="cost_hide" value="' + rs.cost + '" data-cost="'+rs.cost+'">';
                prdItem += '<input type="hidden" class="mxCnt" value=' + rs.cnt + '>';
            });
            targetPrdResults.append(prdItem);
        },
        error: function(err) {
            console.log(err);
        }
    });
});

// 상품명 검색 결과 드롭다운 클릭 시 내역에 값 할당 처리
$(document).on('click', '.prdResults .dropdown-item', function() {
    var parentRow = $(this).closest('tr');
    var selectedPrd = $(this).find('span:last').text();
    var selectedNum = $(this).next('.stPrdId').val();
    var selectedPrice = $(this).nextAll('.cost_hide:first').val();
    var mxCnt = $(this).nextAll('.mxCnt:first').val();
    var salePri = parseInt(selectedPrice * 1);
    var format_salePri = salePri.toLocaleString();
    console.log("재고수량: "+mxCnt)
    console.log("선택상품원가: "+selectedPrice)
    parentRow.find('.item_name').removeClass('text-center').val(selectedPrd);
    parentRow.find('.store_product_id').val(selectedNum);
    parentRow.find('.sale_count').val(1);
    parentRow.find('.cost').val(format_salePri);
    parentRow.find('.cost').attr('data-cost', selectedPrice);
    parentRow.find('.item_results .dropdown-menu').dropdown('hide');
    parentRow.find('.item_name').addClass('dropdown-clicked');
    parentRow.find('.btn').attr('disabled',false)
    parentRow.find('.sale_count').attr('disabled',false)
    parentRow.find('.sale_count').attr('max',mxCnt)
    $(".btn-success").attr('disabled',false)
    $(".btn-warning").attr('disabled',false)
    
    // 총 판매액
    var countInput = parentRow.find('.sale_count')
    var count = countInput.val();
    var costInput = parentRow.find('.cost');
    var salePrice = parseInt(costInput.val().replace(/,/g,''));
    calTotPrice(parentRow,salePrice,count)
});
// ±5% 버튼 클릭 시 판매가 증/감 처리
$(document).on('click', '.miniBtn', function(){
	var parentRow = $(this).closest('tr');
	var costInput = parentRow.find('.cost');
	var countInput = parentRow.find('.sale_count')
	var count = countInput.val();
	var originPrice = costInput.attr("data-cost");
	console.log(originPrice)
	var salePrice = parseInt(costInput.val().replace(/,/g,''));
	if($(this).hasClass('btn-danger')){
		salePrice = salePrice + (originPrice * 0.05);
		$('#errorMsg2').text('')
	}
	if($(this).hasClass('btn-primary')){
		var minPrice = originPrice/10
		if(salePrice>minPrice){
			salePrice = salePrice - (originPrice * 0.05);
		} else {
			$('#errorMsg2').text('최저가는 '+minPrice+'원 입니다.')
		}
	}
	var format_salePri = salePrice.toLocaleString();
	costInput.val(format_salePri)
	parentRow.find('.cost').val(format_salePri);
	
	if(countInput.val()!=""){
		calTotPrice(parentRow,salePrice,count);
	}
})
// 갯수 입력 처리 시
$(document).on('input', '.sale_count', function() {
    var parentRow = $(this).closest('tr');
    var costInput = parentRow.find('.cost');
	var countInput = parentRow.find('.sale_count')
	var count = parseInt(countInput.val())
	var storageCnt = parseInt(parentRow.find('.sale_count').attr('max'))
	var salePrice = parseInt(costInput.val().replace(/,/g,''));
    var orderCount = parseInt($(this).val());
    if (orderCount < 1) {
        orderCount = 1;
        $(this).val(1);
    }
    if(countInput.val()!=""){
	    if(count<=storageCnt){
	    	$("#errorMsg2").text('');
	   	    calTotPrice(parentRow,salePrice,orderCount)
	    } else {
	    	console.log("재고보다 입력값이 큼")
	    	$("#errorMsg2").text('재고 수량보다 입력값이 많습니다.\n해당 상품의 재고는 '+storageCnt+'개 입니다.')
	    }
    }
    
});

// 총가격 처리 함수
function calTotPrice(parentRow,salePrice,count){
	var parentRow = parentRow;
	var totPriceInput = parentRow.find('.total_price');
	var intTotPrice = salePrice * count
	var format_totPrice = intTotPrice.toLocaleString();
	totPriceInput.val(format_totPrice)
	parentRow.find('.total_price').val(format_totPrice);
	parentRow.find('input[name=total_price]').val(intTotPrice);
}


// 상품명을 검색결과 내에서 클릭하지 않았을 경우 처리 
$(document).on('focusout blur', '.item_name', function() {
    if (!$(this).hasClass('dropdown-clicked')) {
        var parentRow = $(this).closest('tr');
        parentRow.find('.item_name').val('');
        parentRow.find('.store_product_id').val('');
        parentRow.find('.total_price').val('');
        parentRow.find('.sale_count').val('');
        parentRow.find('.cost').val('');
        parentRow.find('.miniBtn').attr('disabled',true)
        parentRow.find('.sale_count').attr('disabled',true)
    }
    $(this).removeClass('dropdown-clicked');
});

// 내역 추가 버튼
function addRow() {
    var rowItem = '<tr>';
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
    rowItem += '<td class="text-center"><input type="text" class="form-control store_product_id" name="store_product_id" readonly></td>';
    rowItem += '<td><input type="text" class="form-control text-right cost" data-cost="" readonly></td>'
    rowItem += '<td><div class="row">'
    rowItem += '<button type="button" class="btn btn-danger miniBtn" disabled>▲</button></div>'
    rowItem += '<div class="row">'
    rowItem += '<button type="button" class="btn btn-primary miniBtn" disabled>▼</button></div></td>'
    rowItem += '<td><input type="number" class="form-control text-right sale_count" name="sale_count" disabled></td>';
    rowItem += '<td><input type="text" class="form-control text-right total_price" readonly>';
    rowItem += '<input type="hidden" name="total_price"></td>';
    rowItem += '</tr>';
    $('#tableRow').append(rowItem);
}
// 내역 삭제 버튼
function delRow(){
	var table = document.getElementById('saleHistoryTable');
	var rowCount = table.rows.length;
	
	if(rowCount > 2) {
		table.deleteRow(-1);	
	}
}
// 내역 등록 시 처리
$("#saleRegBtn").click(function(){
	if($("#frm01").valid() && confirm("판매 내역을 등록하시겠습니까?")){
		$('#errorMsg').text('')
		$.LoadingOverlay("show");
		if($('#errorMsg2').text()==''){
			$.ajax({
				url:"insertSaleHistory",
				data:$("#frm01").serialize(),
				type:"post",
				dataType:"text",
				success:function(msg){
					$("#errorMsg").text("");
					$.LoadingOverlay("hide");
					alert(msg)
					if(msg.indexOf("성공")!=-1){
						location.href="regSaleHistory"
					}
				},
				error:function(err){
					console.log("에러발생: "+err)
				}
			})
		} else {
			alert('입력 값을 확인해주세요')
		}
	}
})
// 입력값 초기화 버튼
function frmReset(){
	document.getElementById("frm01").reset();
	$('.item_name').trigger('focusout');
	$(".item_name").removeClass('text-center');
	$(".item_name").attr('disabled',true);
	$(".sale_count").attr('disabled',true);
	$("#errorMsg").text('');
	var table = document.getElementById('saleHistoryTable');
	var rowCount = table.rows.length;
	for(let i=rowCount; i>2; i--){
		table.deleteRow(-1)
	}
	$("#errorMsg").text('');
}
</script>
<!-- Bootstrap JS, Popper.js, and jQuery -->
<%@include file="footer.jsp" %>


