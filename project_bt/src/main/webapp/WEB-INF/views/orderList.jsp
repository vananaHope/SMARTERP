<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link href='${path}/a00_com/lib/main.css' rel='stylesheet'/>
<script src="${path}/a00_com/popper.min.js"></script>
<script src='${path}/a00_com/lib/main.js'></script>
<script src='${path}/a00_com/dist/index.global.js'></script>
<script src='${path}/a00_com/packages/core/locales/ko.global.js'></script>
<link href="${path}/gantt-master/dist/frappe-gantt.css" rel="stylesheet">
<script src="${path}/gantt-master/dist/frappe-gantt.js"></script>
	<style>
		body {
			font-family: sans-serif;
			background: #ccc;
		}
		.container {
			width: 80%;
			margin: 0 auto;
		}
		.heading {
			text-align: center;
		}
		#gantt .bar-rejected .bar {
    		fill: red;
		}
		#gantt .bar-approved .bar {
    		fill: skyblue;
		}
		#gantt .bar-progress .bar {
    		fill: grey;
		}
		.popup-wrapper .title {
			color:white;
		}
		.item_results span {
			text-align:center;
		}

		.item_results {
		   width: 50%;
		   max-height:100px;
		   overflow-y: auto;
		}
	</style>
	<script>
	$(document).ready(function(){
		$.ajax({
			type:"post",
			url:"${path}/orderGan",
			dataType:"json",
			success:function(tasks){
		        tasks.forEach(function(task) {
		            switch(task.order_status) {
		            	case 0:
		            		task.custom_class = 'bar-progress';
		            		break;
		                case 1:
		                    task.custom_class = 'bar-approved';
		                    break;
		                case 2:
		                    task.custom_class = 'bar-rejected';
		                    break;
		            }
		        });
		        renderGantt(tasks);
		    },
			error:function(err){
				console.log(err)
			}
		})
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
		
        $.validator.addMethod("endDate", function(value, element) {
            var startDate = $('#start').val();
            return Date.parse(startDate) < Date.parse(value) || value == "";
        }, "납기 일자는 발주 일자보다 늦은 날짜를 선택해야합니다.");
		
		$("#frm").validate({
			rules: {
				start:{
					required:true
				},
				end:{
					required:true,
					endDate:true
				},
				item_name:{
					required:true
				},
				order_count:{
					required:true,
					number:true,
					min:true,
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
				item_name:{
					required: "품목명은 필수 입력입니다."
				},
				order_count:{
					required: "수량 필수 입력입니다.",
					number: "숫자만 입력해주세요",
					min:"1개 이상의 수량을 입력해주세요",
					max:"최대 1000개의 수량만 입력 가능합니다"
				}
			},
			submitHandler:function(){
				console.log(submit)
			}
		})
	})
	</script>	
	<div class="container-md">
		<input type="hidden" id="modal01" data-toggle="modal" 
			data-target="#exampleModalCenter">
		<h2 class="heading">발주 내역</h2>
		<div class="gantt-container">
			<svg id="gantt"></svg>
		</div>
	</div>
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="calTitle">상세 정보</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form class="form" method="post" id="frm">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">발주ID</span>
							</div>
							<input type="text" id="id" name="id" class="form-control" readonly>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">매장명</span>
							</div>
							<input type="text" id="title" class="form-control" placeholder="일정입력" readonly>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">담당자</span>
							</div>
							<input type="text" id="employee_name" class="form-control" placeholder="담당자입력" readonly>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">발주일</span>
							</div>
							<input type="date" id="start" name="start" class="form-control dateInput" placeholder="입력" onkeydown="return false" readonly>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">납기일</span>
							</div>
							<input type="date" id="end" name="end" class="form-control dateInput" placeholder="입력" onkeydown="return false" readonly>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">발주 물건</span>
							</div>
							<input type="hidden" class="product_num" name="product_num">
			            	<input type="text" class="form-control item_name" name="item_name" data-toggle="dropdown" autocomplete="off" disabled>
			            	<div class="dropdown-menu item_results" aria-labelledby="item_name">
					            <div class="d-flex justify-content-between px-3 py-1 bg-light border-bottom">
					                <span style="font-size:18px;">브랜드</span>
					                <span style="font-size:18px;">품목명</span>
					            </div>
					            <div class="prdResults"></div>
				        	</div>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">발주 갯수</span>
							</div>
							<input type="text" id="order_count" name="order_count" class="form-control" placeholder="입력" autocomplete="off" readonly>
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">진행 상태</span>
							</div>
							<input type="text" id="order_status" class="form-control" readonly>
						</div>
						<div class="modal-footer">
							<button type="button" id='uptBtn' class="btn btn-info">수정</button>
							<button type="button" id='delBtn' class="btn btn-warning">삭제</button>
							<button type="button" id='clsBtn' class="btn btn-secondary"
								data-dismiss="modal">닫기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
	$(document).ready(function(){
		var msg = "${msg}"
		if(msg != ''){
			alert(msg)
		}
		
		let job_level = "${employee.job_level}"
		if(job_level == '점주' || job_level == '매니저' || job_level == '팀장' || job_level == '사장') {
			$("#start").attr("readonly",false)
			$("#end").attr("readonly",false)
			$("#order_count").attr("readonly",false)
			$("[name=item_name]").attr("disabled",false)
			$("#uptBtn").show()
			$("#delBtn").show()
		}else{
			$("#start").attr("readonly",true)
			$("#end").attr("readonly",true)
			$("#order_count").attr("readonly",true)
			$("[name=item_name]").attr("disabled",true)
			$("#uptBtn").hide()
			$("#delBtn").hide()
		}
	    
		$("#uptBtn").click(function() {
	        if ($("#frm").valid() && confirm("수정하시겠습니까?")) {
	            $("[name=item_name]").attr("disabled", true);
	            $.ajax({
	                type: "post",
	                url: "${path}/uptOrder",
	                data: $(".form").serialize(),
	                success: function(msg) {
	                    alert(msg);
	                    location.reload();
	                },
	                error: function(err) {
	                    console.log(err);
	                }
	            });
	        }
	    });
	    
	    $("#delBtn").click(function() {
	        if ($("#frm").valid() && confirm("삭제하시겠습니까?")) {
	            $("[name=item_name]").attr("disabled", true);
	            $.ajax({
	                type: "post",
	                url: "${path}/delOrder",
	                data: "id=" + $("#id").val(),
	                success: function(msg) {
	                    alert(msg);
	                    location.reload();
	                },
	                error: function(err) {
	                    console.log(err);
	                }
	            });
	        }
	    });
		
		
	})
	
	function renderGantt(tasks) {
		var gantt = new Gantt('#gantt', tasks, {
			on_click: function (task) {
				$("#title").val(task.name)
				$("#id").val(task.id)
				$("#employee_name").val(task.employee_name)
				$("#start").val(task.start)
				$("#end").val(task.end)
				if(task.order_status == 0) {
					$("#order_status").val('진행 중')	
				}else if(task.order_status == 1) {
					$("#order_status").val('승인')
				}else {
					$("#order_status").val('거절')
				}
				$(".item_name").val(task.item_name+' '+task.color+task.prd_size)
				$("#order_count").val(task.order_count)
				$(".product_num").val(task.product_num)
				
				$("#modal01").click()
				console.log(task);
			},
			on_date_change: function(task, start, end) {
				let job_level = "${employee.job_level}"
				
				function adjustDateForTimezone(dateObj) {
			        let offsetInMinutes = dateObj.getTimezoneOffset();
			        dateObj.setMinutes(dateObj.getMinutes() - offsetInMinutes);
			        return dateObj;
			    }
				
				if(job_level == '점주' || job_level == '매니저' || job_level == '팀장' || job_level == '사장') {
					var start1 = adjustDateForTimezone(start).toISOString().slice(0,10);
			        var end1 = adjustDateForTimezone(end).toISOString().slice(0,10);
					console.log(start1)
					console.log(end1)
					var url = "product_num="+task.product_num+"&id="+task.id+"&order_count="+task.order_count+"&start="+start1+"&end="+end1;
					
					$.ajax({
						type:"post",
						url:"${path}/uptOrder",
						data:url,
						success:function(msg){
							alert(msg)
							location.reload()
						},
						error:function(err){
							console.log(err)
						}
					})
				}else {
					alert('권한이 필요합니다. 인사 담당자에게 문의하세요')
					location.reload()
				}
				console.log(task, start, end);
			}
		});
		var new_height = gantt.$svg.getAttribute('height') - 100;
		gantt.$svg.setAttribute('height', new_height);
	}
	$(document).on('focus keyup', '.item_name', function() {
	    var schPrd = $(this).val();
	    var parentRow = $(this).closest('.input-group'); 
	    var targetPrdResults = parentRow.find('.prdResults'); 
	    
	    $.ajax({
	        method: "post",
	        url: "${path}/schPrd",
	        data: "item_name=" + schPrd,
	        dataType: "json",
	        success: function(data) {
	            targetPrdResults.empty();
	            var prdItem = '';
	            data.forEach(function(result) {
	                prdItem += '<div class="dropdown-item d-flex justify-content-between">';
	                prdItem += '<span style="font-size:13px;">' + result.brand + '</span>';
	                prdItem += '<span style="font-size:13px;">' + result.item_name + ' ' + result.color + result.prd_size + '</span>';
	                prdItem += '</div>';
	                prdItem += '<input type="hidden" class="productNum" value="' + result.product_num + '">';
	            });
	            targetPrdResults.html(prdItem);
	        },
	        error: function(err) {
	            console.log(err);
	        }
	    });
	});

	$(document).on('click', '.prdResults .dropdown-item', function() {
	    var parentRow = $(this).closest('.input-group');
	    var selectedPrd = $(this).find('span:last').text();
	    var selectedNum = $(this).next('.productNum').val();

	    parentRow.find('.item_name').removeClass('text-center').val(selectedPrd);
	    parentRow.find('.product_num').val(selectedNum);

	    parentRow.find('.item_results .dropdown-menu').dropdown('hide');
	    parentRow.find('.item_name').addClass('dropdown-clicked');
	});

	$(document).on('focusout blur', '.item_name', function() {
	    if (!$(this).hasClass('dropdown-clicked')) {
	        var parentRow = $(this).closest('.input-group');
	        parentRow.find('.item_name').val('');
	        parentRow.find('.product_num').val('');
	    }
	    $(this).removeClass('dropdown-clicked');
	});

	</script>
<%@include file = "footer.jsp" %>	