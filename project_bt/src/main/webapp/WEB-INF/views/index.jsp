<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/dong.css">

<style>
#brandName i{
	padding-right: 3px;
}
#brandName span{
	display:inline-block;
	margin:auto;
	padding-right: 3px;
	width: 17%;
	text-align: left;
}
</style>

<!-- Begin Page Content -->
   <div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
	</div>

	<!-- Content Row -->
	<div class="row">

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-3 mb-4">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xl font-weight-bold text-primary text-uppercase mb-1">총 직원 수</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800">${emp}</div>
						</div>
						<div class="col-auto">
							<i class="fa-solid fa-user-tie fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-3 mb-4">
			<div class="card border-left-success shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xl font-weight-bold text-success text-uppercase mb-1">총 점포 수</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800">${store}</div>
						</div>
						<div class="col-auto">
							<i class="fa-solid fa-store fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<div class="col-xl-3 col-md-3 mb-4">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xl font-weight-bold text-info text-uppercase mb-1">입점 브랜드</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800">${brand}</div>
						</div>
						<div class="col-auto">
							<i class="fa-solid fa-bookmark fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Pending Requests Card Example -->
		<div class="col-xl-3 col-md-3 mb-4">
			<div class="card border-left-warning shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xl font-weight-bold text-warning text-uppercase mb-1">총 상품</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800">${item}</div>
						</div>
						<div class="col-auto">
							<i class="fa-solid fa-boxes-stacked fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Content Row -->

	<div class="row">

		

		<!-- Pie Chart -->
		<div class="col-xl-4 col-lg-3">
			<div class="card shadow mb-4">
				<!-- Card Header - Dropdown -->
				<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
					<h6 class="m-0 font-weight-bold text-primary">브랜드별 판매량</h6>
				</div>
				<!-- Card Body -->
				<div class="card-body">
					<div class="chart-pie pt-4 pb-2">
						<canvas id="pieChart"></canvas>
					</div>
					<div id="brandName" class="mt-4 text-center small"></div>
				</div>
			</div>
		</div>
		<div class="col-xl-4 col-lg-3">
			<div class="card shadow mb-4">
				<!-- Card Header - Dropdown -->
				<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
					<h6 class="m-0 font-weight-bold text-primary">입고 브랜드</h6>
				</div>
				<!-- Card Body -->
				<div class="card-body">
					
					<div class="row no-gutters"
									style="height:320px; align-items:flex-start;overflow:auto;">
						<table class="tab-dong-dbd">
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<thead>
								<tr>
									<th rowspan="2">No</th>
									<th colspan="2">브랜드명</th>
									<th colspan="2">상품종류</th>
								</tr>
								<tr>
									<th colspan="4">
										<input type="text" class="search" name="brand" placeholder="검색">
									</th>
								</tr>
							</thead>
							<tbody id="brandInfoList">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-4 col-lg-3">
			<div class="card shadow mb-4">
				<!-- Card Header - Dropdown -->
				<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
					<h6 class="m-0 font-weight-bold text-primary">발주 일정</h6>
				</div>
				<!-- Card Body -->
				<div class="card-body">
					<div class="row no-gutters align-items-center"
							style="height:320px; overflow:auto;">
						<table class="tab-dong-dbd-order">
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<thead>
								<tr>
									<th>점포명</th>
									<th colspan="2">상품코드</th>
									<th colspan="2">납기예정일</th>
								</tr>
							</thead>
							<tbody id="orderLatest">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Content Row -->
       <div class="row">
			<!-- Area Chart -->
			<div class="col-lg-6">
				<div class="card shadow mb-4">
					<!-- Card Header - Dropdown -->
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
						<h6 class="m-0 font-weight-bold text-primary">기간별 판매액</h6>
					</div>
					<!-- Card Body -->
					<div class="card-body">
						<div class="chart-area">
							<canvas id="lineChart"></canvas>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="card shadow mb-4">
					<!-- Card Header - Dropdown -->
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
						<h6 class="m-0 font-weight-bold text-primary">점포 별 판매액</h6>
					</div>
					<!-- Card Body -->
					<div class="card-body">
						<div class="chart-area">
							<canvas id="barChart"></canvas>
						</div>
					</div>
				</div>
			</div>
		</div>

   </div>
   <!-- /.container-fluid -->

</div>
<!-- End of Main Content -->
<script src="${path}/erpBt/vendor/chart.js/Chart.min.js"></script>
<script>
//chart js(선그래프)
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

$(document).ready(function() {
	$("input[name='brand']").keyup(function(){
		if(event.keyCode==13){
			console.log("엔터")
			brandByBrandNum($(this).val())
		}
	})
	$('.benefit').each(function() {
		var priceElement = $(this);
		var priceText = priceElement.text();
		var formattedPrice = number_format(priceText);
		priceElement.text('￦' + formattedPrice);
	});
	saleCntByBrand();
	totSaleByMonth();
	totSaleByStore();
	orderEndDateDesc();
	brandByBrandNum("");
});
function getRandomColor() {
	const letters = '0123456789ABCDEF';
	let color = '#';
	for (let i = 0; i < 6; i++) {
	  color += letters[Math.floor(Math.random() * 16)];
	}
	return color;
}
// 도넛 차트
function saleCntByBrand(){
	$.ajax({
		url:"saleCntByBrand",
		type:"post",
		dataType:"json",
		success:function(data){
			var brandNames = [];
			var brandCnts = [];
			var bgColors = [];
			var show = "";
			console.log(data)
			data.forEach(function(d){
				brandNames.push(d.brand)
				brandCnts.push(d.sale_cnt)
				var color = getRandomColor()
				bgColors.push(color);
				show += '<span class="mr-2">'
				show += '<i class="fas fa-circle" style="color:'+color+'"></i>'+d.brand
				show += '</span>'
			})
			var ctx = document.getElementById("pieChart");
			var myPieChart = new Chart(ctx, {
			  type: 'doughnut',
			  data: {
			    labels: brandNames,
			    datasets: [{
			      data: brandCnts,
			      backgroundColor: bgColors,
			      hoverBorderColor: "rgba(234, 236, 244, 1)",
			    }],
			  },
			  options: {
			    maintainAspectRatio: false,
			    tooltips: {
			      backgroundColor: "rgb(255,255,255)",
			      bodyFontColor: "#858796",
			      borderColor: '#dddfeb',
			      borderWidth: 3,
			      xPadding: 15,
			      yPadding: 15,
			      displayColors: false,
			      caretPadding: 10,
			    },
			    legend: {
			    	labels:{
			    		boxWidth: 18,
			    		fontSize: 12
			    	},
			      display: true,
			      position: 'right'
			    },
			    cutoutPercentage: 50,
			  },
			});
		},
		error:function(err){
			console.log("에러발생: "+err)
		}
	})
}

// 선 차트
function totSaleByMonth(){
	$.ajax({
		url:"totSaleByMonth",
		type:"post",
		dataType:"json",
		success:function(data){
			var monthLabel = [];
			var totPrice = [];
			console.log(data)
			data.forEach(function(d){
				monthLabel.push(d.sale_date)
				totPrice.push(d.total_price)
			})
			
			
			var ctx = document.getElementById("lineChart");
			var myLineChart = new Chart(ctx, {
			  type: 'line',
			  data: {
			    labels: monthLabel,
			    datasets: [{
			      label: "Earnings",
			      lineTension: 0.3,
			      backgroundColor: "rgba(78, 115, 223, 0.05)",
			      borderColor: "rgba(78, 115, 223, 1)",
			      pointRadius: 3,
			      pointBackgroundColor: "rgba(78, 115, 223, 1)",
			      pointBorderColor: "rgba(78, 115, 223, 1)",
			      pointHoverRadius: 3,
			      pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
			      pointHoverBorderColor: "rgba(78, 115, 223, 1)",
			      pointHitRadius: 10,
			      pointBorderWidth: 2,
			      data: totPrice
			    }],
			  },
			  options: {
			    maintainAspectRatio: false,
			    layout: {
			      padding: {
			        left: 10,
			        right: 25,
			        top: 25,
			        bottom: 0
			      }
			    },
			    scales: {
			      xAxes: [{
			        time: {
			          unit: 'date'
			        },
			        gridLines: {
			          display: false,
			          drawBorder: false
			        },
			        ticks: {
			          maxTicksLimit: 7
			        }
			      }],
			      yAxes: [{
			        ticks: {
			          maxTicksLimit: 5,
			          padding: 10,
			          // Include a dollar sign in the ticks
			          callback: function(value, index, values) {
			            return '￦' + number_format(value);
			          }
			        },
			        gridLines: {
			          color: "rgb(234, 236, 244)",
			          zeroLineColor: "rgb(234, 236, 244)",
			          drawBorder: false,
			          borderDash: [2],
			          zeroLineBorderDash: [2]
			        }
			      }],
			    },
			    legend: {
			      display: false
			    },
			    tooltips: {
			      backgroundColor: "rgb(255,255,255)",
			      bodyFontColor: "#858796",
			      titleMarginBottom: 10,
			      titleFontColor: '#6e707e',
			      titleFontSize: 14,
			      borderColor: '#dddfeb',
			      borderWidth: 1,
			      xPadding: 15,
			      yPadding: 15,
			      displayColors: false,
			      intersect: false,
			      mode: 'index',
			      caretPadding: 10,
			      callbacks: {
			        label: function(tooltipItem, chart) {
			          var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
			          return datasetLabel + ': ￦' + number_format(tooltipItem.yLabel);
			        }
			      }
			    }
			  }
			});
		},
		error:function(err){
			console.log("에러발생: "+err)
		}
	})
}
function totSaleByStore(){
	$.ajax({
		url:"totSaleByStore",
		type:"post",
		dataType:"json",
		success:function(data){
			console.log(data)
			var storeLabels = [];
			var storeData = [];
			
			data.forEach(function(d){
				storeLabels.push(d.store_name)
				storeData.push(d.total_price/10000)
			})
         				
         				
			var ctx = document.getElementById('barChart')
			var chart = new Chart(ctx, {
			    type: 'bar',
			    data: {
			        labels: storeLabels,
			        datasets: [{
			            label: '점포별 총매출',
			            data: storeData,
			            backgroundColor: 'rgba(54, 162, 235, 0.2)',
			           	barThickness: 20,
			            borderColor: 'rgb(54, 162, 235)',
			            borderWidth: 2
			          }]
			    },
			    options: {
			    	maintainAspectRatio: false,
			    	scales: {//x,y축 설정
			            yAxes: [{
			                ticks: {
			                    stepSize: 250, //y축 간격
			                    suggestedMin: 0,//y축 최소 값
			                    suggestedMax: 1000,//y축 최대값
			                 	// Include a dollar sign in the ticks
								callback: function(value, index, values) {
								  return '￦' + number_format(value);
								}
			                },
			                gridLines: {//y축 라인 스타일 설정
			                    borderDash: [2, 2],
			                    borderDashOffset: 0.2
			                },
			                scaleLabel:{
			                	display:true,
			                	labelString: "총매출(10,000원)"
			                }			                
			            }],
			            xAxes: [{//x축 설정
			            	gridLines: {
			                    display: false,
			                    color: "black"
			                  }
			            }],
			            
			        }
			    }
			}); 
		},
		error:function(err){
			console.log("에러발생: "+err)
		}
	})
}
function orderEndDateDesc(){
	$.ajax({
		url:"orderEndDateDesc",
		type:"post",
		dataType:"json",
		success:function(data){
			var show = ""
			
			data.forEach(function(d){
				show += "<tr><td>"+d.store_name+"</td>" 
				show += "<td colspan='2'>"+d.item_name+"-"+d.color+"/"+d.size+"</td>" 
				show += "<td colspan='2'>"+d.end_date+"</td></tr>"
			})
			$("#orderLatest").html(show)
		},
		error:function(err){
			console.log("에러발생: "+err)
		}
		
	})
}
function brandByBrandNum(brand){
	$.ajax({
		url:"brandByBrandNum",
		type:"post",
		data:"brand="+brand,
		dataType:"json",
		success:function(data){
			var show = "";
			data.forEach(function(d){
				show += "<tr><td>"+d.brand_num+"</td>"
				show += "<td colspan='2'>"+d.brand+"</td>"
				show += "<td colspan='2'>"+d.cnt+"</td></tr>"
			})
			$("#brandInfoList").html(show)
		},
		error:function(err){
			console.log("에러발생: "+err)
		}
	})
}

function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}

// Area Chart Example

// 바형 차트


		// chart js(도넛 그래프)


</script>
<%@include file="footer.jsp"%>