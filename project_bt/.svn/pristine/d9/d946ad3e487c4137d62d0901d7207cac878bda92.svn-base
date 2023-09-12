<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/dong.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>
<script>
$(document).ready(function(){
	var msg = "${msg}"
	if(msg!=''){
		$("#stFrm")[0].reset();
		location.href="storeManage"
		alert(msg)
	}
	
	/*	var endBlock = ${sch.endBlock}
	var startBlock = ${sch.startBlock}
	if(endBlock == startBlock){
		$('a.page-link').css('pointer-events', 'none');
	} else {
		$('a.page-link').css('pointer-events', 'auto');
	} */

	
	$("input.search").on('keyup',function(){
		if(event.keyCode==13){
			$("#schForm").submit();
		}
	})
	$("#modDelBtn").on('click',function(){
		var stNum = $("input[name=store_num]").val()
		var stName = $("#store_name").val()
		console.log(stNum)
		if(confirm(stName+"을 삭제하시겠습니까?")){
			delStore(stNum)
		}
	})
	$("[name=pageSize]").val("${sch.pageSize}")
	
	$("[name=pageSize]").change(function(){
		$("[name=curPage]").val("1")
		$("#schForm").submit();
	})
})
/* $("#openModal").click(function(){
	map.relayout();
})
 */
function regStModal(){
	$("#stFrm")[0].reset();
	$("#modRegBtn").show();
	$("#modUptBtn").hide();
	$("#modDelBtn").hide();
	$("#mapUptBtn").hide();
	
	kakao.maps.event.addListener(map, 'click', clickHanlder);
	// 점포 등록 시 맵 이동/줌 활성화
	map.setDraggable(true)
	map.setZoomable(true);
	
	$(".storeModal-title").text("점포 등록")
	$("#store_name").attr("readonly",false)
	$("#errorMsg").text("")
	$("#openModal").click();
	
	// 점포 등록 시 맵 초기 위치 
	options = 
		{ 
			center: new kakao.maps.LatLng(37.4993319491972, 127.03331873237839), 
			level: 4
		};
	relayout();
	console.log(options.level)
}

function uptStModal(stNum){
	$("#stFrm")[0].reset();
	
	kakao.maps.event.removeListener(map, 'click', clickHanlder);
	// 점포수정 시 맵 이동/줌 비활성화
	map.setDraggable(false)
	map.setZoomable(false);
	$("#modRegBtn").hide();
	$("#modUptBtn").show();
	$("#modDelBtn").show();
	$("#mapUptBtn").show();
	
	$("#store_name").attr("readonly",true)
	/* $("#city").attr("readonly",true)
	$("#region").attr("readonly",true)
	$("#detail_address").attr("readonly",true) */
	
	$.ajax({
		url:"getStoreByNum",
		type:"post",
		data:"store_num="+stNum,
		dataType:"json",
		success:function(data){
			console.log(data)
			$(".storeModal-title").text("점포 수정(매장번호-"+data.store_num+")")
			$("#store_num").val(data.store_num)
			$("#store_name").val(data.store_name)
			$("#contact").val(data.contact)
			$("#city").val(data.city)
			$("#region").val(data.region)
			$("#detail_address").val(data.detail_address)
			$("#store_area").val(data.store_area)
			$("#latitude").val(data.latitude)
			$("#longitude").val(data.longitude)
			$("#reg_date").val(data.reg_date)
			
			$("#errorMsg").text("")
			$("#openModal").click();
			
			options = 
				{ 
					center: new kakao.maps.LatLng(data.latitude, data.longitude), 
					level: 4
				};
			
			relayout();
			console.log(options.level)
		},
		error:function(err){
			console.log("에러발생: "+err)
		}
	})
}
function delStore(stNum){
	$.ajax({
		url:"deleteStore",
		data:"store_num="+stNum,
		type:"post",
		dataType:"text",
		success:function(msg){
			$("input.search").val("")
			$("#schForm").submit();
			alert(msg)
			$("#modClsBtn").click
		},
		error:function(err){
			console.log("에러발생: "+err)
		}
	})
}
function goPage(cnt){
	$("[name=curPage]").val(cnt)
	$("#schForm").submit();
}
function ckSearch(){
	// 검색시, 전체 페이지 갯수가 검색시 달라지기에
	// 	입력 후, 검색시는 현재페이지번호를 초기값으로 1로 설정
	var store_name = "${sch.store_name}"				
	var store_nameVal = $("[name=store_name]").val()
	if(store_name!=store_nameVal)
		$("[name=curPage]").val("1")
}

</script>
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">점포 리스트</h1>
	</div>

	<!-- Table Row -->
	<form id="schForm" onsubmit="ckSearch()">
	<div class="row">
		<div class="col-dong">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<input type="hidden" id="openModal" data-bs-toggle="modal" data-bs-target="#stManageModal"></input>
						<table class="tab-dong">
							<col width="15%">
							<col width="10%">
							<col width="10%">
							<col width="15%">
							<col width="25%">
							<col width="10%">
							<col width="15%">
							<tr>
								<th rowspan="2">점포명</th>
								<th rowspan="2">점주</th>
								<th rowspan="2">직원 수</th>
								<th rowspan="2">전화번호</th>
								<th rowspan="2">주소</th>
								<th rowspan="2">면적</th>
								<th>
									<button type="button" onclick="regStModal()" class="btn btn-info">신규등록</button>
								</th>
							</tr>
							<tr class="bottLine">
								<th>
									<a class="resetSch" href="${path}/storeManage">
										<i class="fa-solid fa-repeat fa-sm"></i>
									</a>
									<input type="hidden" name="curPage" value="${sch.curPage}" />
									<input type="text" class="search" name="store_name" 
															placeholder="점포명" value="${sch.store_name}">
								</th>
							</tr>
							<c:forEach var="st" items="${storeList}">
								<tr>
									<td>${st.store_name}</td>
									<td>${st.stKeeper}</td>
									<td>${st.stEmpCnt}</td>
									<td>${st.contact}</td>
									<td>${st.city} ${st.region} ${st.detail_address}</td>
									<td>${st.store_area} ㎡</td>
									<td><button type="button" class="btn btn-outline-warning"
										 onclick="uptStModal(${st.store_num})">수정</button></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>

	</div>
	<div class="row paging">
		<div class="col-md-6">
			<select name="pageSize" class="form-control">
				<option>3</option>
				<option>5</option>
				<option>10</option>
				<option>20</option>
			</select>
		</div>
		
		<div class="col-md-6">
			<ul class="pagination justify-content-end">
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
		</div>
	</div>
	</form>
	<div class="modal" id="stManageModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="storeModal-title">매장 등록</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<form id="stFrm" class="form" novalidate="">
					<div class="modal-body">
						<div class="row">
							<div class="col-md-12">
								<div class="input-group mb-3">
									<span class="input-group-text">*매장명</span> 
										<input type="hidden" id="store_num" name="store_num" value="">
										<input type="text" id="store_name" name="store_name" class="form-control" placeholder="매장명 입력" value="">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="input-group mb-3">
									<span class="input-group-text">*전화번호</span> 
										<input type="text" id="contact" name="contact" class="form-control" placeholder="-없이 번호만 입력" value="">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text">*시/도</span> 
										<input type="text" id="city" name="city" class="form-control" placeholder="시/도 입력" value="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text">*군/구</span> 
										<input type="text" id="region" name="region" class="form-control" placeholder="군/구 입력" value="">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="input-group mb-3">
									<span class="input-group-text">*상세주소</span> 
										<input type="text" id="detail_address" name="detail_address" class="form-control" placeholder="상세주소 입력" value="">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text">*매장면적</span> 
										<input type="number" id="store_area" name="store_area" class="form-control" placeholder="매장면적 입력(㎡)" value="" max="999">
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text">등록일자</span> 
										<input type="text" id="reg_date" class="form-control" value="" disabled>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="mapBox">
								<div id="map"></div>
								<button type="button" id="mapUptBtn" class="btn btn-primary">위치 수정</button>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text">위도</span> 
										<input type="number" id="latitude" name="latitude" class="form-control" placeholder="위도 입력" readonly>
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text">경도</span> 
										<input type="number" id="longitude" name="longitude" class="form-control" placeholder="경도 입력" readonly>
								</div>
							</div>
						</div>
					</div> <!-- modal body end -->
					<!-- Modal footer -->
					<div class="modal-footer d-flex justify-content-right">
						<p id="errorMsg"></p>
						<button type="submit" id="modRegBtn" class="btn btn-outline-primary">등록</button>
						<button type="submit" id="modUptBtn" class="btn btn-outline-success">수정</button>
						<button type="button" id="modDelBtn" class="btn btn-outline-danger">삭제</button>
						<button type="button" id="modClsBtn" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					</div>
				</form>

			</div>
		</div>
	</div>


	<!-- /.container-fluid -->

</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=230bcf6b8bc92fec214fb4532347d22c"></script>
<script type="text/javascript">
	var container = document.getElementById('map'); 
	var options = { 
		center: new kakao.maps.LatLng(33.450701, 126.570667), 
		level: 4,
		disableDoubleClick:true,
		disableDoubleClickZoom:true
	};
	var map = new kakao.maps.Map(container, options); 
	map.relayout()
	
	console.log(options.center)

	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new kakao.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	
	var clickHanlder = function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	    
	    $("#latitude").val(latlng.getLat())
	    $("#longitude").val(latlng.getLng())
	    
	}

	kakao.maps.event.addListener(map, 'click', clickHanlder);
	

	function relayout(){
		map.relayout()
		map.setCenter(options.center)
		marker.setPosition(options.center)
	}

	
	var isUpt = false;
	
	$("#mapUptBtn").click(function(){
		isUpt = !isUpt;
        map.setDraggable(isUpt);
        map.setZoomable(isUpt);
        
        if (isUpt) {
            $(this).removeClass('btn-primary').addClass('btn-outline-primary').text("점포 위치 수정");
            kakao.maps.event.addListener(map, 'click', clickHanlder);
        } else {
            $(this).removeClass('btn-outline-primary').addClass('btn-primary').text("위치 수정");
            kakao.maps.event.removeListener(map, 'click', clickHanlder);
        }
    });


var url = "";
$(document).ready(function() {
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
	
	$.validator.addMethod("regex", function(value, element, regexp) {
	    var regExp = new RegExp(regexp);
	    return regExp.test(value);
	});
	
	$("#stFrm").validate({
		focusCleanup:true,
		rules: {
			store_name:{
				required:true
			},
			contact:{
				required:true,
				regex:/^0\d{1,2}-\d{3,4}-\d{4}$/
			},
			city:{
				required:true,
				regex:/^.{2}$/
			},
			region:{
				required:true
			},
			detail_address:{
				required:true
			},
			store_area:{
				number:true,
				required:true,
				min:true,
				maxlength:3
			},
			latitude:{
				required:true,
			},
			longitude:{
				required:true,
			}
			
		},
		messages:{
			store_name:{
				required: "매장명 입력 필수"
			},
			contact:{
				required: "전화번호 입력 필수",
				regex: "전화번호 형식을 확인해주세요."
			},
			city:{
				required: "시/도 입력 필수",
				regex: "-시, -도를 제외합니다."
			},
			region:{
				required: "군/구 입력 필수"
			},
			detail_address:{
				required: "상세주소 입력 필수"
			},
			store_area:{
				number:"매장면적/위도/경도는 숫자입니다.",
				required: "매장면적 입력 필수",
				min:"1보다 작은 값은 입력 불가",
				maxlength:"매장 면적은 999평 이하 입력"
			},
			latitude:{
				required:"점포 위치를 맵에서 선택하세요."
				
			},
			longitude:{
				required:"점포 위치를 맵에서 선택하세요."
			}
		},
		submitHandler:function(form){
			$("#errorMsg").text("")
			console.log("submit핸들러 입성")
			
			if(!$("#store_name").prop("readonly")){
				url = "insertStore"
			}
			if($("#store_name").prop("readonly")){
				url = "updateStore"
			}
			$("#stFrm").attr("action",url)
			form.submit();
		}
	})
	
	$("input[name=contact]").on("input", function(){
		var contact = $(this).val().replace(/\D/g,"");
		if(contact.length>=3&&contact.charAt(1)==2){ // 지역번호 02일 경우
			contact=contact.substring(0,2)+"-"+contact.substring(2);
			if(contact.length>=8){
				contact=contact.substring(0,7)+"-"+contact.substring(7,11);
			}
		
		} else if (contact.length>=4){
			contact=contact.substring(0,3)+"-"+contact.substring(3);
			if(contact.length>=9){
				contact=contact.substring(0,8)+"-"+contact.substring(8,12);
			}
		}
		
		$(this).val(contact);
	});
	$("input[name=store_area]").on('input',function(){
		var stName = $(this).val()
		if(stName.indexOf(/\D/g)){
			stName.replace(/\D/g,"")
			$(this).val(stName)
		}
		if(stName.length>=4){
			var subSt = stName.substring(0,4)
			$(this).val(subSt)
		}
	})
	$("input[name=store_name]").on("input", function(){
		var inputValue = $(this).val();
		if (inputValue.startsWith(" ")) {
		    inputValue = inputValue.replace(/^ +/, '');
		}
		$(this).val(inputValue);
    });
});

</script>
<!-- End of Main Content -->

<%@include file="footer.jsp"%>