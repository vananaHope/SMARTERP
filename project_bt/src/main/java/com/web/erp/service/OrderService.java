package com.web.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.OrderDao;
import com.web.erp.vo.Order;
import com.web.erp.vo.OrderGantt;
import com.web.erp.vo.SchPrd;

@Service
public class OrderService {
	@Autowired
	private OrderDao dao;
	
	public List<Order> orderGan(){
		return dao.orderGan();
	}
	
	public List<Order> schEmp(String employee_name){
		return dao.schEmp(employee_name);
	}
	
	public List<SchPrd> schPrd(String item_name){
		return dao.schPrd(item_name);
	}
	
    public String insertOrder(Order ins) {
    	int result = 1;
    	
    	for(int idx = 0; idx < ins.getProduct_num().size(); idx ++) {
    		Order order = new Order();
    		order.setProduct_nums(ins.getProduct_num().get(idx));
    		order.setEmployee_num(ins.getEmployee_num());
    		order.setStart(ins.getStart());
    		order.setEnd(ins.getEnd());
    		order.setOrder_counts(ins.getOrder_count().get(idx));
    		result = dao.insertOrder(order);
    	}
    
        return result > 0 ? "등록 성공" : "등록 실패";
    }
    
   public String uptOrder(OrderGantt upt) {
	   return dao.uptOrder(upt) > 0?"수정 성공":"수정 실패";
   }
   
   public String delOrder(String order_id) {
	   return dao.delOrder(order_id)>0?"삭제 성공":"삭제 실패";
   }
}
