package com.web.erp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.erp.service.ApvService;
import com.web.erp.vo.Approval;
import com.web.erp.vo.SchApv;

@Controller
public class ApvController {
	@Autowired
	private ApvService service;
	
	
	@RequestMapping("apvList")
	@PreAuthorize("hasAnyAuthority('사장','팀장')")
	public String apvList(@ModelAttribute("sch") SchApv sch,Model d) {
		
		d.addAttribute("apvList", service.apvList(sch));
		
		return "apvList";
	}
	
	@PostMapping("apvPaging")
	public ResponseEntity<Map<String, Object>> apvPaging(@ModelAttribute("sch") SchApv sch, Model model){
		List<Approval> pagingList = new ArrayList<>();
		pagingList = service.apvList(sch);
		
		Map<String, Object> responseData = new HashMap<>();
	    responseData.put("pagingList", pagingList);
	    responseData.put("sch", sch);
	    
	    return ResponseEntity.ok(responseData);
	}
	
	@RequestMapping("apvCurrent")
	@PreAuthorize("hasAnyAuthority('사장','팀장','본사직원')")
	public String apvCurrent(@ModelAttribute("sch") SchApv sch, Model model) {
		model.addAttribute("apvList", service.apvAll(sch));
	    return "apvCurrent";
	}
	
	@PostMapping("apvFilter")
	public ResponseEntity<Map<String, Object>> apvFilter(
			@ModelAttribute("sch") SchApv sch, Model model) {
		
	    List<Approval> filteredList = new ArrayList<>();
	    if (sch.getSelectedTab().equals("전체")) {
	        filteredList = service.apvAll(sch);
	    } else if (sch.getSelectedTab().equals("진행중")) {
	        sch.setNum(0); 
	        filteredList = service.apvFilter(sch);
	    } else if (sch.getSelectedTab().equals("승인")) {
	        sch.setNum(1);
	        filteredList = service.apvFilter(sch);
	    } else if (sch.getSelectedTab().equals("반려")) {
	        sch.setNum(2); 
	        filteredList = service.apvFilter(sch);
	    }

	    Map<String, Object> responseData = new HashMap<>();
	    responseData.put("filteredList", filteredList);
	    responseData.put("sch", sch);

	    return ResponseEntity.ok(responseData);
	}

	@RequestMapping("apvReg")
	@PreAuthorize("hasAnyAuthority('사장','팀장','본사직원')")
	public String apvReg(Model d){
		
		d.addAttribute("schList", service.schOrderID());
		d.addAttribute("schApprover", service.schApprover());
		
		return "apvReg";
	}
	
	@PostMapping("apvIns")
	public ResponseEntity<String> apvIns(Approval ins) {
		return ResponseEntity.ok(service.apvIns(ins));
	}
	
	@PostMapping("apvDetail")
	public ResponseEntity<Approval> apvDetail(
		@RequestParam(value="approval_id",defaultValue="") String approval_id){
		return ResponseEntity.ok(service.apvDetail(approval_id));
	}
	
	@PreAuthorize("hasAnyAuthority('사장','팀장')")
	@RequestMapping("upt")
	public ResponseEntity<String> upt(
			@RequestParam(value="approval_id", defaultValue="") String approval_id,
			@RequestParam(value="order_id", defaultValue="") String order_id,
			@RequestParam(value="num", defaultValue="0") int num){
		return ResponseEntity.ok(service.upt(approval_id, order_id, num));
	}
	
	@PreAuthorize("hasAnyAuthority('사장','팀장','본사직원')")
	@RequestMapping("uptApvCon")
	public ResponseEntity<String> uptApvCon(Approval apv) {
		
		return ResponseEntity.ok(service.uptApvCon(apv));
	}
	
	@PreAuthorize("hasAnyAuthority('사장','팀장','본사직원')")
	@RequestMapping("delApv")
	public ResponseEntity<String> delApv(Approval apv) {
			
		return ResponseEntity.ok(service.delApv(apv));
	}
}
