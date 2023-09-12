package com.web.erp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.web.erp.vo.Sales;
import com.web.erp.vo.SalesByDay;
import com.web.erp.vo.SalesDetail;
@Mapper
public interface SalesDao {
	// salesOfCompany
	// 점포별 매출
	public List<Sales> salesOfCompanyByStore(String store_name);
	// 브랜드별 매출
	public List<Sales> salesOfCompanyByBrand(String brand_name);
	// 점포 일별 매출
	public List<SalesDetail> salesDetail(int store_num);
	// 점포 월별 매출
	public SalesDetail salesDetailByMonth(SalesDetail sch);
	
	// salesOfStore
	public List<SalesByDay> salesDetailByDay(SalesByDay byDay);
}
