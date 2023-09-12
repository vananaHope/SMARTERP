package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.erp.service.SaleHistoryService;
import com.web.erp.vo.RegSaleHistory;
import com.web.erp.vo.SaleHistory;

@Controller
@PreAuthorize("hasAnyAuthority('사장','팀장')")
public class SaleHistoryController {
	@Autowired
	private SaleHistoryService service;
	
	@GetMapping("regSaleHistory")
	public String regSaleHistory() {
		return "regSaleHistory";
	}
	
	@RequestMapping("rshStList")
	public ResponseEntity<List<SaleHistory>> stList(){
		return ResponseEntity.ok(service.stList());
	}
	@RequestMapping("schPrdByName")
	public ResponseEntity<List<SaleHistory>> schPrdByName(SaleHistory rsh){
		return ResponseEntity.ok(service.schPrdByName(rsh));
	}
	@RequestMapping("insertSaleHistory")
	public ResponseEntity<String> insertSaleHistory(RegSaleHistory ins){
		return ResponseEntity.ok(service.insertSaleHistory(ins));
	}
}
