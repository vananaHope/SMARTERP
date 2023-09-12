package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.web.erp.service.OrderService;
import com.web.erp.vo.Order;
import com.web.erp.vo.OrderGantt;
import com.web.erp.vo.SchPrd;

@Controller
public class OrderController {
	@Autowired
	private OrderService service;
	
	@GetMapping("orderList")
	@PreAuthorize("permitAll()")
	public String orderList() {
		return "orderList";
	}
	
	
	// http://localhost:5077/orderReg
	@GetMapping("orderReg")
	@PreAuthorize("hasAnyAuthority('사장','점주','매니저')")
	public String orderReg() {
		return "orderReg";
	}
	
	// 담당자 검색
	@RequestMapping("schEmp")
	@PreAuthorize("hasAnyAuthority('사장','점주','매니저')")
	public ResponseEntity<List<Order>> schEmp
	(@RequestParam(value="employee_name",defaultValue="") String employee_name){
		return ResponseEntity.ok(service.schEmp(employee_name));
	}
	
	// 품목명 검색
	@PreAuthorize("hasAnyAuthority('사장','점주','매니저')")
	@RequestMapping("schPrd")
	public ResponseEntity<List<SchPrd>> schPrd
	(@RequestParam(value="item_name",defaultValue="") String item_name){
		return ResponseEntity.ok(service.schPrd(item_name));
	}
	
	
	// 발주 등록
	@PreAuthorize("hasAnyAuthority('사장','점주','매니저')")
	@PostMapping("insertOrder")
	public ResponseEntity<String> insertOrder(Order ins) {
		return ResponseEntity.ok(service.insertOrder(ins));
	}
	
	// 발주 내역 조회
	@RequestMapping("orderGan")
	public ResponseEntity<List<Order>> orderGan() {
		return ResponseEntity.ok(service.orderGan());
	}
	
	// 발주 내용 수정
	@PreAuthorize("hasAnyAuthority('사장','점주','매니저','팀장')")
	@RequestMapping("uptOrder")
	public ResponseEntity<String> uptOrder(OrderGantt upt) {
		return ResponseEntity.ok(service.uptOrder(upt));
	}
	
	// 발주 내용 삭제
	@PreAuthorize("hasAnyAuthority('사장','점주','매니저','팀장')")
	@RequestMapping("delOrder")
	public ResponseEntity<String> delOrder(@RequestParam(value="id", defaultValue="") String order_id){
		return ResponseEntity.ok(service.delOrder(order_id));
	}
	
}
