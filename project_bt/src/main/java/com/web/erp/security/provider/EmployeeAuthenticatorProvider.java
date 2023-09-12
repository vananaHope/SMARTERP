package com.web.erp.security.provider;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.web.erp.vo.Employee;
import com.web.erp.security.auth.EmployeeDetailService;
import com.web.erp.security.auth.EmployeeDetails;

@Component
public class EmployeeAuthenticatorProvider implements AuthenticationProvider{
	
	@Autowired
	private EmployeeDetailService employeeDetailService;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String username = authentication.getName();
		String password = (String) authentication.getCredentials();
		System.out.println("사용자가 입력한 패스워드:"+password);
		
		EmployeeDetails employeeDetails = (EmployeeDetails) employeeDetailService.loadUserByUsername(username);
		
		String dbPassword = employeeDetails.getPassword();
		System.out.println("저장된 db 패스워드:"+dbPassword);
		
		PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		 System.out.println("# 비교 #");
		 System.out.println("비교1:"+password.equals(dbPassword));
		  
		 if(!passwordEncoder.matches(password, dbPassword)) {
			 System.out.println("비밀번호가 일치하지 않습니다."); 
			 throw new BadCredentialsException("아이디 또는 비밀번호가 일치하지 않습니다."); 
		 }
		
        Employee employee = employeeDetails.getEmployee();
        if(employee == null) {
        	System.out.println("사용할 수 없는 계정입니다.");
        	throw new BadCredentialsException("[사용자] 사용할 수 없는 계정입니다.");
        }
        
        System.out.println(employeeDetails.getAuthorities());
        System.out.println("사용자:"+employeeDetails.getUsername());
        System.out.println("권한:"+new UsernamePasswordAuthenticationToken(employeeDetails, null, employeeDetails.getAuthorities()).getCredentials());
        
		return new UsernamePasswordAuthenticationToken(employeeDetails, null, employeeDetails.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
	

	
}
