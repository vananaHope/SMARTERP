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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<style>
textarea {
	resize:none;
}

</style>

<div class="container">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">결재 신청</h1>
    </div>
	<div class="card border-left-primary shadow h-100 py-2">
        <div class="card-body">
    	<form method="post" id="frm">	
			<!-- 제목과 발주 번호를 감싸는 row div 추가 -->
			<div class="row mb-3">
			    <!-- 제목 -->
			    <div class="col-md-6">
			        <div class="input-group">
			            <span class="input-group-text">제목</span> 
			            <input type="text" id="subject" name="subject" class="form-control" autocomplete="off">
			        </div>
			    </div>
			    <!-- 기안자 -->
			    <div class="col-md-3">
					<div class="input-group">
						<span class="input-group-text">기안자</span> 
							<input type="text" id="drafter" name="drafter" class="form-control" value="${employee.employee_name}" readonly>
					</div>
				</div>
			</div>
			<div class="row mb-3">
				<!-- 발주 번호 -->
			    <div class="col-md-6">
			        <div class="input-group">
			            <span class="input-group-text">발주ID</span> 
			            <select id="order_id" name="order_id" class="form-select">
			            	<option value="">발주ID 선택</option>
			            	<c:forEach var="ord" items="${schList}">
			            		<option value="${ord.order_id}">${ord.order_id}  ${ord.brand} ${ord.item_name} ${ord.color}${ord.prd_size} ${ord.store}</option>
			            	</c:forEach>
			            </select>
			        </div>
			    </div>
				<!-- 결재자 -->
        		<div class="col-md-3">
					<div class="input-group">
						<span class="input-group-text">결재자</span> 
						<select id="approver" name="approver" class="form-select">
							<option value="">결재자 선택</option>
							<c:forEach var="apv" items="${schApprover}">
								<option>${apv.approver}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
        	<!-- 기안 일자 -->
        	<div class="row mb-3">
        		<div class="col-md-6">
					<div class="input-group">
						<span class="input-group-text">기안 일자</span> 
							<input type="date" id="approval_date" name="approval_date" class="form-control dataInput" onkeydown="return false">
					</div>
				</div>
        	<!-- 결재 유형 -->
        		<div class="col-md-3">
					<div class="input-group">
						<span class="input-group-text">결재 유형</span> 
							<input type="text" id="approval_type" name="approval_type" class="form-control" value="발주서" readonly>
					</div>
				</div>
        	</div>
        	<!-- 결재 내용 -->
			<div class="row mb-3">
				<div class="col-md-6">
					<div class="input-group">
						<p class="input-group-text">결재 내용</p>
					</div>
				</div>
			</div>
			<textarea class="form-control" id="contents" name="contents" rows="8"></textarea>
			<div class="text-left" id="textCount">0자 / 500자</div> 
			<div class="mt-3 text-right">
                <button type="button" id="rqBtn" class="btn btn-primary">결재 신청</button>
                <button type="button" class="btn btn-secondary" onclick="frmReset()">다시 작성</button>
            </div> 
            </form>
        </div>
    </div>	
</div>
<script>
$(document).ready(function() {

	$( 'select' ).select2( {
	    theme: "bootstrap-5",
	    width: $( this ).data( 'width' ) ? $( this ).data( 'width' ) : $( this ).hasClass( 'w-100' ) ? '100%' : 'style',
	    placeholder: $( this ).data( 'placeholder' ),
	} );
	
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
	$("#frm").validate({
		focusCleanup:true,
		rules: {
			subject:{
				required:true,
				rangelength:[2,50]
			},
			order_id:{
				required:true
			},
			approval_date:{
				required:true
			},
			approval_type:{
				required:true
			},
			drafter:{
				required:true,
				rangelength:[2,10]
			},
			approver:{
				required:true
			},
			contents:{
				required:true
			}
		},
		messages:{
			subject:{
				required: "제목은 필수 입력입니다.",
				rangelength:"제목은 {0}자에서 {1}자까지 입력 가능합니다."
			},
			order_id:{
				required: "발주ID는 필수 입력입니다."
			},
			approval_date:{
				required: "기안일자는 필수 선택입니다."
			},
			approval_type:{
				required: "결재유형은 필수 입력입니다."
			},
			drafter:{
				required: "기안자는 필수 입력입니다.",
				rangelength: "기안자는 {0}자에서 {1}자까지 입력 가능합니다."
			},
			approver:{
				required: "결재자는 필수 입력입니다."
			},
			contents:{
				required:"결재내용을 입력해주세요"
			}
		},
		submitHandler:function(){

		}
	})
	
	var today = new Date();
	var year = today.getFullYear();
	var month = String(today.getMonth() + 1).padStart(2, '0');
	var day = String(today.getDate()).padStart(2, '0');
	var minDate = year + '-' + month + '-' + day;
	// 시작날짜의 최소값 ==> 현재 날짜
	$("input[name='approval_date']").attr("min", minDate);
	
	$('#contents').on('keyup keydown change',function(){
		let content = $(this).val();
				
		if(content.length == 0 || content == ''){
			$('#textCount').text("0자 / 500자");	
		}else if(content.length > 500){
			$('#textCount').text(content.length-1+"자 / 500자");
			$(this).val($(this).val().substring(0,500));
			alert("글자 수는 500자까지 입력 가능합니다.")
		}
		else {
			$('#textCount').text(content.length+"자 / 500자");
		}
	})

})
$("#order_id").change(function(){
	var selectedText = $(this).find("option:selected").text();
	if($("#order_id").val()!=""){
		$("#subject").val(selectedText);		
	}else{
		$("#subject").val("");
	}
})

$("#rqBtn").click(function() {
	$("#rqBtn").attr("disabled",true)
	if ($("#frm").valid() && confirm("결재 신청하시겠습니까?")) {
    	
    	$.LoadingOverlay("show");
        $.ajax({
            type: "post",
            url: "${path}/apvIns",
            data: $("#frm").serialize(),
            success: function(msg) {
                $.LoadingOverlay("hide");
                alert(msg);
                location.reload();
            },
            error: function(err) {
                console.log(err);
            }
        });
    }else{
    	$("#rqBtn").attr("disabled",false)
    }
});

function frmReset(){
	document.getElementById("frm").reset();
	$('#order_id').val(null).trigger('change')
}

</script>
<%@include file="footer.jsp" %>