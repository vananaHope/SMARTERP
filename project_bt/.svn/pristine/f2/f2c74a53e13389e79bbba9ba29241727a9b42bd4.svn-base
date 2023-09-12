package com.web.erp.security.config;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EmployeeAuthSuccessHandler extends SimpleUrlAuthenticationSuccessHandler{
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        // 로그인 성공시 이동할 페이지
    	System.out.println("##성공페이지 이동 호출##"+authentication.getName());
    	setDefaultTargetUrl("/main");
        // 로그인 성공시 이동할 페이지로 이동
        super.onAuthenticationSuccess(request, response, authentication);
    }
}
