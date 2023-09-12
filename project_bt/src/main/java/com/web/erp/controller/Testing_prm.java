package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.erp.service.PrmService;
import com.web.erp.vo.Prm;

@RestController
public class Testing_prm {
	@Autowired
	private PrmService service; 
	
	// http://localhost:5077/getStorename2
}
