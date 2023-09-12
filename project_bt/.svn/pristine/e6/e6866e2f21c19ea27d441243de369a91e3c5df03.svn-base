package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.web.erp.service.HeadOfficeProductService;
import com.web.erp.vo.HeadOfficeProduct;
import com.web.erp.vo.SchPrd;

@Controller
public class HeadOfficeProductController {
	@Autowired
	private HeadOfficeProductService service;
	
	
	@GetMapping("product")
	public String product() {
		return "product";
	}
	
	@RequestMapping("prdList")
	public ResponseEntity<List<SchPrd>> schHeadPrd(
			@RequestParam(value = "item_name", defaultValue = "") String item_name) {
		return ResponseEntity.ok(service.schHeadPrd(item_name));
	}

	//
	@RequestMapping("delHeadPrd")
	public ResponseEntity<String> delHeadPrd(HeadOfficeProduct del) {
		return ResponseEntity.ok(service.delHeadPrd(del));
	}

	// 등록
//	@RequestMapping("insHeadPrd")
//	public ResponseEntity<String> insHeadPrd(HeadOfficeProduct ins) {
//		return ResponseEntity.ok(service.insHeadPrd(ins));
//	}
	
	@RequestMapping("insHeadPrd")
	public String insHeadPrd(HeadOfficeProduct ins, RedirectAttributes d) {
		d.addFlashAttribute("msg", service.insHeadPrd(ins));
		return "redirect:/product";
	}
	
	@RequestMapping("uptHeadPrd")
	public ResponseEntity<String> uptHeadPrd(HeadOfficeProduct upt) {
		return ResponseEntity.ok(service.uptHeadPrd(upt));
	}

}
