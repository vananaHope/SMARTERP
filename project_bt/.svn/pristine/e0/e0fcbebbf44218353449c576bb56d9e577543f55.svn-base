<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css"
	href="/erpBt/css/sb-admin-2.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">




<style>
style>body {
	margin: 40px 10px;
	padding: 0;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 1100px;
	margin: 0 auto;
}

.input-group-text {
	width: 100%;
	text-align: center;
	background-color: #cfffdf;
	color: black;
	font-weight: bolder;
}

.input-group-prepend {
	width: 35%;
}

.store_name {
	display: flex;
	justify-content: space-between;
	margin-right: 15%;
	margin-bottom: -40px;
}

.store_name h3 {
	margin-left: 20%;
	font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	font-weight: bold;
}

.larger-modal {
	max-width: 900px;
}
</style>


<link href='${path}/a00_com/lib/main.css' rel='stylesheet' />
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css">
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src='${path}/a00_com/lib/main.js'></script>
<script src='${path}/a00_com/dist/index.global.js'></script>
<script src='${path}/a00_com/packages/core/locales/ko.global.js'></script>
<!-- 
************************************************************************************************
      jquery & ajax

*************************************************************************************************
 -->
<script>/* 캘린더 ajax / jquery ++++ */
var calendar = null;
   document.addEventListener('DOMContentLoaded', function() {
      var calendarEl = document.getElementById('calendar');
      var toDay = new Date();
      //alert(toDay.toISOString())
      //alert(toDay.toISOString().split("T")[0])
      var toDayTitle = toDay.toISOString().split("T")[0];
      
      calendar = new FullCalendar.Calendar(calendarEl, {
         locale: 'ko',
         headerToolbar : {
            left : 'prev,next today',
            center : 'title',
            right : 'dayGridMonth'
         },
         initialDate : toDayTitle,
         selectable : true,
         selectMirror : true,
         
         select : function(arg) {
            console.log("#일별 매출#")
            var stName = $("h3.stName").text()
           	var saleDate = arg.startStr
            salesDetailByDay(stName,saleDate);
            $("#calTitle").text(saleDate)
            $("#searchInput").val('');
            $("#modal01").click();
            
         },
         eventClick:function(arg){
			console.log("#일별 매출#")
			var stName = $("h3.stName").text()
			var saleDate = arg.event.startStr
			
			salesDetailByDay(stName,saleDate);
			$("#calTitle").text(saleDate)
			$("#searchInput").val('');
			$("#modal01").click();
         },
         editable : true,
         dayMaxEvents : true, // allow "more" link when too many events
         events : function(info, successCallback, failureCallback){
        	 var stNum = "${employee.store_num}"
        	 
        	 $.ajax({
         		url:"salesDetail",
         		type:"post",
         		// 세션의 점포 번호를 받는다
         		data:"store_num="+stNum,
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
         			$("h3.stName").text(stName)
         			
         			var str = $("#fc-dom-1").text()
         			var year = str.slice(0, 4)
         			var month = str.slice(-3, -1)
         			console.log(stName+' : '+year+' : '+month)
         			
         			salesDetailByMonth(stName,month,year)
         			successCallback(sdList)
         		},
         		error:function(err){
         			failureCallback(err)
         		}
         		
         	})
         }
      });
      calendar.render();
      
   });
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
				
				$("h3.totSales").text(price+"원")
			},
			error:function(err){
				console.log("에러발생: "+err)
			}
		})
		
	}
	function salesDetailByDay(stName,sale_date){
		$.ajax({
			url:"salesByDay",
			data:"store_name="+stName+"&sale_date="+sale_date,
			type:"post",
			dataType:"json",
			success:function(sdList){
				console.log(sdList)
				var show = "";
				sdList.forEach(function(sd){
					var cost = (sd.cost).toLocaleString();
					var tot = (sd.total_price).toLocaleString();
					show += '<tr><td>'+sd.brand+'</td>'
					show += '<td>'+sd.item_name+'</td>'
					show += '<td>'+sd.color+'/'+sd.size+'</td>'
					show += '<td>'+cost+'원</td>'
					show += '<td>'+sd.sale_count+'ea</td>'
					show += '<td>'+tot+'원</td></tr>'
				})
				
				$("#searchTableBody").html(show)
				
			},
			error:function(err){
				console.log("에러발생: "+err)
			}
		})
	}
   
</script>
<header>
	<div class="store_name">
		<h3 class="stName">매장입력란</h3>
		<h3 class="totSales">월 매출 : 입력란</h3>
	</div>
</header>
<div class="" style="padding: 35px 5px 10px 5px;">
	<input type="hidden" id="modal01" data-toggle="modal" data-target="#exampleModalCenter">
</div>
<div class="container">
	<div id='calendar'></div>
</div>
<div class="modal fade" id="exampleModalCenter" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalCenterTitle"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered larger-modal"
		role="document" style="max-width: 50%;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="calTitle">일별매출조회</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form class="form" method="post">
					<div class="input-group mb-3" style="max-width: 200px;">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-search"></i>
								검색</span>
						</div>
						<input type="text" id="searchInput" class="form-control"
							placeholder="검색어 입력" autocomplete="off">
					</div>
					<table class="table" style="text-align: center;">
						<thead>
							<tr>
								<th>브랜드</th>
								<th>제품명</th>
								<th>색상/사이즈</th>
								<th>단가</th>
								<th>수량</th>
								<th>판매가</th>
							</tr>
						</thead>
						<tbody id="searchTableBody">
						</tbody>
					</table>
				</form>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<script type=text/javascript>
// 검색 입력을 가져옴
const searchInput = document.getElementById('searchInput');
// 테이블 내 모든 tr행을 가져옴
const searchTableBody = document.getElementById('searchTableBody').getElementsByTagName('tr');

searchInput.addEventListener('input', () => {
   // 검색어를 소문자로 변환하여 저장
    const searchTerm = searchInput.value.toLowerCase();
    
    for (const row of searchTableBody) {
        const rowText = row.textContent.toLowerCase();
        // 검색어를 포함시, 검색 결과 행으로 표시
        if (rowText.includes(searchTerm)) {
            row.style.display = 'table-row';
        } else {
            row.style.display = 'none';
        }
    }
});
</script>

<%@include file="footer.jsp"%>