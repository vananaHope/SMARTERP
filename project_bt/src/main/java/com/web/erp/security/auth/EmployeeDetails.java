package com.web.erp.security.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.web.erp.vo.Employee;



public class EmployeeDetails implements UserDetails {
	
	private final Employee employee;

	public EmployeeDetails(Employee employee) {
		this.employee = employee;
	}
	
	public Employee getEmployee() {
		return employee;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = new ArrayList<>();
		System.out.println("롤:"+employee.getJob_level());
		authorities.add(new SimpleGrantedAuthority(employee.getJob_level()));
		return authorities;
	}

	@Override
	public String getPassword() {
		return employee.getPassword();
	}
	@Override
	public String getUsername() {
		return employee.getId();
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	@Override
	public boolean isEnabled() {
		return true;
	}
	
}
