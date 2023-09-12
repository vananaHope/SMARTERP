package com.web.erp.security.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.web.erp.dao.SessionDao;
import com.web.erp.vo.Employee;



@Service
public class EmployeeDetailService implements UserDetailsService {
	
	@Autowired
	private SessionDao sessionDao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		Employee employee = sessionDao.findId(username);
		System.out.println("username:"+username);
		System.out.println("employee:"+employee);
		
		if(employee == null) {
			throw new UsernameNotFoundException("아이디를 찾을 수 없습니다.");
			
		}
		
		return new EmployeeDetails(employee);
		
	}
	
}
