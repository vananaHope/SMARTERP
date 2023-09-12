<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import = "java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/> 
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>

<script>
$(document).ready(function() {
   var msg = "${msg}"
      if(msg != ''){
         alert(msg)      
      }
   
        $('#brandSelect').change(function () {
           var selectedValue = $(this).val();
           $('#productSelect').css('outline', '3px solid red');
           
           $.ajax({
               type: 'GET',
               url: '${path}/schBri',
               data: { ref_num: selectedValue }, 
               success: function (data) {
                   console.log(data);
                   // select 요소에서 브랜드를 선택
                   var productSelect = $('#productSelect');
                   productSelect.empty();
                   productSelect.append($('<option id = "reSelectProduct">상품 선택...</option>'));
                   // 서버에서 받아온 데이터를 반복
                   $.each(data, function (index, product) {
                      // 브랜드 상품을 선택 옵션 값으로, 텍스트로 추가
                       productSelect.append($('<option></option>').attr('value', product.item_num).text(product.item_name));
                   });
               },
               error: function (error) {
                   console.error('Error:', error);
               }
           });
       }); 

    /* 색상 조회 */
    function propertiesNumColor() {
        $.ajax({
            url: "${path}/schPer",
            type: "post",
            dataType: "json",
            success: function(data) {
                console.log(data);
                // html 변수 초기화
            var showByColor = ''
            // 서버에서 받아온 데이터를 반복하면서 정보를 html 형식으로 생성
                data.forEach(function(p) {
               showByColor += '<div class="col-md-4 p-2">';
                    showByColor += '<input type="radio" name = "color" class = "colorCheckBox" id="colorSelect" value="' + p.properties_num + '"> ';
                    showByColor += ' <label for="color2">'+p.color+'</label>';
                    showByColor += '</div>';
                });
                $("#colorResult").html(showByColor)
               // 색상 변경시 실행되는 이벤트 핸들러
                $(".colorCheckBox").on('change', function() {
                   var selectedColorValue = $(this).val();
                    console.log("색상 선택: " + selectedColorValue);
                    // 선택된 색상 값이 숫자라면 해당 색상 값을 이용하여 다른 함수 호출
                    if (!isNaN(selectedColorValue)) {
                        propertiesNumSize(selectedColorValue);
                    }
               });
            },
            error: function(error) {
                console.error('에러', error);
            }
        });
    }
    // ID가 "productSelect"인 요소의 변경 이벤트에 이벤트 핸들러를 추가
   $("#productSelect").on('change',function(){
      propertiesNumColor()
   })
   
   /* 사이즈 조회 */
   function propertiesNumSize(size) {
      $.ajax({
         url : "${path}/schPerSize",
         type : "post",
         data : "ref_num=" + size,
         dataType : "json",
         traditional: true,
         success : function(data){
            console.log("사이즈 조회: "+data);
            var showBySize = ''
            data.forEach(function(s){
               showBySize += '<div class="col-md-4 p-2">';
               showBySize += '<input type="checkbox" name = "properties_num" class = "sizeCheckBox" id="properties_num" value="'+ s.properties_num+'"> ';
               showBySize += ' <label for="size1">'+s.color+'</label>';
               showBySize += '</div>';
            });
            $("#sizeResult").html(showBySize)

            $(".sizeCheckBox").on('change', function(){
               var selectedSizeValue = parseInt($(this).val(), 10);
               console.log("사이즈 선택: " + selectedSizeValue);
               
            })
            
         },
         error : function(error) {
            console.error('Error', error);
         }
      });
   }

   /* 등록된 본사 상품 조회 테이블 */
    var tableBody = $("#productTableBody");
    var itemNameValue = $("#searchInput").val();

    $.ajax({
        url: "${path}/prdList",
        type: "GET",
        data: { item_name: itemNameValue },
        dataType: "json",
        success: function(data) {
            tableBody.empty();
            $.each(data, function(index, product) {
                var newRow = $("<tr></tr>");
                newRow.append("<td><input type='checkbox' class='check-input'> 선택</td>");
                newRow.append("<td name='product_nums' class='product_nums'>" + product.product_num + "</td>");
                newRow.append("<td class='brand-cell'>" + product.brand + "</td>");
                newRow.append("<td>" + product.item_name + "</td>");
                newRow.append("<td>" + product.color + "</td>");
                newRow.append("<td>" + product.prd_size + "</td>");
                newRow.append("<td>" + formatCurrency(product.cost) + "</td>");
                newRow.append("<td>" + formatDate(product.reg_date) + "</td>");
                
                var inputElementId = 'jput_' + index;
                
                var inputElement = $('<input>').attr({
                    id: inputElementId,
                    type: 'number',
                    name: 'product_count',
                    class: 'uptAllCount',
                    value: product.product_count,
                    max: 1000,
                    maxlength: 4
                });
                
                inputElement.prop('disabled', true);
                
                inputElement.on('input', function() {
                    var inputValue = $(this).val();
                    
                    if (inputValue.length > 4) {
                        $(this).val(inputValue.slice(0, 4));
                    }
                    
                    if (inputValue.trim() === "") {
                        inputValue = "0";
                    }
                    
                    var parsedValue = parseInt(inputValue, 10);
                    if (isNaN(parsedValue) || parsedValue > 1000 || parsedValue < 0) {
                        $(this).css('outline', '3px solid red');
                        $(this).closest('tr').find('#uptStock').prop('disabled', true);
                    } else {
                        $(this).css('outline', '');
                        $(this).closest('tr').find('#uptStock').prop('disabled', false);
                    }
                    
                    var anyInvalid = tableBody.find('.uptAllCount').toArray().some(function(input) {
                        var inputValue = parseInt($(input).val(), 10);
                        return isNaN(inputValue) || inputValue < 0 || inputValue > 1000;
                    });

                    $('#uptAllCount').prop('disabled', anyInvalid);
                });
                
                newRow.append($('<td>').append(inputElement));
                newRow.append("<td><button type='button' id='uptStock'  class='btn btn-secondary btn-sm uptStock' >재고수정</td>");
                newRow.append('<input type="hidden" value="' + product.properties_num + '">');
                newRow.append('<input type="hidden" value="' + product.item_num + '">');

                tableBody.append(newRow);
                
                newRow.find('.check-input').on('change', function() {
                    var isChecked = $(this).prop('checked');
                    
                    if (isChecked) {
                        $(this).closest('tr').find('input.uptAllCount').prop('disabled', false);
                    } else {
                        $(this).closest('tr').find('input.uptAllCount').prop('disabled', true);
                    }

                    // 하나라도 재고가 유효하지 않은 값이 있으면 선택 수정 버튼을 계속해서 비활성화
                    var anyInvalid = tableBody.find('.uptAllCount').toArray().some(function(input) {
                        var inputValue = parseInt($(input).val(), 10);
                        return isNaN(inputValue) || inputValue < 0 || inputValue > 1000;
                    });

                    $('#uptAllCount').prop('disabled', anyInvalid);
                });
            });
            
            /* 모든 체크 박스 선택 */   
            $("#selectAllCheckbox").on("change", function() {
                var isChecked = $(this).prop("checked");
              tableBody.find(".check-input").prop("checked", isChecked);
        
              tableBody.find(".uptAllCount").each(function() {
                  $(this).prop("disabled", !isChecked);
                 });
           });
             
            
            
            /* 권한에 따른 재고 수정 여부 */
            var empValid = 
            	"${employee.job_level}" === "점주" || "${employee.job_level}" === "매니저" || "${employee.job_level}" === "직원";
            var HQValid = 
            	"${employee.job_level}" === "사장" || "${employee.job_level}" === "팀장" || "${employee.job_level}" === "본사직원";
            
            if (empValid) {
                   $(".uptStock").attr("disabled", true);
                   $("#uptAllCount").prop("disabled", true);
                   $("#newRegister").prop("disabled", true);
                   $("#deleteSelectedButton").prop("disabled", true);
                   $(".uptAllCount").prop("disabled", true);
                   $(".check-input").prop("disabled", true);
            } else if (HQValid){
                   $(".uptStock").attr("disabled", false);
                   $("#uptAllCount").prop("disabled", false);
                   $("#newRegister").prop("disabled", false);
                   $("#deleteSelectedButton").prop("disabled", false);
            } 
 
            /* 검색 */
            $("#searchInput").on("keyup", function() {
                var searchText = $(this).val().toLowerCase();
                tableBody.find("tr").hide();
                tableBody.find("td").filter(":contains(" + searchText + ")").parent().show();
            });
         
         /* 선택된 상품 삭제 */
            $("#deleteSelectedButton").on("click", function() {
                var selectedItems = tableBody.find(".check-input:checked");
                
                if (selectedItems.length > 0 && confirm("선택한 항목을 삭제하시겠습니까?")) {
                    var productNumbers = [];
                    
                    selectedItems.each(function() {
                        var productNumber = $(this).closest("tr").find("td:eq(1)").text();
                        productNumbers.push(productNumber);
                    });

                    var url = "${path}/delHeadPrd?product_nums=" + productNumbers.join(",");
                    
                    $.ajax({
                        url: url,
                        type: "POST",
                        success: function(response) {
                           alert("선택한 상품을 삭제했습니다.");
                            location.reload();
                        },
                        error: function(error) {
                            console.error("오류가 발생했습니다:", error);
                        }
                    });
                }
            });
      },
      error: function(err) {
         console.log("An error occurred:", err);
      }
      
      }); /* prdList */
      
      
    
      
      /* 재고수정 버튼 클릭시 재고 업데이트 */
        $(document).on("click", "#uptStock", function() {
          var productNum = $(this).closest("tr").find("td[name='product_nums']").text();
          var newStockValue = parseInt($(this).closest("tr").find("input[name='product_count']").val(), 10);
        
          console.log("productNum:", productNum);
          console.log("newStockValue:", newStockValue);
          
          if (isNaN(newStockValue)) {
              newStockValue = 0; // 만약 파싱이 실패하면 0으로 설정
          }
          
          $.ajax({
              url: "${path}/uptHeadPrd",
              type: "POST",
              data: { product_nums: productNum, counts: newStockValue },
              dataType: "text",
              success: function(result) {
               if (result === 'sucs') {
                       alert("재고를 수정했습니다.");
                       location.reload();
                   } else {
                       alert("실패했습니다.");
                       console.log(result);
                   }
            },
            error : function(error) {
               console.error('에러', error);
            }
          });
      });

      
      /* 재고 일괄 수정 버튼 */
       $("#uptAllCount").on("click", function() {
           var inputItems = $(".uptAllCount");
           var inputPrdNums = $(".product_nums");
           var inputData = [];

           inputItems.each(function() {
               var inputValue = parseInt($(this).val(), 10);
               if (!isNaN(inputValue)) {
                   inputData.push(inputValue);
               }
           });

           var productNums = inputPrdNums.map(function() {
               return $(this).text();
           }).get();

           if (inputData.length > 0) {
               var url = "${path}/uptHeadPrd";

               $.ajax({
                   url: url,
                   type: "POST",
                   data: {
                       product_nums: productNums,
                       counts: inputData 
                   },
                   success: function(result) {
                       if (result === 'sucs') {
                           alert("재고를 수정했습니다.");
                           location.reload();
                       } else {
                           alert("실패했습니다.");
                           console.log(result);
                       }
                   },
                   error: function(error) {
                       console.error("에러:", error);
                   }
               });
           }
       });
      
}); /* on ready function 닫히는 부분 */

function formatDate(dateString) {
    var date = new Date(dateString);
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0');
    var day = date.getDate().toString().padStart(2, '0');

    return year + "-" + month + "-" + day;
}

function formatCurrency(amount) {
    var formattedAmount = amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return formattedAmount + "원";
}


</script>

</body>
</html>
<!-- Begin Page Content -->
<div class="container-fluid">

   <!-- Page Heading -->
   <div class="d-sm-flex align-items-center justify-content-between mb-4">
      <h1 class="h3 mb-0 text-gray-800">상품관리</h1>
   </div>

   <!-- Content Row -->
   <div class="row">
      <div class="col-jun">
         <div class="butmod-jun">
            <button class = "btn btn-primary" id = "newRegister" data-bs-toggle="modal" data-bs-target="#myModal">신규등록</button>
            <button class = "btn btn-warning" id="deleteSelectedButton" >선택삭제</button>
            <td><button type="button" id = "uptAllCount" class="btn btn-success uptAllCount">선택수정</button></td>
         </div>
         <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
               <div class="row no-gutters align-items-center">
                  <table class="tab-jun" id = "productTable" >
                <thead>
                    <tr class = "botLine">   
                        <th><input type="checkbox" class="check-input" id="selectAllCheckbox"> 선택</th>
                        <th>순서</th>
                        <th class="brand-cell">브랜드</th>
                        <th>품목명</th>
                        <th>색상</th>
                        <th>사이즈</th>
                        <th>원가</th>
                        <th>등록일</th>
                        <th>재고</th>
                        <th colspan="2" class="search-cell"><input type="text" class="search-input" id="searchInput" placeholder="검색"></th>
                    </tr>
                </thead>
                  <tbody id="productTableBody"></tbody>
               </table>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- 모달창 생성 -->
   <div class="container-fluid"></div>
   <!-- The Modal -->
   <div class="modal" id="myModal">
      <div class="modal-dialog modal-lg">
         <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
               <h4 class="modal-title">상품 등록</h4>
               <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <!-- Modal body -->
            <form id="insHeadPrd">
            <div id="errorMsg" class="error-message"></div>
               <div class="modal-body">
                  <div class="row">
                     <!-- 브랜드명 입력 -->
                     <div class="col-md-6">
                        <div class="input-group mb-3">
                           <span class="input-group-text" style="min-width: 80px;">브랜드</span> 
                              <select name = "brand" id="brandSelect" class="form-select" aria-label="신발 브랜드 선택">
                                 <option value = "">브랜드 선택...</option>
                                 <option value="1000">나이키</option>
                                 <option value="2000">아디다스</option>
                                 <option value="3000">뉴발란스</option>
                                 <option value="4000">휠라</option>
                                 <option value="5000">아식스</option>
                                 <option value="6000">컨버스</option>
                                 <option value="7000">닥터마틴</option>
                                 <option value="8000">라코스테</option>
                                 <option value="9000">반스</option>
                              </select>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <div class="input-group mb-3">
                           <span class="input-group-text" style="min-width: 80px;">상품명</span> 
                              <select name = "item_num" id="productSelect" class="form-select" aria-label="신발 상품 선택" value = "">
                                 <option name="item_name" value = "">상품선택...</option>
                              </select>
                        </div>
                     </div>
                  <!-- 원가 표시 -->
                  <div class="row">
                     <div class="col-md-12">
                        <div class="input-group mb-3">
                           <span class="input-group-text">원가</span> 
                           <input type="number" name="cost" id="cost" class="form-control" placeholder="원가 입력">
                        </div>
                     </div>
                  </div>
                  <!-- 색상 등록 -->
               <div class="row">
                  <div class="input-group mb-3">
                     <span class="input-group-text">색상명</span>
                     <div name = "properties_color" id="colorResult" class="d-flex flex-wrap" value = ""></div>
                  </div>
                  <div class="input-group mb-3">
                     <span class="input-group-text">사이즈</span>
                     <div name="properties_num" id="sizeResult"
                        class="d-flex flex-wrap" value = ""></div>
                  </div>
               </div>
               </div>
               </div>
            <!-- Modal footer -->
            <div class="modal-footer d-flex justify-content-center">
               <button type="submit" class="btn btn-secondary" data-bs-dismiss="modal"  id="regBtn" disabled>상품등록</button>
               <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            </div>
            </form>
         </div>
      </div>
   </div>
   </div>
<!-- End of Main Content -->

<script type = "text/javascript">
$(document).ready(function() {
   $('#regBtn').click(function(event){
      $('#regBtn').attr('disabled',false)
      $("form").attr("action","${path}/insHeadPrd")
      $("form").submit();
   })
   var flag1 = false;
   var flag2 = false;
   var flag3 = false;
   var flag4 = false;
   var flag5 = false;
   
   /* 브랜드 선택 */
   $('#brandSelect').on('change', function() {
      var brandSelect = $(this).val();
      var isValidBrand = brandSelect!= "";
      $(this).css('outline', isValidBrand ? '3px solid green' : '3px solid red');
      flag1 = isValidBrand;
      checkBtn();
   });
   
   /* 해당 브랜드 상품 선택 */
   $('#productSelect').on('change', function() {
       var productSelect = $(this);
       var selectedOption = productSelect.find('option:selected');
       var isValidProduct = selectedOption.val() !== '' && selectedOption.val() !== '상품 선택...';
       
       productSelect.css('outline', isValidProduct ? '3px solid green' : '3px solid red');
       flag2 = isValidProduct;
       checkBtn();
   });


   /* 원가 */
   $('#cost').on('blur', function() {
       var priceV = $(this).val();
       var validPriceV = priceV > 0;
       
       var priceL = $(this).val().length;
       $(this).val(Math.floor(priceV / 100) * 100);
       var validPriceL = priceL > 3 && priceL < 8;
       
       $(this).css('outline', validPriceV && validPriceL ? '3px solid green' : '3px solid red');
       flag3 = validPriceV && validPriceL;
       checkBtn();
   });
   /* 색상 선택 */
   $('#colorResult').on('change', '[type=radio]', function() {
      if ($(this).val() !== '') {
         flag4 = true;
      } else {
         flag4 = false;
      }
      checkBtn();
   });
   /* 사이즈 선택 */
   $(document).on('change', '.sizeCheckBox', function() {
       if ($(this).is(':checked')) {
           flag5 = true;
       } else {
           flag5 = false;
       }
       checkBtn();
   });
   /* 상품 등록 */
   function checkBtn() {
      var allFlags = flag1 && flag2 && flag3 && flag4 && flag5;
      
      if (allFlags) {
         $('#regBtn').prop('disabled', false)
      } else {
         $('#regBtn').prop('disabled', true)
      }
   }
});         
</script>
<%@include file="footer.jsp"%>