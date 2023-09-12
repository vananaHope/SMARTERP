package com.web.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.BrandItemDao;
import com.web.erp.vo.BrandItem;

@Service
public class BrandItemService {
    @Autowired
    private BrandItemDao dao;

    public List<BrandItem> schBri(int ref_num) {
        return dao.schBri(ref_num);
    }
}
