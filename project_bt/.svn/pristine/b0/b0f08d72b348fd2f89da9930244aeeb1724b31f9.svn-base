package com.web.erp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.SessionDao;
import com.web.erp.vo.Employee;

@Service
public class SessionService {
	@Autowired
	private SessionDao dao;
	
	public Employee sessionEmp(String id, String password) {
		return dao.sessionEmp(id, password);
	}
}
