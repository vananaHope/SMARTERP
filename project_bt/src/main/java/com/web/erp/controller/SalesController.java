package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.erp.service.SalesService;
import com.web.erp.vo.Sales;
import com.web.erp.vo.SalesByDay;
import com.web.erp.vo.SalesDetail;

@Controller
public class SalesController {
	@Autowired
	private SalesService service;
	
	// http://localhost:5077/salesOfCompany
	@PreAuthorize("hasAnyAuthority('사장','팀장')")
	@GetMapping("salesOfCompany")
	public String salesOfCompany(@RequestParam(value="store_num",defaultValue="0")int stNum,
								@RequestParam(value="store_name",defaultValue="")String stName,Model d) {
		if(stNum != 0) {
			d.addAttribute("modal", "Y");
			d.addAttribute("stName", stName);
		}
		return "salesOfCompany";
	}
	@PreAuthorize("hasAnyAuthority('사장','팀장')")
	@RequestMapping("salesOfCompanyByStore")
	public ResponseEntity<List<Sales>> salesOfCompanyByStore(
				@RequestParam(value="store_name",defaultValue="")String store_name) {
		return ResponseEntity.ok(service.salesOfCompanyByStore(store_name));
	}
	@PreAuthorize("hasAnyAuthority('사장','팀장')")
	@RequestMapping("salesOfCompanyByBrand")
	public ResponseEntity<List<Sales>> salesOfCompanyByBrand(
				@RequestParam(value="brand_name",defaultValue="")String brand_name){
		return ResponseEntity.ok(service.salesOfCompanyByBrand(brand_name));
	}
	
	@PreAuthorize("hasAnyAuthority('사장','팀장','점주')")
	@RequestMapping("salesDetail")
	public ResponseEntity<List<SalesDetail>> salesDetail(
				@RequestParam(value="store_num",defaultValue="0")int store_num){
		return ResponseEntity.ok(service.salesDetail(store_num));
	}
	// http://localhost:5077/salesDetailByMonth?store_name=강남점&cur_year=2022&cur_month=8
	@PreAuthorize("hasAnyAuthority('사장','팀장','점주')")
	@RequestMapping("salesDetailByMonth")
	public ResponseEntity<SalesDetail> salesDetailByMonth(SalesDetail sch){
		return ResponseEntity.ok(service.salesDetailByMonth(sch));
	}
	
	@PreAuthorize("hasAuthority('점주')")
	@GetMapping("salesOfStore")
	public String salesOfStore() {
		return "salesOfStore";
	}
	
	// http://localhost:5077/salesByDay?store_name=강남점&sale_date=2023-08-21
	@PreAuthorize("hasAuthority('점주')")
	@RequestMapping("salesByDay")
	public ResponseEntity<List<SalesByDay>> salesDetailByDay(SalesByDay byDay){
		return ResponseEntity.ok(service.salesDetailByDay(byDay));
	}
}
