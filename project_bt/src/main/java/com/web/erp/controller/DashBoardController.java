package com.web.erp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.erp.service.DashBoardService;

@Controller
public class DashBoardController {
	@Autowired
	private DashBoardService service;
		
	public String index(Model d) {
		d.addAttribute("emp", service.empCnt());
		d.addAttribute("store", service.storeCnt());
		d.addAttribute("brand", service.brandCnt());
		d.addAttribute("item", service.itemCnt());
		return "inasdfdex";
	}

}
