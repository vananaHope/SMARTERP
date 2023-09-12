package com.web.erp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.web.erp.vo.DashBoard;

@Mapper
public interface DashBoardDao {
	public int empCnt();
	public int storeCnt();
	public int brandCnt();
	public int itemCnt();
	public List<DashBoard> saleCntByBrand();
	public List<DashBoard> totSaleByMonth();
	public List<DashBoard> totSaleByStore();
	public List<DashBoard> orderEndDateDesc();
	public List<DashBoard> brandByBrandNum(String brand);
	
	
}
