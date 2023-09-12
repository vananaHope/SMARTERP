package com.web.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.DashBoardDao;
import com.web.erp.vo.DashBoard;

@Service
public class DashBoardService {
	@Autowired
	private DashBoardDao dao;
	
	public int empCnt() {
		return dao.empCnt();
	}
	public int storeCnt() {
		return dao.storeCnt();
	}
	public int brandCnt() {
		return dao.brandCnt();
	}
	public int itemCnt() {
		return dao.itemCnt();
	}
	public List<DashBoard> saleCntByBrand(){
		return dao.saleCntByBrand();
	}
	public List<DashBoard> totSaleByMonth(){
		return dao.totSaleByMonth();
	}
	public List<DashBoard> totSaleByStore(){
		return dao.totSaleByStore();
	}
	public List<DashBoard> orderEndDateDesc(){
		return dao.orderEndDateDesc();
	}
	public List<DashBoard> brandByBrandNum(String brand){
		if(brand==null) brand = "";
		return dao.brandByBrandNum(brand);
	}
}
