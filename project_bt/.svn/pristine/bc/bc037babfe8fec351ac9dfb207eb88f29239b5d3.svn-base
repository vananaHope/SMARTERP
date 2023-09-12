package com.web.erp.security.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.web.erp.security.auth.EmployeeDetailService;
import com.web.erp.security.provider.EmployeeAuthenticatorProvider;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
@EnableMethodSecurity(prePostEnabled = true)
public class EmployeeSecurityConfig {
	
	@Autowired
	EmployeeAuthenticatorProvider employeeAuthenticatorProvider;
	
	@Autowired
	EmployeeDetailService employeeDetailService;
		
    @Autowired
    public void configure (AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(employeeAuthenticatorProvider);
    }
	
    @Bean
    public SecurityFilterChain employeeSecurityFilterChain (HttpSecurity http) throws Exception {
        http.csrf().disable();
        http.authorizeHttpRequests(authorize -> {
            try {
                authorize
                .requestMatchers(  
                		new AntPathRequestMatcher("/css/**"), new AntPathRequestMatcher("/images/**"), 
                		new AntPathRequestMatcher("/js/**"),
                		new AntPathRequestMatcher("/a00_com/**"), 
                		new AntPathRequestMatcher("/erpBt/**"),
                		new AntPathRequestMatcher("/gantt-master/**"),
                		new AntPathRequestMatcher("/WEB-INF/views/**")
                		)
                .permitAll()
                          
                .anyRequest()
                .authenticated() 
            .and()
                .formLogin()
                .loginPage("/loginForm") // 로그인 페이지 설정
                .loginProcessingUrl("/loginForm/login") // 로그인 처리 URL 설정
                .defaultSuccessUrl("/main") // 로그인 성공 후 이동할 페이지
                .successHandler(new EmployeeAuthSuccessHandler()) // 로그인 성공 후 처리할 핸들러
                .failureHandler(new EmployeeAuthFailureHandler()) // 로그인 실패 후 처리할 핸들러
                .permitAll()
            .and()
                .logout()
                .logoutUrl("/loginForm/logout") // 로그아웃 처리 URL 설정
                .logoutSuccessUrl("/loginForm?logout=1") // 로그아웃 성공 후 이동할 페이지
                .deleteCookies("JSESSIONID"); // 로그아웃 후 쿠키 삭제
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        });
        http
        	.exceptionHandling()
        	.accessDeniedHandler(new AccessDeniedHandlerImpl());
        http
        	.rememberMe()
                .key("erp") // 인증 토큰 생성시 사용할 키
                .tokenValiditySeconds(60 * 60 * 24 * 7) // 인증 토큰 유효 시간 (초)
                .userDetailsService(employeeDetailService) // 인증 토큰 생성시 사용할 UserDetailsService
                .rememberMeParameter("remember-me"); // 로그인 페이지에서 사용할 파라미터 이름
        
        return http.build();
    }
}
