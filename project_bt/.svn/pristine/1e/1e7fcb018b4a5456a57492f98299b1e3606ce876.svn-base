package com.web.erp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.web.erp.vo.Order;
import com.web.erp.vo.OrderGantt;
import com.web.erp.vo.SchPrd;

@Mapper
public interface OrderDao {
	public List<Order> schEmp(String employee_name);
	public List<SchPrd> schPrd(String item_name);
	public int insertOrder(Order ins);
	public int getNo();
	public List<Order> orderGan();
	public int uptOrder(OrderGantt upt);
	public int delOrder(String order_id);
}
