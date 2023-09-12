<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Login</title>

    <!-- Custom fonts for this template-->
    <link href="${path}/erpBt/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.css">
	<link rel="stylesheet" type="text/css" href="/erpBt/css/sb-admin-2.min.css">
	    <!-- Bootstrap core JavaScript-->
    <script src="${path}/erpBt/vendor/jquery/jquery.min.js"></script>
    <script src="${path}/erpBt/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${path}/erpBt/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${path}/erpBt/js/sb-admin-2.min.js"></script>
</head>
<style>

#logoImg {
	width:500px;
	padding-top:40px;
}

</style>
<script>
$(document).ready(function(){

	var loginErrorMessage = "${loginErrorMessage}"
	if(loginErrorMessage!=""){
		alert(loginErrorMessage)
	}
	
});
</script>
<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9 mt-5">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block">
                            	<img id="logoImg" src="${path}/erpBt/img/SMARTERP.jpg">
                            </div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">SMART ERP</h1>
                                    </div>
                                    <form method="post" action="/loginForm/login">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                id="username" name="username" aria-describedby="emailHelp"
                                                placeholder="아이디를 입력해주세요">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                id="password" name="password" placeholder="비밀번호를 입력해주세요">
                                        </div>
                                        <div class="mb-3 form-check">
							                <input type="checkbox" name="remember-me" id="rememberMe" class="form-check-input">
							                <label class="form-check-label" for="rememberMe">자동로그인</label>
							            </div> 
                                        <button id="loginBtn" type="submit" class="btn btn-primary btn-user btn-block">
                                            Login
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
</body>

</html>