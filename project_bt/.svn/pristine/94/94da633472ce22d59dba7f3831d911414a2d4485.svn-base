package com.web.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.SalesDao;
import com.web.erp.vo.Sales;
import com.web.erp.vo.SalesByDay;
import com.web.erp.vo.SalesDetail;

@Service
public class SalesService {
	@Autowired
	private SalesDao dao;
	
	public List<Sales> salesOfCompanyByStore(String store_name){
		return dao.salesOfCompanyByStore(store_name);
	}
	public List<Sales> salesOfCompanyByBrand(String brand_name){
		return dao.salesOfCompanyByBrand(brand_name);
	}
	public List<SalesDetail> salesDetail(int store_num){
		return dao.salesDetail(store_num);
	}
	public SalesDetail salesDetailByMonth(SalesDetail sch) {
		SalesDetail sd = dao.salesDetailByMonth(sch);
		if(sd==null) sd = new SalesDetail(0,0);
		return sd;
	}
	
	
	public List<SalesByDay> salesDetailByDay(SalesByDay byDay) {
		return dao.salesDetailByDay(byDay);
	}

}
