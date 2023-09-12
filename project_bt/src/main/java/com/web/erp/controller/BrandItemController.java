package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.erp.service.BrandItemService;
import com.web.erp.vo.BrandItem;

@Controller
public class BrandItemController {
    @Autowired
    private BrandItemService service;

    @GetMapping("schBri")
    public ResponseEntity<List<BrandItem>> schBri(@RequestParam(value = "ref_num", defaultValue = "0") int ref_num) {
        List<BrandItem> brandItems = service.schBri(ref_num);
        return ResponseEntity.ok(brandItems);
    }
}
