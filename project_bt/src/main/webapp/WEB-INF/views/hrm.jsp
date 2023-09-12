<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/hrm.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	main()
	selectOption()
	schKeyWord()
	
	$("[name=pageSize]").change(function(){
		$("[name=curPage]").val("1")
		hrmSearch()
	})
	
	$("[name=schWord]").on("keyup", function(event) {
		if(event.keyCode == 13){
			hrmSearch()
			$("[name=schWord]").focus()
		}
		
    });
	
	$("#myModal01").on("show.bs.modal", function(event){	
		$("[name=employee_num]").prop("disabled", true)
		setSelect("#myModal01")
		$("#errorMsg01").html("");
	});
	
	
	$("#myModal02").on("show.bs.modal", function(event){
		 $("[name=employee_name]").val("")
		 $("[name=email]").val("")
		 $("[name=phone_num]").val("")
		 $("#errorMsg02").html("");
		 $("#myModal02 [name=employee_photo]").val("");
		 $("[name=emp_photo]").attr('src', '/erpBt/img/employee_photo/image 22.png')
		 $("[name=store_num]").prop("selectedIndex", 0)
		 $("[name=store_name]").prop("selectedIndex", 0)
		 $("[name=job_level]").prop("selectedIndex", 0)
		 $("[name=hire_type]").prop("selectedIndex", 0)
		 $("[name=hire_date]").val(new Date().toISOString().split("T")[0])
		 setSelect("#myModal02")
	});
	
	$("#prm_regBtn").click(function(){
		if($("#modalForm02").valid()&&confirm($("#myModal02 [name=store_name]").val()+"의 "+$("#myModal02 [name=employee_name]").val()+" "
				+$("#myModal02 [name=job_level]").val()+"의 신규 등록을 완료 하시겠습니까?")){
			regNew();
		}
	});
	$("#prm_uptBtn").click(function(){
		if($("#modalForm01").valid()&&confirm($("#myModal01 [name=store_name]").val()+"의 "+$("#myModal01 [name=employee_name]").val()+" "
				+$("#myModal01 [name=job_level]").val()+"의 정보를 수정 하시겠습니까?")){
			uptNew();
		}
	});
	$("#prm_delBtn").click(function(){
		if(confirm($("#myModal01 [name=store_name]").val()
				+"의 "+$("#myModal01 [name=employee_name]").val()+" "
				+$("#myModal01 [name=job_level]").val()+"의 정보를 삭제 하시겠습니까?")){
			delEmp();
		}
	});
	$("#reg_PassBtn_chk").click(function(){
		$("#reg_PassBtn_chk").hide();
		$("[name=password]").prop("readonly",false)
		$("#reg_PassBtn").show();
		
	});
	$("#reg_PassBtn").click(function(){
		if($("#modalForm03").valid()&&confirm($("#myModal01 [name=store_name]").val()+"의 "+$("#myModal01 [name=employee_name]").val()+" "
				+$("#myModal01 [name=job_level]").val()+"의 비밀번호를 수정 하시겠습니까?")){
			change_pass()
		}
	});
	
});

function main(){
	$.ajax({
		type:"post",
		url:"${path}/prmsch",
		data:{
			schType : $("[name=schType]").val(),
			schWord : $("[name=schWord]").val()
		},
		dataType:"json",
		success:function(data){
			var emplist = ""
			data.prm_list.forEach(function(prm_empList){
				emplist+="<tr>"
				emplist+="<td>"+prm_empList.employee_num+"</td>"
				emplist+="<td>"+prm_empList.employee_name+"</td>"
				emplist+="<td>"+prm_empList.store_name+"</td>"
				emplist+="<td>"+prm_empList.job_level+"</td>"
				emplist+="<td>"+prm_empList.phone_num+"</td>"
				emplist+="<td>"+new Date(prm_empList.hire_date).toLocaleDateString()+"</td>"
				if(prm_empList.resignation_day==null||prm_empList.resignation_day==""){
					emplist+="<td></td>"
				}else{
					emplist+="<td>"+new Date(prm_empList.resignation_day).toLocaleDateString()+"</td>"
				}
				emplist+="<td><div class='butmod-hak1'>"
				emplist+="<button class='btn' data-bs-toggle='modal' data-bs-target='#myModal01' onclick='employeeDetail("+prm_empList.employee_num+")'>"
				emplist+="상세정보"+"</button></div></td>"
				emplist+="</tr>"
			})
				
				
				$("#count").html("현재 검색 건 : "+data.prmsch.count+"건")
			
	            var pagination = '<nav aria-label="Page navigation example"><ul class="pagination justify-content-center mt-2">';
	            pagination += '<li class="page-item"><a class="page-link" id="previous" href="javascript:goPage('+(data.prmsch.startBlock-1)+')">Previous</a></li>';
	            for (var cnt = data.prmsch.startBlock; cnt <= data.prmsch.endBlock; cnt++) {
	                pagination += '<li class="page-item '+(data.prmsch.curPage==cnt?'active':'')+'"><a class="page-link" href="javascript:goPage('+cnt+')">'+cnt+'</a></li>';
	            }
	            pagination += '<li class="page-item"><a class="page-link" id="next" href="javascript:goPage('+(data.prmsch.endBlock+1)+')">Next</a></li>';
	            pagination += '</ul></nav>';
	            
	            if (data.prm_list.length > 0) {
	            	$("#employee_list").html(emplist);
	                $("#pageMoving").html(pagination);
	            } else {
	            	$("#employee_list").empty();
	            	$("#pageMoving").empty();
	            }
	            
	            $("#pageMoving").html(pagination);
	            
	            $("[name=curPage]").val(data.prmsch.curPage)
		},
		error:function(err){
			console.log(err)
		}
	});
}

function hrmSearch(){
	
	$.ajax({
		type:"post",
		url:"${path}/prmsch",
		data:{
			schType : $("[name=schType]").val(),
			schWord : $("[name=schWord]").val(),
			pageSize : $("[name=pageSize]").val(),
			curPage : $("[name=curPage]").val()
		},
		dataType:"json",
		success:function(data){
			var emplist = ""
			//$("#employee_list").html("")
			$("#employee_list").empty()
			$("#pageMoving").empty()
			data.prm_list.forEach(function(prm_empList){
				emplist+="<tr>"
				emplist+="<td>"+prm_empList.employee_num+"</td>"
				emplist+="<td>"+prm_empList.employee_name+"</td>"
				emplist+="<td>"+prm_empList.store_name+"</td>"
				emplist+="<td>"+prm_empList.job_level+"</td>"
				emplist+="<td>"+prm_empList.phone_num+"</td>"
				emplist+="<td>"+new Date(prm_empList.hire_date).toLocaleDateString()+"</td>"
				if(prm_empList.resignation_day==null||prm_empList.resignation_day==""){
					emplist+="<td></td>"
				}else{
					emplist+="<td>"+new Date(prm_empList.resignation_day).toLocaleDateString()+"</td>"
				}
				emplist+="<td><div class='butmod-hak1'>"
				emplist+="<button class='btn' data-bs-toggle='modal' data-bs-target='#myModal01' onclick='employeeDetail("+prm_empList.employee_num+")'>"
				emplist+="상세정보"+"</button></div></td>"
				emplist+="</tr>"
			})
				
				$("#count").html("현재 검색 건 : "+data.prmsch.count+"건")
				
				<!--
				$("[name=curPage]").val(data.prmsch.curPage)
				-->
				$("[name=curPage]").val("1")
					
					
	            var pagination = '<nav aria-label="Page navigation example"><ul class="pagination justify-content-center mt-2">';
	            pagination += '<li class="page-item"><a class="page-link" id="previous" href="javascript:goPage('+(data.prmsch.startBlock-1)+')">Previous</a></li>';
	            for (var cnt = data.prmsch.startBlock; cnt <= data.prmsch.endBlock; cnt++) {
	                pagination += '<li class="page-item '+(data.prmsch.curPage==cnt?'active':'')+'"><a class="page-link" href="javascript:goPage('+cnt+')">'+cnt+'</a></li>';
	            }
	            pagination += '<li class="page-item"><a class="page-link" id="next" href="javascript:goPage('+(data.prmsch.endBlock+1)+')">Next</a></li>';
	            pagination += '</ul></nav>';
	            
	            if (data.prm_list.length > 0) {
	            	$("#employee_list").html(emplist);
	                $("#pageMoving").html(pagination);
	            } else {
	            	$("#employee_list").empty();
	            	$("#pageMoving").empty();
	            }
	            
		},
		error:function(err){
			console.log(err)
		}
	});
}

function goPage(cnt) {
	$("[name=curPage]").val(cnt)
	hrmSearch()
}

function schKeyWord(){
		schTypeVal = $("[name=schType]").val()
		schWordVal = $("[name=schWord]").val()
	$("[name=schType]").change(function(){
		$("[name=curPage]").val("1")
		$("[name=schWord]").val("")
		index = $(this).prop("selectedIndex");
		$("[name=schWord]").on("input", function(){
			var inputData = $("[name=schWord]").val().replace(/\D/g,"");
			if(index>=7){
				if(inputData.length>=4){
					if(inputData.substring(0,2)=="20"){
						inputData=inputData.substring(0,4)+"-"+inputData.substring(4);
					}else{
						inputData=inputData.substring(0,2)+"-"+inputData.substring(2);
					}
				}
				if(inputData.length>=8){
					inputData=inputData.substring(0,7)+"-"+inputData.substring(7,9);
				}
				$(this).val(inputData);
			}else if(index>=5){
				if(inputData.length>=5){
					inputData=inputData.substring(0,4)
				}
				$(this).val(inputData);
			}else if(index==4){
				var phonenum = $(this).val().replace(/\D/g,"");
				if(phonenum.substring(0,3)=="010"&&phonenum.length>4){
				  phonenum=phonenum.substring(0,3)+"-"+phonenum.substring(3);
				}
				if(phonenum.length>=8){
					if(phonenum.substring(0,3)=="010"){
						phonenum=phonenum.substring(0,8)+"-"+phonenum.substring(8,12);
					}else{
						phonenum=phonenum.substring(0,4)+"-"+phonenum.substring(4,8);
					}
				}
				  $(this).val(phonenum);
			}else if (index<4){
			}
		});
	});
}
function regNew(){
	$.LoadingOverlay("show")
	$.ajax({
		type:"post",
		url:"${path}/insertEmployee",
		data:{	
				store_num : $("#myModal02 [name=store_num]").val(),
				employee_name : $("#myModal02 [name=employee_name]").val(),
				email : $("#myModal02 [name=email]").val(),
				phone_num : $("#myModal02 [name=phone_num]").val(),
				job_level : $("#myModal02 [name=job_level]").val(),
				hire_date : $("#myModal02 [name=hire_date]").val(),
				hire_type : $("#myModal02 [name=hire_type]").val(),
				auth : $("#myModal02 [name=auth]").val()
			},
		dataType:"text",
		success:function(data){
			console.log(data)
			if($("#myModal02 [name=employee_photo]").val()!=""){
				console.log("사진값 : "+$("#myModal02 [name=employee_photo]").val())
				uploadFile("#myModal02", data)
				$.LoadingOverlay("hide")
				alert("신규 직원 등록이 완료되었습니다\n직원 이름 : "+$('#myModal02 [name=employee_name]').val())
				$("#myModal02").modal("hide");
				hrmSearch()
				schKeyWord()
			}else{
				$.LoadingOverlay("hide")
				alert("신규 직원 등록이 완료되었습니다\n직원 이름 : "+$('#myModal02 [name=employee_name]').val()+
						"\n사진을 등록하지 않으셨습니다.\n현재 사진이 없을 경우, 추후에 수정 바랍니다.")
				$("#myModal02").modal("hide");
				hrmSearch()
				schKeyWord()
			}
		},
		error:function(err){
			console.log(err)
		}
	});
};

function change_pass(){
	$.ajax({
		type:"post",
		url:"${path}/uptPass",
		data:{
			employee_num : $("#myModal01 [name=employee_num]").val(),
			password: $("#myModal01 [name=password]").val()
			},
		dataType:"text",
		success:function(data){
			alert("비밀번호가 변경 완료되었습니다!")
		},
		error:function(err){
			alert("비밀번호 변경 실패!!")
		}
	})
};

function selectOption(){
	var snum="";
	var sname="";
	$.ajax({
		type:"post",
		url:"${path}/prm_getStoreName",
		dataType:"json",
		success:function(data){
			data.forEach(function(prm_store){
			console.log(prm_store)
				snum += "<option value='"+prm_store.store_num+"'>"+prm_store.store_num+"</option>"
				sname += "<option value='"+prm_store.store_name+"'>"+prm_store.store_name+"</option>"
			});
			$("[name=store_num]").append(snum)
			$("[name=store_name]").append(sname)
			console.log(snum)
			console.log(sname)
		},
		error:function(err){
			console.log(err)
		}
	});
};

function employeeDetail(hrm_employee_num){
	$.ajax({
		type:"post",
		url:"${path}/empDetail",
		data:{employee_num : hrm_employee_num},
		dataType:"json",
		success:function(data){
			var hiredate = new Date(data.hire_date);
			var offset01 = hiredate.getTimezoneOffset()*60000;
			console.log("뺼 값 1 : "+offset01)
			var resignation = new Date(data.resignation_day);
			var offset02 = resignation.getTimezoneOffset()*60000;
			console.log("뺼 값 2 : "+offset02)
			
			$("#myModal01 [name=employee_num]").val(data.employee_num)	
			$("#myModal01 [name=hrm_id]").val(data.id)	
			$("#myModal01 [name=employee_name]").val(data.employee_name)		
			$("#myModal01 [name=store_num]").val(data.store_num)		
			$("#myModal01 [name=store_name]").val(data.store_name)		
			$("#myModal01 [name=email]").val(data.email)		
			$("#myModal01 [name=job_level]").val(data.job_level)
			$("#myModal01 [name=auth]").val(data.auth)
			$("#myModal01 [name=hire_date]").val(new Date(hiredate.getTime()-offset01).toISOString().split("T")[0])		
			$("#myModal01 [name=hire_type]").val(data.hire_type)
			
			$("#myModal01 [name=hrm_id]").prop("readonly",true)
			var first_num = data.store_num;
			var first_auth = data.auth;
			var first_enum = data.employee_num;
			var first_type = data.hire_type;
			
			if(data.resignation_day==null||data.resignation_day==""){
				$("#myModal01 [name=resignation_day]").val("")	
				$("#modalForm03").show()
				$("#reg_PassBtn").hide();
				$("#reg_PassBtn_chk").show();
				$("[name=password]").prop("readonly",true)
			 	$("[name=password]").val("")
			}else{
				$("#myModal01 [name=resignation_day]").val(new Date(resignation.getTime()-offset02).toISOString().split("T")[0])
				$("#myModal01 #reg_PassBtn_chk").hide()
				$("#myModal01 #reg_PassBtn").hide()
				$("#modalForm03").hide()
			}
			$("#myModal01 [name=phone_num]").val(data.phone_num)
			if(data.employee_photo==null){
				data.employee_photo="";
			}	
			if(data.employee_photo!=""){
				console.log("employee_photo값 : ")	
				console.log(data.employee_photo)
				$("#myModal01 [name=emp_photo]").attr("src", "/erpBt/img/employee_photo/"+data.employee_photo);
				console.log("상대경로 확인 : "+$("#myModal01 [name=emp_photo]").attr("src"))				
			}else{
				$("#myModal01 [name=employee_photo]").val("");
				$("#myModal01 [name=emp_photo]").attr("src", "/erpBt/img/employee_photo/image 22.png");
			}
			console.log("점포번호값"+data.store_num)
			
			$.ajax({
				url:"${path}/schStorekeeper",
				type:"get",
				data:"store_num="+first_num,
				dataType:"json",
				success:function(data2){
					console.log("원본값1"+data.auth)
					console.log("원본값2"+data2.auth)
					
					if(first_num!=0&&first_enum==data2.employee_num){
						console.log("조건문3, 내가 점주일 때")
						console.log("ajax1번에서 받아온 직원번호"+data.employee_num)
						console.log("ajax2번에서 받아온 직원번호"+data2.employee_num)
						$("#myModal01 [name=job_level]").prop("disabled",false)
						$("#myModal01 [name=job_level] option").hide()
						$("#myModal01 [name=job_level] option[value='']").show()
						$("#myModal01 [name=job_level] option[value='점주']").show()
						$("#myModal01 [name=job_level] option[value='매니저']").show()
						$("#myModal01 [name=job_level] option[value='직원']").show()
					}else if(first_num!=0&&first_enum!=data2.employee_num){
						console.log("조건문4, 내가 점포의 매니저, 직원일 때")
						console.log("ajax1번에서 받아온 직원번호"+data.employee_num)
						console.log("ajax2번에서 받아온 직원번호"+data2.employee_num)
						$("#myModal01 [name=job_level]").prop("disabled",false)
						$("#myModal01 [name=job_level] option").hide()
						$("#myModal01 [name=job_level] option[value='']").show()
						$("#myModal01 [name=job_level] option[value='매니저']").show()
						$("#myModal01 [name=job_level] option[value='직원']").show()
					}
				},
				error:function(err){
					console.log(err)
					if(first_num==0&&first_auth==1){
						console.log("조건문1, 사장일 때")
						$("#myModal01 [name=job_level] option").hide()
						$("#myModal01 [name=job_level] option[value='사장']").show()
						$("#myModal01 [name=job_level]").prop("disabled",true)
					}else if(first_num=="0"&&first_auth!="1"){
						console.log("조건문2, 본사소속일 때")
						$("#myModal01 [name=job_level]").prop("disabled",false)
						$("#myModal01 [name=job_level] option").hide()
						$("#myModal01 [name=job_level] option[value='']").show()
						$("#myModal01 [name=job_level] option[value='팀장']").show()
						$("#myModal01 [name=job_level] option[value='본사직원']").show()
					}else{
						console.log("조건문5, 점주자리가 공석일 때")
						$("#myModal01 [name=job_level]").prop("disabled",false)
						$("#myModal01 [name=job_level] option").hide()
						$("#myModal01 [name=job_level] option[value='']").show()
						$("#myModal01 [name=job_level] option[value='점주']").show()
						$("#myModal01 [name=job_level] option[value='매니저']").show()	
						$("#myModal01 [name=job_level] option[value='직원']").show()
					}
				}
			})
		},
		error:function(err){
			console.log(err)
		}
	});
};


function uptNew(){
	$.ajax({
		type:"post",
		url:"${path}/uptEmployee",
		data:{
			employee_num : $("#myModal01 [name=employee_num]").val(),
			store_num : $("#myModal01 [name=store_num]").val(),
			employee_name : $("#myModal01 [name=employee_name]").val(),
			email : $("#myModal01 [name=email]").val(),
			phone_num : $("#myModal01 [name=phone_num]").val(),
			job_level : $("#myModal01 [name=job_level]").val(),
			hire_date : $("#myModal01 [name=hire_date]").val(),
			hire_type : $("#myModal01 [name=hire_type]").val(),
			auth : $("#myModal01 [name=auth]").val(),
			resignation_day : $("#myModal01 [name=resignation_day]").val()
		},
		dataType:"text",
		success:function(data){
			console.log(data)
			var emp_num = $("#myModal01 [name=employee_num]").val()
			if(data=="점주의 복직 처리시에는 해당 점포의 점주유무를 확인해주세요"){
				alert(data)
			}else if(data=="퇴사처리가 완료되었습니다"){
				alert(data)	
				$("#myModal01").modal("hide");
				hrmSearch()
				schKeyWord()
			}else if($("#myModal01 [name=employee_photo]").val()!=""){
				uploadFile("#myModal01",emp_num)
				alert("직원 정보가 전부 수정 완료되었습니다.")
				$("#myModal01").modal("hide");
				hrmSearch()
				schKeyWord()
			}else{	
				alert("직원 정보가 사진을 제외하고 수정 완료되었습니다.")
				$("#myModal01").modal("hide");
				hrmSearch()
				schKeyWord()
			}
		},
		error:function(err){
			console.log(err)
			alert("데이터 수정에 실패하였습니다.\n다시 확인해주세요")
		}
	});
}
function delEmp(){
	$.ajax({
		type:"post",
		url:"${path}/delEmployee",
		data:{
			employee_num : $("#myModal01 [name=employee_num]").val(),
			employee_name : $("#myModal01 [name=employee_name]").val(),
			resignation_day : $("#myModal01 [name=resignation_day]").val()
		},
		dataType:"text",
		success:function(data){
			console.log(data)
			if(data.length>=10){
				alert(data)
				$('#myModal01').modal('hide')
				hrmSearch()
				schKeyWord()
			}else{
				alert("퇴사자 정보 삭제가 완료되었습니다.")
				 $('#myModal01').modal('hide')
				hrmSearch()
				schKeyWord()
			}
		},
		error:function(err){
			console.log(err)
			alert("정보 삭제에 실패하였습니다.\n다시 확인해주세요")
		}
	})
}




function setImage(file, expression){
	var reader = new FileReader();
	reader.onload = function(e){
		$(expression).attr('src', e.target.result);
	}
	reader.readAsDataURL(file);
}

function setSelect(selectModal){
	console.log("권한 : "+$(selectModal+" [name=auth]").val())
	console.log("점포번호 : "+$(selectModal+" [name=store_num]").val())
	
	$(selectModal+" [name=phone_num]").on("input", function(){
		  var phonenum = $(this).val().replace(/\D/g,"");
		  if(phonenum.length>=4){
			  phonenum=phonenum.substring(0,3)+"-"+phonenum.substring(3);
		  }
		  if(phonenum.length>=9){
			  phonenum=phonenum.substring(0,8)+"-"+phonenum.substring(8,12);
		  }
		  $(this).val(phonenum);
	  });
	
	var index=""
	var store_num=""
	var store_name=""
	var hire_type=""
	var job_level=""
	$(selectModal+" [name=hire_type]").prop("disabled", true)
	$(selectModal+" [name=job_level]").prop("disabled", true)
	$(selectModal+" [name=store_name]").change(function(){
		console.log("권한 : "+$(selectModal+" [name=auth]").val())
		console.log("점포번호 : "+$(selectModal+" [name=store_num]").val())
		store_name=$(this).val()
		if(store_name=="본사"){
			index = $(this).prop("selectedIndex");
			$(selectModal+" [name=store_num]").prop("selectedIndex", index)
			$(selectModal+" [name=hire_type] option[value='본사']").prop("selected", true);
			$(selectModal+" [name=job_level] option").hide()
			$(selectModal+" [name=job_level]").prop("disabled", false)
			$(selectModal+" [name=job_level] option[value='']").show()
			$(selectModal+" [name=job_level] option[value='팀장']").show()
			$(selectModal+" [name=job_level] option[value='본사직원']").show()
			$(selectModal+" [name=job_level] option[value='']").prop("selected", true);
			$(selectModal+" [name=auth]").val("");
		}else if(store_name!=""){
			index = $(this).prop("selectedIndex");
			$(selectModal+" [name=store_num]").prop("selectedIndex", index)
			$(selectModal+" [name=hire_type] option[value='점포']").prop("selected", true);
			$(selectModal+" [name=job_level] option").hide()
			$(selectModal+" [name=job_level]").prop("disabled", false)
			$(selectModal+" [name=job_level] option[value='']").show()
			$(selectModal+" [name=job_level] option[value='매니저']").show()
			$(selectModal+" [name=job_level] option[value='직원']").show()
			$(selectModal+" [name=job_level] option[value='']").prop("selected", true);
			$(selectModal+" [name=auth]").val("");
			schStorekeeper(selectModal)
		}else if(store_name==""){
			index = $(this).prop("selectedIndex");
			$(selectModal+" [name=store_num]").prop("selectedIndex", index)
			$(selectModal+" [name=hire_type] option[value='']").prop("selected", true);
			$(selectModal+" [name=job_level] option[value='']").show()
			$(selectModal+" [name=job_level] option[value='']").prop("selected", true);
			$(selectModal+" [name=job_level]").prop("disabled", true)
			$(selectModal+" [name=auth]").val("");
		}
	});
		$(selectModal+" [name=job_level]").change(function(){
			console.log("권한 : "+$(selectModal+" [name=auth]").val())
			console.log("점포번호 : "+$(selectModal+" [name=store_num]").val())
			var hire_type = $(selectModal+" [name=hire_type]").val();
			var job_level = $(this).val();
			if(hire_type=="본사"&&job_level=="팀장"){
				$(selectModal+" [name=auth]").val(2)
			}else if(hire_type=="본사"&&job_level=="본사직원"){
				$(selectModal+" [name=auth]").val(3)
			}else if(hire_type=="점포"&&job_level=="점주"){
				$(selectModal+" [name=auth]").val(2)
			}else if(hire_type=="점포"&&job_level=="매니저"){
				$(selectModal+" [name=auth]").val(3)
			}else if(hire_type=="점포"&&job_level=="직원"){
				$(selectModal+" [name=auth]").val(4)
			}else{
				$(selectModal+" [name=auth]").val("");
			}
		});
	 
	  $(selectModal+" [name=employee_photo]").change(function() {
		    var input = this;
		    if (input.files && input.files[0]) {
	    		setImage(input.files[0], $(selectModal+" [name=emp_photo]"))
		    }
      });
}

function uploadFile(selectModal, data){
	var formData = new FormData();
	formData.append("employee_photo", $(selectModal+" [name=employee_photo]")[0].files[0]);
	formData.append("employee_num", data);
	formData.append("employee_name", $(selectModal+" [name=employee_name]").val());
	$.ajax({
		url:"${path}/uploadPhoto",
		type:"post",
		enctype:"multipart/form-data",
		data:formData,
		processData:false,
		contentType:false,
		success:function(response){
			console.log("업로드 완료")
		},
		error:function(err){
			console.log("업로드 실패")
			console.log(formData)
		}
	})
}

function schStorekeeper(selectModal){
	$.ajax({
		url:"${path}/schStorekeeper",
		type:"get",
		data:"store_num="+$(selectModal+" [name=store_num]").val(),
		dataType:"text",
		success:function(data){
			console.log(data)
			if(data!=""){
				if(data.employee_num==$(selectModal+" [name=employee_num]").val()){
					$(selectModal+" [name=job_level] option[value='점주']").show()
				}
				$(selectModal+" [name=job_level] option[value='점주']").hide()
			}else{
				console.log("본사번호"+data.store_num)
				if(data.store_num==0){
					$(selectModal+" [name=job_level] option[value='점주']").hide()
				}
				$(selectModal+" [name=job_level] option[value='점주']").show()
			}
		},
		error:function(err){
			console.log(err)
		}
	})
}
</script>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">인사관리</h1>
		<div class="input-group mt-3 mb-0" style="float:right; width:14%">
			  <span class="input-group-text" id="count"></span>
			  <select id="pageSize" name="pageSize" class="form-control">
			  	<option value="10" selected>10개씩</option>
			  	<option value="20">20개씩</option>
			  	<option value="50">50개씩</option>
			  </select>
		</div>		
	</div>
	<!-- Content Row -->
	<div class="row">
		<!-- Earnings (Monthly) Card Example -->
		<div class="col-hak">
			<div class="card border-left-primary shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<table class="tab-hak">
							<col width="10%">
							<col width="8%">
							<col width="14%">
						   	<col width="8%">
						   	<col width="15%">
						   	<col width="15%">
						   	<col width="15%">
						   	<col width="15%">
							<tr class="employee-tr">
								<th>직원번호</th>
								<th>직원명</th>
								<th>점포명</th>
								<th>직위</th>
								<th>연락처</th>
								<th>입사일</th>
								<th>퇴사일</th>
								<th class="search-cell">
									<select class="select" id="serach01" name="schType">
										<option value="employee_num" selected>직원번호</option>
										<option value="employee_name">직원명</option>
										<option value="store_name">점포명</option>
										<option value="job_level">직위</option>
										<option value="phone_num">연락처</option>
										<option value="hire_date_year">입사년도</option>
										<option value="resignation_day_year">퇴사년도</option>
										<option value="hire_date">입사일</option>
										<option value="resignation_day">퇴사일</option>
									</select>
									<input type="text" id="search02" name="schWord"
									class="search-input" placeholder="검색" value="">
								</th>
							</tr>
							<tbody id="employee_list">
							</tbody>
						</table>
					</div>
				</div>
				<div class="butmod-hak2" id="pageMoving">
				</div>
				<input class="hide" type="text" name="curPage" value=""/>
			</div>
		</div>
			<div class="butmod-hak2">
				<button class="btn" data-bs-toggle="modal" data-bs-target="#myModal02">신규등록</button>
			</div>
	</div>
	<!-- 모달창 생성 -->
	<div class="container mt-3"></div>

	<!-- The Modal -->
	<div class="modal fade" id="myModal01">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">직원 상세정보</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
		
				<!-- Modal body -->
				<div class="modal-body">
					<form class="form" method="post" id="modalForm01">
						<div class="row">
							<div class="col-md-6">
								<div class="input-group mb-6">
									<label class="input-group-text custom_modal02" for="store_name01">점포명</label> 
										<select class="selectbox_custom01" name="store_num">
											<option value="">번호</option>
										</select>
										<select class="selectbox_custom02" id="store_name01" name="store_name">
											<option value="">점포명</option>
										</select>
								</div>
							</div>
							<div class="custom_modal_right">
								<div class="input-group mb-3">
									<span class="input-group-text custom_modal02">아이디</span> 
									<input type="text" name="hrm_id" class="form-control" value="">
									<input class="hide" name="employee_num">
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02" for="email01">이메일</label> 
									<input type="text" id="email01" name="email" class="form-control" placeholder="이메일">
								</div>
							</div>
							<div class="custom_modal_right">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02" for="employee_name01">직원명</label> 
									<input type="text" id="employee_name01" name="employee_name" class="form-control" placeholder="직원명" value="">
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02" for="phone_num01">연락처</label> 
									<input type="text" id="phone_num01" name="phone_num" class="form-control" placeholder="연락처">
								</div>
							</div>		
							<div class="custom_modal_right">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02" for="job_level01">직위</label> 
									<select class="selectbox_custom03" id="job_level01" name="job_level">
										<option value="">직위선택</option>
										<option value="팀장">팀장</option>	
										<option value="점주">점주</option>
										<option value="매니저">매니저</option>
										<option value="직원">직원</option>
										<option value="사장">사장</option>
										<option value="본사직원">본사직원</option>
									</select>
									<input class="authVal" type="number" name="auth"/>
								</div>
							</div>
							
							<div class="custom_modal_right hide">
								<div class="input-group mb-3">
									<span class="input-group-text custom_modal02">점포구분</span> 
									<select class="selectbox_custom03" name="hire_type">
										<option value="">점포구분</option>
										<option value="본사">본사</option>
										<option value="점포">점포</option>
									</select>
								</div>
							</div>
						</div>		
						<img class="emp_photo" name="emp_photo" src="" onerror="$(this).attr('src', '/erpBt/img/employee_photo/image 22.png')"/>
						<div class="row">
												
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text custom_modal02">입사일</span> 
									<input type="date" name="hire_date" class="form-control" placeholder="입사일">
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-3">
									<span class="input-group-text custom_modal02">퇴사일</span> 
									<input type="date" name="resignation_day" class="form-control" placeholder="퇴사일">
								</div>
							</div>
						</div>
					</form>
					<form class="form" id="modalForm03">
					<div class="row">
							<div class="col-md-6">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02" for="password01">비밀번호</label> 
									<input type="text" id="password01" name="password" class="form-control" placeholder="비밀번호">
								</div>
							</div>
					</div>	
					</form>
			</div> <!-- modal body end -->
				<!-- Modal footer -->
			<div class="modal-footer d-flex justify-content-right">
				<p id="errorMsg01"></p>
				<label class="reg_photo_Btn btn-outline-primary" for="reg_photo01">사진 등록</label>
				<input type="file" id="reg_photo01" class="reg_photo" accept="image/*" name="employee_photo">
				<button type="button" id="reg_PassBtn_chk"class="btn btn-outline-primary">비밀번호 변경하기</button>
				<button type="button" id="reg_PassBtn"class="btn btn-outline-primary">비밀번호 변경완료</button>
				<button type="button" id="prm_uptBtn" class="btn btn-outline-info">수정완료</button>
				<button type="button" id="prm_delBtn" class="btn btn-outline-danger">삭제</button>
				<button type="button" id="close_Btn" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>

			</div>
		</div>
	</div>
</div>
<!-- End of Main Content -->
	<!-- The Modal -->
	<div class="modal fade" id="myModal02">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">신규 직원 등록</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
		
				<!-- Modal body -->
				<form class="form" method="post" id="modalForm02">
					<div class="modal-body">
						<div class="row">
							<div class="col-md-6 hide">
								<div class="input-group mb-3">
									<span class="input-group-text custom_modal02">직원번호</span> 
									<input type="text" name="employee_num" class="form-control" placeholder="직원번호">
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-6">
									<label class="input-group-text custom_modal02" for="store_name02">점포명</label> 
										<select class="selectbox_custom01" name="store_num">
											<option value="">번호</option>
										</select>
										<select class="selectbox_custom02" id="store_name02" name="store_name">
											<option value="">점포명</option>
										</select>
								</div>
							</div>
							<div class="custom_modal_right">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02" for="employee_name02">직원명</label> 
									<input type="text" id="employee_name02" name="employee_name" class="form-control" placeholder="직원명">
								</div>
							</div>
							<div class="custom_modal_right hide">
								<div class="input-group mb-3">
									<span class="input-group-text custom_modal02">비밀번호</span> 
									<input type="text" name="password" class="form-control" placeholder="비밀번호">
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02" for="email02">이메일</label> 
									<input type="text" id="email02" name="email" class="form-control" placeholder="이메일">
								</div>
							</div>
							<div class="custom_modal_right">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02" for="job_level02">직위</label> 
									<select class="selectbox_custom03" id="job_level02" name="job_level">
										<option value="">직위선택</option>
										<option value="팀장">팀장</option>
										<option value="점주">점주</option>
										<option value="매니저">매니저</option>
										<option value="직원">직원</option>
										<option value="본사직원">본사직원</option>
									</select>
									<input class="authVal" type="number" name="auth"/>
								</div>
							</div>
							<div class="custom_modal_right hide">
								<div class="input-group mb-3">
									<span class="input-group-text custom_modal02">점포구분</span> 
									<select class="selectbox_custom03" name="hire_type">
										<option value="">점포구분</option>
										<option value="본사">본사</option>
										<option value="점포">점포</option>
									</select>
								</div>
							</div>
							
					</div>		
						<img class="emp_photo" name="emp_photo" src="" onerror="$(this).attr('src', '/erpBt/img/employee_photo/image 22.png')"/>
					<div class="row">							
							<div class="col-md-6">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02" for="phone_num02">연락처</label> 
									<input type="text" id="phone_num02" name="phone_num" class="form-control" placeholder="연락처">
								</div>
							</div>
							<div class="custom_modal_right">
								<div class="input-group mb-3">
									<label class="input-group-text custom_modal02">입사일</label> 
									<input type="date" name="hire_date" class="form-control" onkeydown="return false">
								</div>
							</div>
						</div>	
					</div> <!-- modal body end -->
				</form>
				<!-- Modal footer -->
				<div class="modal-footer d-flex justify-content-right">
					<p id="errorMsg02"></p>
					<label class="reg_photo_Btn btn-outline-primary" for="reg_photo02">사진 등록</label>
					<input type="file" id="reg_photo02" class="reg_photo" accept="image/*" name="employee_photo">
					<button type="button" id="prm_regBtn"class="btn btn-outline-primary">등록완료</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	
	$.validator.addMethod("regexpPass", function(value, element, regexpPass) {
	    var regExp = new RegExp(regexpPass);
	    return regExp.test(value);
	});
	
	$.validator.addMethod("regex", function(value, element, regexp) {
	    var regExp = new RegExp(regexp);
	    return regExp.test(value);
	});
	
	$.validator.addMethod("email1", function(value, element, email1) {
	    var regExp = new RegExp(email1);
	    return regExp.test(value)
	});
	
	$.validator.addMethod("email2", function(value, element, email2) {
	    var regExp = new RegExp(email2);
	    return regExp.test(value)
	});
	
	$.validator.addMethod("maxDate1", function(value, element) {
	    var maxDate1 = new Date().toISOString().split("T")[0];
	    var inputDate1 = $("#myModal01 [name=hire_date]").val();
	    return inputDate1 <= maxDate1;
	}, "Date must be on or before today");
	
	$.validator.addMethod("maxDate2", function(value, element) {
	    var maxDate2 = new Date().toISOString().split("T")[0];
	    var inputDate2 = $("#myModal01 [name=resignation_day]").val();
	    return inputDate2 <= maxDate2;
	}, "Date must be on or before today");
	
	$.validator.addMethod("maxDate3", function(value, element) {
	    var maxDate3 = new Date().toISOString().split("T")[0];
	    var inputDate3 = $("#myModal02 [name=hire_date]").val();
	    return inputDate3 <= maxDate3;
	}, "Date must be on or before today");
	
	$.validator.addMethod("minDate1", function(value, element) {
	    var minDate1 = $("#myModal01 [name=hire_date]").val();
		var inputDate1 = $("#myModal01 [name=resignation_day]").val();
		if(inputDate1 != ""){
		    return inputDate1 >= minDate1;
		}else{
			return true;
		}
	}, "Date must be on or before today");
	
	$("#modalForm01").validate({
		onkeyup: false,
	    onclick: false,
	    onfocusout: false,
		focusCleanup:true,
	    showErrors: function(errorMap,errorList){
	        if(this.numberOfInvalids()){ // 에러가 있으면
	            $("#errorMsg01").html(errorList[0].message); // 에러 메시지 출력
	        }
	    },
		rules: {
			store_num:{
				required:true
			},
			store_name:{
				required:true
			},
			email:{
				required:true,
				email1:/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
				maxlength:30
			},
			employee_name:{
				required:true,
				minlength:2,
				maxlength:15
			},
			job_level:{
				required:true
			},
			auth:{
				required:true,
				max:4
			},
			hire_type:{
				required:true
			},
			phone_num:{
				required:true,
				regex:/^010-\d{4}-\d{4}$/
			},
			hire_date:{
				required:true,
				maxDate1:true
			},
			resignation_day:{
				required:false,
				minDate1:true,
				maxDate2:true 
			}
		},
		messages:{
			store_num:{
				required:"점포명 입력 필수"
			},
			store_name:{
				required:"점포명 입력 필수"
			},
			email:{
				required:"이메일 입력 필수",
				email1:"올바른 이메일을 입력해주세요",
				maxlength:"적당한 이메일을 입력해주세요"
			},
			employee_name:{
				required:"직원명 입력 필수",
				minlength:"올바른 이름을 입력해주세요",
				maxlength:"올바른 이름을 입력해주세요"
			},
			job_level:{
				required:"직위 입력 필수"
			},
			auth:{
				required:"매장과 직위를 올바르게 선택해주세요",
				maxlength:"매장과 직위를 올바르게 선택해주세요"
			},
			hire_type:{
				required:"점포를 선택해주세요"
			},
			phone_num:{
				required:"전화번호를 입력해주세요",
				regex:"올바른 전화번호를 입력해주세요"
			},
			hire_date:{
				required:"입사일 입력 필수",
				maxDate1: "입사일은 오늘을 넘길 순 없습니다"
			},
			resignation_day:{
				minDate1: "퇴사일은 입사일보다 빠를수 없습니다",
				maxDate2: "퇴사일은 오늘을 넘길 순 없습니다"
				}
		},
		submitHandler:function(){
	
		}
	});
	$("#modalForm02").validate({
		onkeyup: false,
	    onclick: false,
	    onfocusout: false,
		focusCleanup:true,
	    showErrors: function(errorMap,errorList){
	        if(this.numberOfInvalids()){ // 에러가 있으면
	            $("#errorMsg02").html(errorList[0].message); // 에러 메시지 출력
	        }
	    },
		rules: {
			store_num:{
				required:true
			},
			store_name:{
				required:true
			},
			email:{
				required:true,
				email2:/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
				maxlength:30
			},
			employee_name:{
				required:true,
				minlength:2,
				maxlength:15
			},
			job_level:{
				required:true
			},
			auth:{
				required:true,
				max:4
			},
			hire_type:{
				required:true
			},
			phone_num:{
				required:true,
				regex:/^010-\d{4}-\d{4}$/
			},
			hire_date:{
				required:true,
				maxDate3:true
			}
		},
		messages:{
			store_num:{
				required:"점포명 입력 필수"
			},
			store_name:{
				required:"점포명 입력 필수"
			},
			email:{
				required:"이메일 입력 필수",
				email2:"올바른 이메일을 입력해주세요",
				maxlength:"적당한 이메일을 입력해주세요"
			},
			employee_name:{
				required:"직원명 입력 필수",
				minlength:"올바른 이름을 입력해주세요",
				maxlength:"올바른 이름을 입력해주세요"
			},
			job_level:{
				required:"직위 입력 필수"
			},
			auth:{
				required:"매장과 직위를 올바르게 선택해주세요",
				maxlength:"매장과 직위를 올바르게 선택해주세요"
			},
			hire_type:{
				required:"점포를 선택해주세요"
			},
			phone_num:{
				required:"전화번호를 입력해주세요",
				regex:"올바른 전화번호를 입력해주세요"
			},
			hire_date:{
				required:"입사일 입력 필수",
				maxDate3: "입사일은 오늘을 넘길 순 없습니다"
			}
		},
		submitHandler:function(){
	
		}
	});
	$("#modalForm03").validate({
		onkeyup: false,
	    onclick: false,
	    onfocusout: false,
		focusCleanup:true,
	    showErrors: function(errorMap,errorList){
	        if(this.numberOfInvalids()){ // 에러가 있으면
	            $("#errorMsg01").html(errorList[0].message); // 에러 메시지 출력
	        }
	    },
	    rules: {
	    	password:{
				required:true,
				regexpPass:/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/
			}
	    },
	    messages: {
	    	password:{
				required:"비밀번호를 입력해주세요",
				regexpPass:"비밀번호는 8~15자내의 알파벳+숫자+특수문자로 변경할 수 있습니다."
			}
	    },
	    submitHandler:function(){
		}
	    
	});
	
	
});
</script>
<!-- End of Main Content -->
<%@include file="footer.jsp"%>
