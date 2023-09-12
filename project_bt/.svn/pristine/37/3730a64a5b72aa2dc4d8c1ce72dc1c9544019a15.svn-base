<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<fmt:requestEncoding value="utf-8"/>
<c:set var="path" 
   		value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SMART ERP</title>

    <!-- Custom fonts for this template-->
    <link href="${path}/erpBt/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    	rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="${path}/erpBt/css/sb-admin-2.min.css" rel="stylesheet">
    <link href="${path}/erpBt/css/header_modal.css" rel="stylesheet">
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<script src = "https://code.jquery.com/jquery-3.7.0.js" type="text/javascript"></script>
	<script src="${path}/jquery-validation/dist/jquery.validate.js"></script>
	<script src="${path}/jquery-validation/dist/additional-methods.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/gasparesganga-jquery-loading-overlay@2.1.7/dist/loadingoverlay.min.js"></script>
</head>
<c:set var="employee" value="${employee}"/>
<script>


$(document).ready(function(){

	setInterval(function() {
	    $.ajax({
	        url: "/check-session",
	        method: "GET",
	        success: function(data){
	            if (data && data.length > 0) {
	            	alert("세션이 만료되었습니다 다시 로그인해주세요")
	            	window.location.replace("/loginForm");
	            }
	        },
	        error: function (data) {
	            console.log("error");
	            console.log(data);
	        }
	    })
	}, 60000);
	
	$("#myInfo").on("show.bs.modal", function(event){	
		$("#my_errorMsg").html("");
		$("[name=my_password]").val("");
		openMyInfo()
	});
}) 

function warning(){
	alert("권한이 필요합니다. 인사담당자에게 문의하세요")
}
function chkMy_pass(){
	var reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/
	if($("[name=my_password]").val().length>1){
		var result = reg.test($("[name=my_password]").val())
		if(result){
			$("#my_regPassBtn").prop("disabled",false)
			$("#my_errorMsg").html("");
		}else{
			$("#my_regPassBtn").prop("disabled",true)
			
			$("#my_errorMsg").html("비밀번호는 8~15자내의 알파벳+숫자+특수문자로 변경할 수 있습니다.");
		}
	}
}

function openMyInfo(){
	
	$.ajax({
		type:"post",
		url:"${path}/myInfoDetail",
		data:{employee_num: ${employee.employee_num} },
		dataType:"json",
		success:function(data){
			var hiredate_header = new Date(data.hire_date);
			var offset_header = hiredate_header.getTimezoneOffset()*60000;
			$("#my_store_name").html(data.store_name)
			$("#my_employee_num").html(data.employee_num)
			$("#my_id").html(data.id)
			$("#my_email").html(data.email)
			$("#my_employee_name").html(data.employee_name)
			$("#my_job_level").html(data.job_level)
			$("#my_phone_num").html(data.phone_num)
			$("#my_hire_date").html(new Date(hiredate_header.getTime()-offset_header).toISOString().split("T")[0])
			if(data.employee_photo!=null){
				$("#myInfo [name=my_emp_photo]").attr("src", "/erpBt/img/employee_photo/"+data.employee_photo);
			}else{
				$("#myInfo [name=my_emp_photo]").attr("src", "/erpBt/img/employee_photo/image 22.png");
			}
			$("[name=my_password]").prop("readonly",true)
			$("#my_regPassBtn").prop("disabled",true)
			$("#my_regPassBtn").hide()
			$("#my_regPassBtn_chk").show()
		},
		error:function(err){
			console.log(err)
		}
	});
	
	$("[name=my_password]").on("keyup", function(event){
		chkMy_pass()
	})
	
	$("#my_regPassBtn_chk").click(function(){
		$("#my_regPassBtn_chk").hide();
		$("[name=my_password]").prop("readonly",false)
		$("#my_regPassBtn").show();
		
	});
	
	$("#my_regPassBtn").click(function(){
		if(confirm("비밀번호를 변경하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"${path}/uptPass",
				data:{
					employee_num: ${employee.employee_num},
					password: $("[name=my_password]").val()
					},
				dataType:"text",
				success:function(data){
					alert("비밀번호가 변경 완료되었습니다!")
				},
				error:function(err){
					console.log(err)
					alert("비밀번호 변경 실패!!")
				}
			})
		}
		
	});
}
</script>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper" class="sidebarBySession">

        <!-- 사이드바 시작~ -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- 로고 -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${path}/main">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-shopping-cart fa-shake"></i>
                </div>
                <div class="sidebar-brand-text mx-3"><sup>ABC</sup>Mart</div>
            </a>

            <!-- Dashboard -->
            <hr class="sidebar-divider my-0">
            <li class="nav-item active">                 
             	<c:choose>
            		<c:when test="${employee.auth == 1}">
		                <a class="nav-link" href="${path}/index">               	
		                <i class="fa-solid fa-chart-line"></i>
		                <span>Dashboard</span></a>
	                </c:when>
	                <c:otherwise>
	                	<a class="nav-link" href="#" onclick="warning()">               	
		                <i class="fa-solid fa-chart-line"></i>
		                <span>Dashboard</span></a>
	                </c:otherwise>  
                </c:choose>
            </li>

            <hr class="sidebar-divider">
            <div class="sidebar-heading">
                Human Resources
            </div>
            
            <!-- 인사관리 -->
            <li class="nav-item">
             	<c:choose>
	            	<c:when test="${employee.hire_type == '본사'}">
		                <a class="nav-link collapsed" href="${path}/hrm">
		                    <i class="fas fa-users"></i>
		                    <span>인사관리</span>
		                </a>
	                </c:when>
	                <c:otherwise>
	                	<a class="nav-link collapsed" href="#" onclick="warning()">
		                    <i class="fas fa-users"></i>
		                    <span>인사관리</span>
		                </a>
	                </c:otherwise>
                </c:choose>
            </li>
			
            <!-- 점포관리 -->
			<hr class="sidebar-divider">
            <div class="sidebar-heading">
                CRM
            </div>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseMarket"
                    aria-expanded="true" aria-controls="collapseMarket">
                    <i class="fas fa-store-alt"></i>
                    <span>점포관리</span>
                </a>
                <div id="collapseMarket" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="${path}/storeInfo">점포 조회</a>
                        <c:choose> 
                        	<c:when test="${employee.auth == 1}">
                        		<a class="collapse-item" href="${path}/storeManage">점포 리스트</a>
                    		</c:when>
                    		<c:otherwise>
                    			<a class="collapse-item" href="#" onclick="warning()">점포 리스트</a>
                    		</c:otherwise>
                    	</c:choose>
                    </div>
                </div>
            </li>
            
            
            <!-- 상품관리 -->
			<hr class="sidebar-divider">
            <div class="sidebar-heading">
                Inventory Management
            </div>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseProduct"
                    aria-expanded="true" aria-controls="collapseMarket">
                    <i class="fa-solid fa-cubes"></i>
                    <span>상품관리</span>
                </a>
                <div id="collapseProduct" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <c:choose> 
                        	<c:when test="${employee.hire_type == '본사' || employee.hire_type == '점포'}">
                        		<a class="collapse-item" href="${path}/product">본사 상품 조회</a>
                    		</c:when>
                    		<c:otherwise>
                    			<a class="collapse-item" href="#" onclick="warning()">본사 상품 조회</a>
                    		</c:otherwise>
                    	</c:choose>
                    	<c:choose>
                    		<c:when test="${employee.hire_type == '점포'}">
                    			<a class="collapse-item" href="${path}/storeStorage">점포 상품 조회</a>
                    		</c:when>
                    		<c:otherwise>
                    			<a class="collapse-item" href="#" onclick="warning()">점포 상품 조회</a>
                    		</c:otherwise>
                    	</c:choose>
                    </div>
                </div>
            </li>

            <!-- 상품관리 -->
			<%-- <hr class="sidebar-divider">
            <div class="sidebar-heading">
                Inventory Management
            </div>
            <li class="nav-item">
                <a class="nav-link collapsed" href="${path}/product">
                   <i class="fas fa-box"></i>
                    <span>상품관리</span>
                </a>
            </li> --%>

            <!-- 발주관리 -->
            <hr class="sidebar-divider">
            <div class="sidebar-heading">
                Sales & Marketing
            </div>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseOrder"
                    aria-expanded="true" aria-controls="collapseOrder">
                    <i class="fa-regular fa-clipboard"></i>
                    <span>발주관리</span>
                </a>
                <div id="collapseOrder" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                    	<c:choose>
                    		<c:when test="${employee.job_level == '점주' || employee.job_level == '매니저' || employee.job_level == '사장'}">
                        		<a class="collapse-item" href="${path}/orderReg">발주 입력</a>
                        	</c:when>
                        	<c:otherwise>
                        		<a class="collapse-item" href="#" onclick="warning()">발주 입력</a>
                        	</c:otherwise>
                        </c:choose>
                        <a class="collapse-item" href="${path}/orderList">발주 내역</a>
                    </div>
                </div>
            </li>
            
            <!-- 결재관리 -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseApproval"
                    aria-expanded="true" aria-controls="collapseApproval">
                    <i class="fa-solid fa-file-signature"></i>
                    <span>결재관리</span>
                </a>
                <div id="collapseApproval" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                     	<c:choose>
                    		<c:when test="${employee.job_level == '본사직원'}">
	                        	<a class="collapse-item" href="${path}/apvReg">결재 신청</a>
	                        	<a class="collapse-item" href="#" onclick="warning()">결재 승인</a>
                    			<a class="collapse-item" href="${path}/apvCurrent">결재 현황</a>
	                        </c:when>
	                        <c:when test="${employee.job_level == '팀장'}">
	                        	<a class="collapse-item" href="${path}/apvReg">결재 신청</a>
	                        	<a class="collapse-item" href="${path}/apvList">결재 승인</a>
	                        	<a class="collapse-item" href="${path}/apvCurrent">결재 현황</a>
	                        </c:when>
	                        <c:when test="${employee.job_level == '사장'}">
	                        	<a class="collapse-item" href="${path}/apvReg">결재 신청</a>
	                        	<a class="collapse-item" href="${path}/apvList">결재 승인</a>
	                        	<a class="collapse-item" href="${path}/apvCurrent">결재 현황</a>
                    		</c:when>
                    		<c:otherwise>
                    			<a class="collapse-item" href="#" onclick="warning()">결재 신청</a>
                    			<a class="collapse-item" href="#" onclick="warning()">결재 승인</a>
                    			<a class="collapse-item" href="#" onclick="warning()">결재 현황</a>
                    		</c:otherwise>
                    	</c:choose>
                    </div>
                </div>
            </li>

            <!-- 매출관리 -->
            <hr class="sidebar-divider">
            <div class="sidebar-heading">
                Finance & Accounting 
            </div>
            <li class="nav-item">
            	<c:choose>
            		<c:when test="${employee.auth <= 2 && employee.hire_type == '본사'}">
		                <a class="nav-link" href="${path}/salesOfCompany">
		                    <i class="fa-solid fa-coins"></i>
		                    <span>매출관리</span></a>
		                <a class="nav-link" href="${path}/regSaleHistory">    
		                    <i class="fa-solid fa-cash-register"></i>
		                    <span>판매내역</span></a>
		            </c:when>
            		<c:when test="${employee.auth == 2 && employee.hire_type == '점포'}">
		                <a class="nav-link" href="${path}/salesOfStore">
		                    <i class="fa-solid fa-coins"></i>
		                    <span>매출관리</span></a>
		            </c:when>
		            <c:otherwise>
		            	<a class="nav-link" href="#" onclick="warning()">
		                    <i class="fa-solid fa-coins"></i>
		                    <span>매출관리</span></a>
		            </c:otherwise>        
            	</c:choose>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
            

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">


                    <!-- Topbar Search -->

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->

                        <!-- Nav Item - Alerts -->

                        <!-- Nav Item - Messages -->
						
                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->       
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <c:if test="${not empty employee}">
                                	<span class="mr-2 d-none d-lg-inline text-gray-600 small">${employee.employee_name}님</span>
                                </c:if>
                                <c:if test="${empty employee}">
                                	<span class="mr-2 d-none d-lg-inline text-gray-600 small">로그인/회원가입</span>
                                </c:if>
                                <i class="fa-solid fa-user fa-bounce"></i>
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#myInfo">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    개인정보
                                </a>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    로그아웃
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->
<!-- The MyInfo Modal -->
<div class="modal fade" id="myInfo">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">개인 정보 조회</h4>
					<button type="button" class="btn-close" data-dismiss="modal"></button>
				</div>
		
				<!-- Modal body -->
				<form class="form" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="col-md-6">
								<div class="input-group mb-6">
									<span class="input-group-text my_custom_modal02">점포명</span> 
									<span id="my_store_name" class="form-control"></span>
								</div>
							</div>
							<div class="my_custom_modal_right">
								<div class="input-group mb-3">
									<span class="input-group-text my_custom_modal02">아이디</span> 
									<span id="my_employee_num" class="my_hide"></span>
									<span id="my_id" class="form-control"></span>
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text my_custom_modal02">이메일</span> 
									<span id="my_email" class="form-control"></span>
								</div>
							</div>
							<div class="my_custom_modal_right">
								<div class="input-group mb-3">
									<span class="input-group-text my_custom_modal02">직원명</span> 
									<span id="my_employee_name" class="form-control"></span>
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text my_custom_modal02">비밀번호</span> 
									<input name="my_password" class="form-control">
								</div>
							</div>
							<div class="my_custom_modal_right">
								<div class="input-group mb-3">
									<span class="input-group-text my_custom_modal02">직위</span> 
									<span id="my_job_level" class="form-control"></span>
								</div>
							</div>
					</div>		
						<img class="my_emp_photo" name="my_emp_photo" src="" onerror="$(this).attr('src', '/erpBt/img/employee_photo/image 22.png')"/>
					<div class="row">
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text my_custom_modal02">연락처</span> 
									<span id="my_phone_num" class="form-control"></span>
								</div>
							</div>							
							<div class="left">
								<div class="input-group mb-3">
									<span class="input-group-text my_custom_modal02">입사일</span> 
									<span id="my_hire_date" class="form-control"></span>
								</div>
							</div>
						</div>
					</div> <!-- modal body end -->
				</form>
				<!-- Modal footer -->
				<div class="modal-footer d-flex justify-content-right">
					<p id="my_errorMsg"></p>
					<button type="button" id="my_regPassBtn_chk"class="btn btn-outline-primary">비밀번호 변경하기</button>
					<button type="button" id="my_regPassBtn"class="btn btn-outline-primary">비밀번호 변경완료</button>
					<button type="button" id="close_Btn" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>
