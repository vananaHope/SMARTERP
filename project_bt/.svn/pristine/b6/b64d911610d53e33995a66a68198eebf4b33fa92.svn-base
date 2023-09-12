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
import org.springframework.web.multipart.MultipartFile;

import com.web.erp.service.PrmService;
import com.web.erp.vo.Prm;
import com.web.erp.vo.PrmSch;

@Controller
@PreAuthorize("hasAnyAuthority('사장','팀장','본사직원')")
public class PrmController {
	@Autowired
	private PrmService service;
	
// http://localhost:5077/hrm
	
	@RequestMapping("hrm")
	public String hrm() {
		return "hrm";
	}
	
	// http://localhost:5077/prm_getStoreName
	@RequestMapping("prm_getStoreName")
	public ResponseEntity<List<Prm>> prm_getStoreName(Prm prm_store) {
		return ResponseEntity.ok(service.prm_getStoreName(prm_store));
	}
	
	// http://localhost:5077/prm_empList	
	@PostMapping("prm_empList")
	public ResponseEntity<List<Prm>> prm_empList(Prm sch) {
		return ResponseEntity.ok(service.prm_empList(sch));	
	}
	
	// http://localhost:5077/empDetail	
	@PostMapping("empDetail")
	public ResponseEntity<Prm> empDetail(int employee_num){
		return ResponseEntity.ok(service.empDetail(employee_num));
	}
	
	
	// http://localhost:5077/insertEmployee
	@RequestMapping("insertEmployee")
	public ResponseEntity<String> insertEmployee(Prm insert){
		return ResponseEntity.ok(service.insertEmployee(insert));
	}
	
	// upload메서드
	@RequestMapping("uploadPhoto")
	public ResponseEntity<String> uploadPhoto(@RequestParam("employee_photo") MultipartFile file,
											@RequestParam("employee_num") int employee_num,
											@RequestParam("employee_name") String employee_name){
		return ResponseEntity.ok(service.updatePhoto(file, employee_num, employee_name));
	}
	
	@RequestMapping("schStorekeeper")
	public ResponseEntity<Prm> schStorekeeper(Prm prm){
		return ResponseEntity.ok(service.schStorekeeper(prm));
	}
	
	@RequestMapping("uptEmployee")
	public ResponseEntity<String> uptEmployee(Prm upt){
		return ResponseEntity.ok(service.uptEmployee(upt));
	}
	
	@RequestMapping("delEmployee")
	public ResponseEntity<String> delEmployee(Prm del){
		return ResponseEntity.ok(service.delEmployee(del));
	}
	
	@RequestMapping("prmsch")
	public ResponseEntity<Map<String, Object>> schWords(
			@ModelAttribute("prmsch") PrmSch prmsch, Model d){
		List<Prm> prmlist = new ArrayList<>();
		prmlist = service.schWords(prmsch);
		System.out.println("반환 데이터 갯수 "+prmlist.size());
		Map<String, Object> returnData = new HashMap<>();
		returnData.put("prm_list", prmlist);
		returnData.put("prmsch", prmsch);
		return ResponseEntity.ok(returnData);
	}
	
	
	@PreAuthorize("hasAnyAuthority('사장','팀장','본사직원','점주','매니저','직원')")
	@PostMapping("myInfoDetail")
	public ResponseEntity<Prm> myInfoDetail(int employee_num){
		return ResponseEntity.ok(service.empDetail(employee_num));
	}
	
	@PreAuthorize("hasAnyAuthority('사장','팀장','본사직원','점주','매니저','직원')")
	@PostMapping("uptPass")
	public ResponseEntity<String> uptPass(Prm pass){
		return ResponseEntity.ok(service.uptPass(pass));
	}
	
	
//	@RequestMapping("hrm")
//	public String schWords(@ModelAttribute("prmschW") PrmSch prmschW, Model d) {
//		d.addAttribute("hrmWord", service.schWords(prmschW));
//		return "hrm";
//	}
	
//	@RequestMapping("hrmDate")
//	public ResponseEntity<List<PrmSch>> schDates(@ModelAttribute("prmschD") PrmSch prmschD, Model d){
//		d.addAttribute("schHrm", service.schDates(prmschD));
//		return ResponseEntity.ok(service.schDates(prmschD));
//	}
}
