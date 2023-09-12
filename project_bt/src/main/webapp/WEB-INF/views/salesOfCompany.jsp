<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/dong.css">
<meta name="viewport" content="width=device-width, initial-scale=1">


<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- FullCalendar CSS -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css" rel="stylesheet">

<!-- Include Moment.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<!-- Include FullCalendar JS from CDN -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>
<script type="text/javascript">
var calendar;
$(document).ready(function() {
	// 매출조회 클릭 시 modal = Y
    var modal = '${modal}'
    // 키워드가 남아있다면 키워드 return
    var stName = '${stName}'
        
    // 매출조회를 클릭 했을 때
   	if(modal=='Y') {
   		// 검색 처리 후 모달 창 띄움
   		salesOfCompanyByStore(stName)
   		showModal()
   	} else {
   		// 초기 페이지 조회
   		salesOfCompanyByStore("");	
   	}
    
	
    $('#calendarModal').on('shown.bs.modal', function() {
        var calendarEl = document.getElementById('calendar');

        calendar = new FullCalendar.Calendar(calendarEl, {
            locale: 'ko',
            initialView: 'dayGridMonth', 
            
            events: function(info, successCallback, failureCallback){
            	// 매출조회 클릭 시 날린 store_num을 controller를 거쳐서 다시 해당 페이지를 로딩하며
            	// 캘린더의 events에서 el태그로 사용하여 캘린더데 출력될 데이터를 ajax로 가져옴
            	$.ajax({
            		url:"salesDetail",
            		type:"post",
            		data:"store_num=${param.store_num}",
            		dataType:"json",
            		success:function(sdList){
            			var callBack = [];
            			sdList.forEach(function(sd){
            				// sd.title 과 sd.getTitle() 같은 개념
            				// sd.setTitle()의 기능을 함
            				sd.setTitle = function(newTitle) {
            				    this.title = newTitle;
            				};
            				var price = sd.title
            				var fmtPrice = price.toLocaleString();
            				sd.setTitle(fmtPrice+'원')
            				// 매출 데이터의 형태를 변환하여 재할당
            				callBack.push(sd);
            			})
            			// 선택한 점포명
            			var stName = sdList[0].store_name
            			$(".modal-stName").text(stName)
            			
            			var str = $("#fc-dom-1").text()
            			//console.log(str)
            			var year = str.slice(0, 4)
            			var month = str.slice(-3, -1)
            			console.log(stName+' : '+year+' : '+month)
            			
            			salesDetailByMonth(stName,month,year)
            			console.log("달력 데이터 리로딩")
            			successCallback(sdList)
            			
            		},
            		error:function(err){
            			failureCallback(err)
            		}
            		
            	})
            },
            eventDidMount: function(info) {
                var eventTitle = info.el.querySelector('.fc-title');
                if (eventTitle) {
                    eventTitle.style.textAlign = 'right';
                    eventTitle.innerHTML = '1,000,000원';
                }
            }
        	
        });

        calendar.render();
    });
    
	$(".nav-pills .nav-item").on('click',function(){
    	$(".tab-dong").html("");
    	var tab = $(this).text()
    	if(tab.indexOf("점포")!=-1){
    		console.log("점포 누름")
    		salesOfCompanyByStore("");
    		$("#contain").removeClass('container');
    		
    	}
    	if(tab.indexOf("브랜드")!=-1){
    		console.log("브랜드 누름")
    		salesOfCompanyByBrand("");
    		$("#contain").addClass('container');
    	}
    }) 
});

function showModal(){
	$('#calendarModal').modal('show');
}
function showCalendar(stNum){
	var stName = $("input.search").val()
	
	location.href="salesOfCompany?store_num="+stNum+"&store_name="+stName
}
function salesOfCompanyByStore(stName){
	$.ajax({
		url:"salesOfCompanyByStore",
		type:"post",
		data:"store_name="+stName,
		dataType:"json",
		success:function(bsList){
			console.log(bsList)
			var showByStore = 	'<colgroup><col width="12%">'+
						'<col width="12%">'+
						'<col width="20%">'+
						'<col width="17%">'+
						'<col width="22%">'+
						'<col width="17%"></colgroup>'+
						'<tr>'+
						'<th>점포명</th><th>점주</th><th>매출</th><th>전화번호</th><th>주소</th>'+
						'<th><input type="text" class="search" placeholder="점포명" value="'+stName+'"></th>'+
						'</tr>'+
						'<tr class="bottLine"></tr>'
						
			bsList.forEach(function(bs){
				var price = bs.total_price
				var formattedPrice = price.toLocaleString();
				showByStore += '<tr>'
				showByStore += '<td>'+bs.store_name+'</td>'
				showByStore += '<td>'+bs.employee_name+'</td>'
				showByStore += '<td>'+formattedPrice+'원</td>'
				showByStore += '<td>'+bs.contact+'</td>'
				showByStore += '<td>'+bs.city+' '+bs.region+' '+bs.detail_address+'</td>'
				showByStore += '<td><button id="showCal" onclick="showCalendar('+bs.store_num+')" '
				showByStore += 'class="btn btn-secondary">매출조회</button></td>'
				showByStore += '</tr>'
			})
			$(".tab-dong").html(showByStore);
						
			$("input.search").on('keyup',function(){
				console.log("키업")
				if(event.keyCode==13){
					console.log("엔터")
					salesOfCompanyByStore($(this).val())
				}
			})
			
		},
		error:function(err){
			console.log("에러 발생: "+err)
		}
	})
}

function salesOfCompanyByBrand(brName){
	$.ajax({
		url:"salesOfCompanyByBrand",
		type:"post",
		data:"brand_name="+brName,
		dataType:"json",
		success:function(bbList){
			console.log(bbList)
			var showByBrand = '<colgroup><col width="15%">'+
						'<col width="15%">'+
						'<col width="25%">'+
						'<col width="25%">'+
						'<col width="20%">'+
						'<tr>'+
						'<th>브랜드ID</th><th>브랜드명</th><th>월 매출</th><th>연 매출</th>'+
						'<th><input type="text" class="search" placeholder="브랜드명" value="'+brName+'"></th>'+
						'</tr>'+
						'<tr class="bottLine"></tr>'
						
			bbList.forEach(function(bb){
				var mPrice = bb.current_month
				var yPrice = bb.current_year
				var curMonth = mPrice.toLocaleString();
				var curYear = yPrice.toLocaleString();
				
				showByBrand += '<tr>'
				showByBrand += '<td>'+bb.brand_num+'</td>'
				showByBrand += '<td>'+bb.item_name+'</td>'
				showByBrand += '<td>'+curMonth+'원</td>'
				showByBrand += '<td>'+curYear+'원</td>'
				showByBrand += '<td></td>'
				showByBrand += '</tr>'
			})
			$(".tab-dong").html(showByBrand);
						
			$("input.search").on('keyup',function(){
				console.log("키업")
				if(event.keyCode==13){
					console.log($(this).val())
					salesOfCompanyByBrand($(this).val())
				}
			})
		},
		error:function(err){
			console.log("에러 발생: "+err)
		}
	})
}
function salesDetailByMonth(stName, month, year){
	$.ajax({
		url:"salesDetailByMonth",
		type:"post",
		data:"store_name="+stName+"&cur_month="+month+"&cur_year="+year,
		dataType:"json",
		success:function(tot){
			console.log(tot)
			var totPrice = tot.total_price
			var price = totPrice.toLocaleString();
			
			$(".modal-totSale").text(price+"원")
		},
		error:function(err){
			console.log("에러발생: "+err)
		}
	})
	
}


</script>


<div class="container-fluid">
   <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 class="h3 mb-0 text-gray-800">매출관리</h1>
   </div>

   <!-- Content Row -->
   <div class="row">
      <!-- Earnings (Monthly) Card Example -->
		<div class="d-flex justify-content-between align-items-center mb-3">
			<ul class="nav nav-pills">
				<li class="nav-item salesNav"><a class="nav-link active"
					data-bs-toggle="tab" aria-current="page" href="#">점포별</a></li>
				<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
					href="#">브랜드별</a></li>
			</ul>
			<input id="modalBtn" type="hidden" data-bs-toggle="modal" data-bs-target="#calendarModal">
		</div>
	</div>
</div>
<div id="contain" class="container-fluid">
	<div class="row"> 
		<div class="row-dong">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<table class="tab-dong">
						</table>
					</div>
				</div>
			</div>
		</div>
	   <!-- 모달창 생성 -->
	   <div class="container mt-3"></div>   
	   <!-- FullCalendar Modal -->
		<div id="calendarModal" class="modal fade" tabindex="-1" role="dialog">
		    <div class="modal-dialog modal-lg" role="document">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h4 class="modal-stName"></h4>
		                <h6 class="modal-totSale"></h6>
		                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <div class="modal-body" >
		                <div id="calendar" style = "text-align : right;"></div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
   <!-- The Modal -->
</div>
<!-- End of Main Content -->
<%@include file="footer.jsp"%>