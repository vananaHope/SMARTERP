package com.web.erp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class test {
	
	//
	// http://localhost:5077/test
	@GetMapping("test")
	public String test1() {
		return "test";
	}

	
	
}
