package com.web.erp.security.config;

import java.io.IOException;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class EmployeeAuthFailureHandler extends SimpleUrlAuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws ServletException, IOException {
        // 실패 메세지를 담기 위한 세션 선언
        HttpSession session = request.getSession();
        // 세션에 실패 메세지 담기
        session.setAttribute("loginErrorMessage", exception.getMessage());
        // 로그인 실패시 이동할 페이지
        setDefaultFailureUrl("/loginForm?error=true&t=h");
        // 로그인 실패시 이동할 페이지로 이동
        super.onAuthenticationFailure(request, response, exception);
    }
}
