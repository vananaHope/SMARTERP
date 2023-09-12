package com.web.erp.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

import com.web.erp.vo.Employee;

@Mapper
public interface SessionDao {
	public Employee sessionEmp(String id, String password);
	public Employee findId(@Param("username") String username);
}
