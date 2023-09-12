package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.erp.entity.Store;
import com.web.erp.service.StoreService;
import com.web.erp.vo.SchStore;
import com.web.erp.vo.StoreVO;

@Controller
public class StoreController {
	// http://localhost:5077/storeInfo
	// JPA = entity Store
	// mybatis = vo StoreVO
	@Autowired
	private StoreService service;
	
	@PreAuthorize("permitAll()")
	@GetMapping("storeInfo")	// 점포조회 페이지
	public String storeInfo(Model d) {
//		d.addAttribute("stFindAll", service.findAll());
		return "storeInfo";
	}
	@RequestMapping("storeList")	// 맵 마커를 위한 위도, 경도
	public ResponseEntity<List<Store>> storeInfo(){
		return ResponseEntity.ok(service.findAll());
	}
	@RequestMapping("storeInfoList")	// 점포 조회 검색
	public ResponseEntity<List<Store>> storeInfoList(Store sch){
		return ResponseEntity.ok(service.findByNameAndCity(sch));
	}
	@RequestMapping("findDistinctCities")		// 시/도 select 배열 가져오기
	public ResponseEntity<List<String>> findDistinctCities(){
		return ResponseEntity.ok(service.findDistinctCities());
	}
	
	@PreAuthorize("hasAuthority('사장')")
	@GetMapping("storeManage")	// 점포리스트 초기 페이지
	public String storeManage(@ModelAttribute("sch")SchStore sch, Model d) {		
		d.addAttribute("storeList", service.schStoreList(sch));
		return "storeManage";
	}
	/*
	@RequestMapping("schStoreList")	// 점포리스트 조회 및 검색
	public String schStoreList(StoreVO sch,Model d){
		d.addAttribute("storeList", service.schStoreList(sch));
		return "storeManage";
	}
	*/
	@PreAuthorize("hasAuthority('사장')")
	@RequestMapping("insertStore")	// 점포 등록(JPA)
	public String insertStore(Store store,Model d) {
		d.addAttribute("msg", service.save(store));
		return "storeManage";
	}
	@PreAuthorize("hasAuthority('사장')")
	@RequestMapping("updateStore")	// 점포 수정
	public String updateStore(StoreVO store,Model d) {
		d.addAttribute("msg", service.uptStoreInfo(store));
		return "storeManage";
	}
	// http://localhost:5077/deleteStore?store_num=13
	@PreAuthorize("hasAuthority('사장')")
	@RequestMapping("deleteStore")	// 점포 삭제
	public ResponseEntity<String> deleteStore(
							@RequestParam("store_num")int stNum) {
		return ResponseEntity.ok(service.delStoreInfo(stNum));
	}
	
	@PreAuthorize("hasAuthority('사장')")
	@RequestMapping("getStoreByNum")	// 점포 상세 정보 조회
	public ResponseEntity<StoreVO> getStoreByNum(
							@RequestParam("store_num")int stNum){
		return ResponseEntity.ok(service.getStoreByNum(stNum));
	}
}
