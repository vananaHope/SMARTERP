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

import com.web.erp.service.StoreStorageService;
import com.web.erp.vo.StoreStorage;

@Controller
@PreAuthorize("hasAnyAuthority('점주','매니저','직원')")
public class StoreStorageController {
	@Autowired
	private StoreStorageService service;

	@GetMapping("storeStorage")
	public String storeStorage() {
		return "storeStorage";
	}

	@RequestMapping("ssPrdList")
	public ResponseEntity<List<StoreStorage>> schStoreStorage(
			@RequestParam(value = "store_num", defaultValue = "0") int store_num) {
		return ResponseEntity.ok(service.schStoreStorage(store_num));
	}

	@RequestMapping("delSsPrd")
	public ResponseEntity<String> delSsPrd(StoreStorage del) {
		return ResponseEntity.ok(service.delSsPrd(del));
	}

	@RequestMapping("uptSsPrd")
	public ResponseEntity<String> uptSsPrd(StoreStorage upt) {
		return ResponseEntity.ok(service.uptSsPrd(upt));
	}

}
