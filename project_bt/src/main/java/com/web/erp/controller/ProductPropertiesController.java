package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.erp.service.ProductPropertiesService;
import com.web.erp.vo.ProductProperties;

@Controller
public class ProductPropertiesController {
	@Autowired
	private ProductPropertiesService service;
	
	@RequestMapping("schPer")
	@ResponseBody
	public ResponseEntity<List<ProductProperties>> schPer(@RequestParam(value = "properties_num", defaultValue = "0") int properties_num) {
		return ResponseEntity.ok(service.schPer(properties_num));
	}
	
	// http://localhost:5077/schPerSize?ref_num=100
	@RequestMapping("schPerSize")
	public ResponseEntity<List<ProductProperties>> schPersize(@RequestParam(value = "ref_num", defaultValue = "0") int ref_num) {
		return ResponseEntity.ok(service.schPersize(ref_num));
	}
}
