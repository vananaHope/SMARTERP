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
	
	apvPage()
	
    $("#search").on('keydown', function(event) {
        var subject = "${sch.subject}";
        var subjectVal = $("[name=subject]").val();
               
        if (subject != subjectVal) {
            $("[name=curPage]").val(1);
        }
        
        if(event.keyCode == 13) {
        	event.preventDefault()
        	apvPage()
        	
        }  
	});
	
	$("[name=pageSize]").val("${sch.pageSize}")
})

function goPage(cnt){
	$("[name=curPage]").val(cnt)
	apvPage()
}

function apvPage() {
    $.ajax({
        type: "post",
        url: "${path}/apvPaging",
        data: $("#frm").serialize(),
        success: function (data) {
        	console.log(data)
            $(".apvResults").html("");
            var add = '';
            data.pagingList.forEach(function (result) {
            	console.log(result)
                add += '<tr class="text-center" data-bs-toggle="modal" data-bs-target="#apvModal" onclick="detail(\'' + result.approval_id + '\')">';
                add += '<td>' + result.approval_date.slice(0, 10) + '</td>';
                add += '<td>' + result.subject + '</td>';
                add += '<td>' + result.approval_type + '</td>';
                add += '<td>' + result.drafter + '</td>';
                add += '<td>' + result.approver + '</td>';
                if(result.approval_status == 0) {
                	add += '<td>진행중</td>'
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
            
            if (data.pagingList.length > 0) {
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
</script>

<div class="container-fluid">

    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">결재 승인</h1>    	
    </div>
	<form id="frm">
	<div class="d-sm-flex align-items-center justify-content-end mb-2">
	    <a class="resetSch" href="${path}/apvList">
			<i class="fa-solid fa-repeat fa-sm" style="font-size:18px; margin-right:10px;"></i>
		</a>
	    <input type="text" id="search" class="text-right form-control w-25" name="subject" placeholder="제목 입력" value="${sch.subject}">
		<input type="hidden" name="curPage" value="${sch.curPage}"/>
		<input type="hidden" name="pageSize">
	</div>
    <div class="row">
		<div class="col-dong">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<table class="tab-no">
							<col width="20%">
							<col width="25%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="10%">
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
								<tr class="text-center" data-bs-toggle="modal" data-bs-target="#apvModal" 
									onclick="detail('${apvList.approval_id}')">
										<td><fmt:formatDate value="${registered}" pattern="yyyy-MM-dd"/></td>
										<td>${apvList.subject}</td>
										<td>${apvList.approval_type}</td>
										<td>${apvList.drafter}</td>
										<td>${apvList.approver}</td>
										<c:if test="${apvList.approval_status == 0}">
											<td>진행중</td>
										</c:if>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
    </div>
    <!-- 페이징 처리 -->
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
		<form class="form" method="post" id="frm">
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
					</div> <!-- modal body end -->
				
				<!-- Modal footer -->
				<div class="modal-footer d-flex justify-content-right">
					<button type="button" id="agrBtn" class="btn btn-primary" data-bs-dismiss="modal" 
						onclick="btn(1)">승인</button>
					<button type="button" id="denyBtn" class="btn btn-warning" data-bs-dismiss="modal" 
						onclick="btn(2)">반려</button>
					<button type="button" id="clsBtn" class="btn btn-secondary" data-bs-dismiss="modal">
						닫기</button>
				</div>
			</div>
			</form>
		</div>
	</div>
	<script>	
	// 승인, 반려 숫자에 따라 다르게 처리
	function btn(num){
		if(num == 1) {
			if(confirm("승인하시겠습니까?")){
				$.ajax({
					type:"post",
					url:"${path}/upt",
					data:"approval_id="+$("#approval_id").val()+"&order_id="+$("#order_id").val()+"&num="+num,
					success:function(msg){
						alert(msg)
						location.reload()
					},
					error:function(err){
						console.log(err)
					}
				})
			}else{
				$("#clsBtn").close()
			}
		}
		if(num == 2) {
			if(confirm("반려하시겠습니까?")){
				$.ajax({
					type:"post",
					url:"${path}/upt",
					data:"approval_id="+$("#approval_id").val()+"&order_id="+$("#order_id").val()+"&num="+num,
					success:function(msg){
						alert(msg)
						location.reload()
					},
					error:function(err){
						console.log(err)
					}
				})
			}else{
				$("#clsBtn").close()
			}
		}

	}	

	// 상세 내역 모달
	function detail(apv){
		$.ajax({
			type:"post",
			url:"${path}/apvDetail",
			data:"approval_id="+apv,
			success:function(result){
				$("#order_id").val(result.order_id)
				$("#approval_id").val(result.approval_id)
				$("#approval_status").val("진행중")
				var date = result.approval_date.slice(0,10)
				$("#approval_date").val(date)
				$("#approval_type").val(result.approval_type)
				$("#drafter").val(result.drafter)
				$("#approver").val(result.approver)
				$("#subject").val(result.subject)
				$("#contents").val(result.contents)
				
				var empName = "${employee.employee_name}"
				if(empName == result.approver){
					$("#agrBtn").show()
					$("#denyBtn").show()	
				}else if (empName != result.approver){
					$("#agrBtn").hide()
					$("#denyBtn").hide()		
				}
			},
			error:function(err){
				console.log(err)
			}
		})
	}
	</script>
</div>
<!-- End of Main Content -->
</div>
<%@include file="footer.jsp"%>