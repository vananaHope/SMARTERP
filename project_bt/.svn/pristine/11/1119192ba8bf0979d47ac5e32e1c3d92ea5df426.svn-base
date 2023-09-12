<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/apv_order.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script>
$(document).ready(function(){
	$("#selectedTab").val("전체")
	apvFilter()
	
	$(".nav-pills .nav-item").on('click',function(){
	    var tab = $(this).text().trim();
	    $("#selectedTab").val(tab);
	   	if(tab.indexOf("전체") != -1){
	   		$("#search").val("")
	   		$("[name=curPage]").val(1)
	   		apvFilter()
	   	}
	   	if(tab.indexOf("진행중") != -1){
	   		$("#search").val("")
	   		$("[name=curPage]").val(1)
	   		apvFilter()
	   	}
	   	if(tab == "승인"){
	   		$("#search").val("")
	   		$("[name=curPage]").val(1)
	   		apvFilter()
	   	}
	   	if(tab == "반려"){
	   		$("#search").val("")
	   		$("[name=curPage]").val(1)
	   		apvFilter()
	   	}
	})
	
    $("#search").on('keydown', function(event) {
            var tab = $("#selectedTab").val();
            var subject = "${sch.subject}";
            var subjectVal = $("[name=subject]").val();
                   
            if (subject != subjectVal) {
                $("[name=curPage]").val(1);
            }
            
            if(event.keyCode == 13) {
            	event.preventDefault()
            	apvFilter()
            	
            }  
    });

	$("[name=pageSize]").val("${sch.pageSize}")
	
	$('#contents').keyup(function(){
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

 function apvFilter() {
    $.ajax({
        type: "post",
        url: "${path}/apvFilter",
        data: $("#frm").serialize(),
        success: function (data) {
        	console.log(data)
            $(".apvResults").html("");
            var add = '';
            data.filteredList.forEach(function (result) {
            	console.log(result)
                add += '<tr class="text-center" data-bs-toggle="modal" data-bs-target="#apvModal" onclick="detail(\'' + result.approval_id + '\')">';
                add += '<td>' + result.approval_date.slice(0, 10) + '</td>';
                add += '<td>' + result.subject + '</td>';
                add += '<td>' + result.approval_type + '</td>';
                add += '<td>' + result.drafter + '</td>';
                add += '<td>' + result.approver + '</td>';
                if(result.approval_status == 0) {
                	add += '<td>진행중</td>'
                }else if (result.approval_status == 1) {
                	add += '<td>승인</td>'
                }else if (result.approval_status == 2) {
                	add += '<td>반려</td>'
                }            
                add += '</tr>';
            });
            $(".pagination-container").empty();
            var pagination = '<nav aria-label="Page navigation example"><ul class="pagination justify-content-center mt-2">';
            pagination += '<li class="page-item"><a class="page-link" id="previous" href="javascript:goPage(' + (data.sch.curPage - 1) + ')">Previous</a></li>';
            for (var cnt = data.sch.startBlock; cnt <= data.sch.endBlock; cnt++) {
                pagination += '<li class="page-item ' + (data.sch.curPage == cnt ? 'active' : '') + '"><a class="page-link" href="javascript:goPage(' + cnt + ')">' + cnt + '</a></li>';
            }
            pagination += '<li class="page-item"><a class="page-link" id="next" href="javascript:goPage(' + (data.sch.endBlock + 1) + ')">Next</a></li>';
            pagination += '</ul></nav>';
            
            if (data.filteredList.length > 0) {
                $(".apvResults").html(add);
                $(".pagination-container").html(pagination);
            } else {
                $(".apvResults").empty();
                $(".pagination-container").empty();
            }
            $("[name=pageSize]").val(data.sch.pageSize)
            $("[name=curPage]").val(data.sch.curPage)
        },
        error: function (err) {
            console.log(err);
        }
    });
}


function goPage(cnt){

	$("[name=curPage]").val(cnt)
	var tab = $("#selectedTab").val()
	console.log(tab)

	apvFilter()

}

function detail(apv){
	var apv = apv.trim()
	$.ajax({
		type:"post",
		url:"${path}/apvDetail",
		data:"approval_id="+apv,
		success:function(result){
			var empNum = "${employee.employee_num}"
	        var isEditable = empNum == result.employee_num && result.approval_status == 0;
            // readonly isEditable 통해 toggle
            $("#subject").prop("readonly", !isEditable);
            $("#contents").prop("readonly", !isEditable);
            // 버튼 숨기기 보이기를 토글
            if (isEditable) {
                $("#modBtn").show();
                $("#delBtn").show();
            } else {
                $("#modBtn").hide();
                $("#delBtn").hide();
            }
			$("#order_id").val(result.order_id)
			$("#approval_id").val(result.approval_id)
			if(result.approval_status == 0) {
				$("#approval_status").val("진행중")	
			}
			else if(result.approval_status == 1) {
				$("#approval_status").val("승인")	
			}
			else if(result.approval_status == 2) {
				$("#approval_status").val("반려")	
			}
			var date = result.approval_date.slice(0, 10)
			$("#approval_date").val(date)
			$("#approval_type").val(result.approval_type)
			$("#drafter").val(result.drafter)
			$("#approver").val(result.approver)
			$("#subject").val(result.subject)
			$("#contents").val(result.contents)
			$("#textCount").text(result.contents.length+"자 / 500자")
		},
		error:function(err){
			console.log(err)
		}
	})
}


</script>
<div class="container-fluid">

    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">결재 현황</h1>
    </div>
   
    
    <form id="frm">
    <input type="hidden" id="selectedTab" name="selectedTab" value="">
    <input type="hidden" name="curPage" value="${sch.curPage}"/>
	<input type="hidden" name="pageSize">
	
    <div class="row">
    	<div class="d-flex justify-content-between align-items-center mb-3">
			<ul class="nav nav-pills">
			    <li class="nav-item">
			        <a class="nav-link active" data-bs-toggle="tab" data-tab="all" href="#">전체</a>
			    </li>
			    <li class="nav-item">
			        <a class="nav-link" data-bs-toggle="tab" data-tab="inProgress" href="#">진행중</a>
			    </li>
			    <li class="nav-item">
			        <a class="nav-link" data-bs-toggle="tab" data-tab="approved" href="#">승인</a>
			    </li>
			    <li class="nav-item">
			        <a class="nav-link" data-bs-toggle="tab" data-tab="rejected" href="#">반려</a>
			    </li>
			</ul>

            <input type="text" class="form-control w-25" id="search" placeholder="제목 입력" name="subject" value="${sch.subject}">
        </div>
        <div class="col-dong">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<table class="tab-no">
							<col width="15%">
							<col width="25%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<tr>
								<th rowspan="2">기안일자</th>
								<th rowspan="2">제목</th>
								<th rowspan="2">결재유형</th>
								<th rowspan="2">기안자</th>
								<th rowspan="2">결재자</th>
								<th rowspan="2">진행상태</th>
							</tr>
							<tr class="bottLine">
							</tr>
							<tbody class="apvResults">
								<c:forEach var="apvList" items="${apvList}">
								<fmt:parseDate value="${apvList.approval_date}" var="registered" pattern="yyyy-MM-dd" />
								<tr class="text-center" data-bs-toggle="modal" data-bs-target="#apvModal" onclick="detail('${apvList.approval_id}')">
										<td><fmt:formatDate value="${registered}" pattern="yyyy-MM-dd"/></td>
										<td>${apvList.subject}</td>
										<td>${apvList.approval_type}</td>
										<td>${apvList.drafter}</td>
										<td>${apvList.approver}</td>
										<c:choose>
											<c:when test="${apvList.approval_status == 0}">
												<td>진행중</td> 
											</c:when>
											<c:when test="${apvList.approval_status == 1}">
												<td>승인</td> 
											</c:when>
											<c:when test="${apvList.approval_status == 2}">
												<td>반려</td> 
											</c:when>											
										</c:choose>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
        </div>
    </div>
    <div class="pagination-container">
	   <nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center mt-2">
				<li class="page-item">
					<a class="page-link" id="previous" 
						href="javascript:goPage(${sch.startBlock-1})">Previous</a></li>
					<c:forEach var = "cnt" begin="${sch.startBlock}" end="${sch.endBlock}">
				<li class="page-item ${sch.curPage==cnt?'active':''}">
					<a class="page-link" 
						href="javascript:goPage(${cnt})">${cnt}</a></li>
					</c:forEach>
				<li class="page-item">
					<a class="page-link" id="next"
						href="javascript:goPage(${sch.endBlock+1})">Next</a></li>
			</ul>
		</nav>
	</div> 
	</form>
	<!-- 모달창 생성 -->
	<div class="container mt-3"></div>

	<!-- The Modal -->
	<div class="modal" id="apvModal">
		<div class="modal-dialog modal-lg">
		<form class="form" method="post" id="frm01">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">결재 상세</h4>
				</div>

				<!-- Modal body -->
				
					<div class="modal-body">
						<div class="row">
							<input type="hidden" id="order_id" name="order_id">
							<!-- 발주 번호 -->
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text">결재ID</span> 
										<input type="text" id="approval_id" name="approval_id" class="form-control" readonly>
								</div>
							</div>

							<!-- 진행 상태 -->
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text">진행 상태</span> 
									<input type="text" id="approval_status" name="approval_status" class="form-control" readonly>
								</div>
							</div>
						</div>

						<!-- 기안 일자 -->
						<div class="row">
							<div class="col-md-12">
								<div class="input-group mb-3">
									<span class="input-group-text">기안 일자</span> 
									<input type="date" name="approval_date" id="approval_date" class="form-control" readonly>
								</div>
							</div>
						</div>
						
						<!-- 결재 유형 -->
						<div class="row">
							<div class="col-md-12">
								<div class="input-group mb-3">
									<span class="input-group-text">결재 유형</span> 
									<input type="text" name="approval_type" id="approval_type" class="form-control" readonly>
								</div>
							</div>
						</div>
						
						<!-- 기안자 -->
						<div class="row">
							<div class="col-md-12">
								<div class="input-group mb-3">
									<span class="input-group-text">기안자</span> 
									<input type="text" name="drafter" id="drafter" class="form-control" readonly>
								</div>
							</div>
						</div>
						
						<!-- 결재자 -->
						<div class="row">
							<div class="col-md-12">
								<div class="input-group mb-3">
									<span class="input-group-text">결재자</span> 
									<input type="text" name="approver" id="approver" class="form-control" readonly>
								</div>
							</div>
						</div>
						
						<!-- 제목 -->
						<div class="row">
							<div class="col-md-12">
								<div class="input-group mb-3">
									<span class="input-group-text">제목</span> 
									<input type="text" name="subject" id="subject" class="form-control" readonly>
								</div>
							</div>
						</div>
						
						<!-- 결재 내용 -->
						<div class="row">
							<div class="col-md-8">
								<div class="input-group mb-3">
									<span class="input-group-text">결재 내용</span> 
								</div>
							</div>
						</div>
						<textarea class="form-control" id="contents" name="contents" rows="15" readonly></textarea>
						<div class="text-left" id="textCount">0자 / 500자</div> 
					</div> <!-- modal body end -->
				
				<!-- Modal footer -->
				<div class="modal-footer d-flex justify-content-right">
					<button type="button" id="modBtn" class="btn btn-primary" data-bs-dismiss="modal">수정</button>
					<button type="button" id="delBtn" class="btn btn-warning" data-bs-dismiss="modal">삭제</button>
					<button type="button" id="clsBtn" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
			</form>
		</div>
	</div>
	<script>
		$("#modBtn").click(function(){
			if(confirm("수정하시겠습니까?")){
				$.ajax({
					type:"post",
					url:"${path}/uptApvCon",
					data:"approval_id="+$("#approval_id").val()+"&subject="+$("#subject").val()+
							"&contents="+$("#contents").val(),
					success:function(msg){
						alert(msg)
						$("#clsBtn").click()
						location.reload()
					},
					error:function(err){
						console.log(err)
					}
				})
			}else{
				$("#clsBtn").click()
			}
		})
		$("#delBtn").click(function(){
			if(confirm("삭제하시겠습니까?")){
				$.ajax({
					type:"post",
					url:"${path}/delApv",
					data:"approval_id="+$("#approval_id").val(),
					success:function(msg){
						alert(msg)
						$("#clsBtn").click()
						location.reload()
						
					},
					error:function(err){
						console.log(err)
					}
				})
			}else{
				$("#clsBtn").click()
			}			
		})
	</script>
</div>
<!-- End of Main Content -->
</div>
<%@include file="footer.jsp"%>