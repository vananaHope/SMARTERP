<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/dong.css">
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<style>
.tab-dong td:hover{
	cursor:pointer;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		var vm = new Vue({
			el:".card-body",
			data:{storeList:[],
				store_name:"",
				preCity:"",
				selCity:"",
				cityList:[]
		},
			methods:{
				// 초기 화면 전체리스트 및 검색
				search:function(){
					var url = "${path}/storeInfoList?store_name="+this.store_name+
									"&city="+this.selCity;
					this.storeList = []
					var vm = this
					fetch(url).then(function(response){
						return response.json();
					}).then(function(json){
						vm.storeList = json
						this.preCity = this.selCity
						console.log('값 변경')
					}).catch(function(err){
						console.log("# 에러발생")
						console.log(err)
					})
				},
				ckValid:function(){
					console.log("키업")
					if(event.keyCode==13) {
						this.search()
					} 
				},
				panTo:function(lat, lon){
					// 이동할 위도 경도 위치를 생성합니다 
					var moveLatLon = new kakao.maps.LatLng(lat, lon);

					// 지도 중심을 이동시킵니다
					map.panTo(moveLatLon);
					console.log(lat+" : "+lon)
					this.scrollToMap();
				},
				distinctCity:function(){
					url = "${path}/findDistinctCities";
					
					fetch(url).then(function(response){
						console.log(response)
						return response.json();
					}).then(function(json){
						console.log(json)
						vm.cityList = json
					}).catch(function(err){
						console.log("# 에러발생")
						console.log(err)
					})
				},
				scrollToMap:function(){
					window.scrollTo({ top: 0, behavior: "smooth" })
				},
				compareCity:function(){
					if(this.preCity!=this.selCity){
						console.log('이전 값: '+this.preCity)
						console.log('변경 값: '+this.selCity)
						this.store_name = ""
						this.search()
						this.preCity = this.selCity
					}
				}
				
			}
		})
		vm.search();
		vm.distinctCity();
	})
</script>
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">점포 조회</h1>
	</div>

	<!-- Map Row -->
	<div class="row">
		<div class="mapBox">
			<div id="map"></div>
		</div>
	</div>
	<br>
	<!-- Table Row -->
	<div class="row">

		<div class="row-dong">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<table class="tab-dong">
							<col width="15%">
							<col width="25%">
							<col width="30%">
							<col width="10%">
							<col width="10%">
							<tr>
								<th rowspan="2">점포명</th>
								<th rowspan="2">전화번호</th>
								<th rowspan="2">주소</th>
								<th colspan="2">
									<select v-model="selCity" @change="compareCity">
										<option value="">시/도</option>
										<option v-for="ct in cityList" :value="ct">{{ct}}</option>
									</select>
								</th>
							</tr>
							<tr class="bottLine">
								<th colspan="2">
									<input v-model="store_name" @keyup="ckValid" 
													class="search" placeholder="점포명">
								</th>
							</tr>
							<tr v-for="store in storeList" @click="panTo(store.latitude,store.longitude)">
								<td>{{store.store_name}}</td>
								<td>{{store.contact}}</td>
								<td>{{store.city}} {{store.region}} {{store.detail_address}}</td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
							
							

	</div>



	<!-- /.container-fluid -->

</div>
</div>
<!-- End of Main Content -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=230bcf6b8bc92fec214fb4532347d22c"></script>
<script type="text/javascript">
var positions = [];
$(document).ready(function(){
	$.ajax({
		url:"${path}/storeList",
		type:"post",
		dataType:"json",
		success:function(data){
			console.log(data)					
			data.forEach(function(st){
				// console.log(st.store_name)
				positions.push(
						{
							title: st.store_name,
							latlng: new kakao.maps.LatLng(st.latitude, st.longitude)
						})
			})
			console.log("# 정보 담은 후 #")
			console.log(positions)
			ckMarker(positions);
			map.setCenter(options.center)
		},
		error:function(err){
			console.log("등록 에러: "+err)
		}
		
	})
})


var container = document.getElementById('map'); 
var options = { 
	center: new kakao.maps.LatLng(37.4993319491972, 127.03331873237839), 
	level: 4,
	disableDoubleClick:true,
	disableDoubleClickZoom:true
};
var map = new kakao.maps.Map(container, options); 
//map.relayout()
//console.log(options.center)
//console.log(options)
//map.setCenter(options)

// 맵 줌 잠금
map.setZoomable(false);

// 마커를 찍어주는 부분으로 포지션으로 작성한 값의 수만큼 for문 처리
function ckMarker(pos){
	for (var i = 0; i < pos.length; i++) {

		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(24, 35);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			map : map, // 마커를 표시할 지도
			position : pos[i].latlng, // 마커를 표시할 위치
			title : pos[i].title
		// 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		});
		// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		var iwContent = '<div style="padding:5px;align:center;">'+pos[i].title+'</div>', 
			iwPosition = pos[i].latlng; //인포윈도우 표시 위치입니다

		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			position : iwPosition,
			content : iwContent
		});
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker);
	}
}			





</script>

<%@include file="footer.jsp"%>