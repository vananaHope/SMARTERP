package com.web.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.SaleHistoryDao;
import com.web.erp.vo.RegSaleHistory;
import com.web.erp.vo.SaleHistory;

@Service
public class SaleHistoryService {
	@Autowired
	private SaleHistoryDao dao;
	
	public List<SaleHistory> stList(){
		return dao.stList();
	}
	public List<SaleHistory> schPrdByName(SaleHistory rsh){
		if(rsh.getItem_name()==null) rsh.setItem_name("");
		return dao.schPrdByName(rsh);
	}
	public String insertSaleHistory(RegSaleHistory ins) {
		int result = 0;
		
		for(int i=0; i<ins.getStore_product_id().size(); i++) {
			RegSaleHistory rsh = new RegSaleHistory();
			RegSaleHistory upt = new RegSaleHistory();
			// 판매 내역 insert
			rsh.setStore_product_ids(ins.getStore_product_id().get(i));
			rsh.setTotal_prices(ins.getTotal_price().get(i));
			rsh.setSale_counts(ins.getSale_count().get(i));
			rsh.setSale_date(ins.getSale_date());
			// 재고 수량 update
			upt.setStore_product_ids(ins.getStore_product_id().get(i));
			upt.setStore_num(ins.getStore_num());
			upt.setSale_counts(ins.getSale_count().get(i));
			System.out.println("insert 전: "+result);
			if(dao.insertSaleHistory(rsh)>0) {
				System.out.println("## 업데이트 ##");
				System.out.println("재고 감소 수량: "+upt.getSale_counts());
				System.out.println("점포 번호: "+upt.getStore_num());
				System.out.println("상품 아이디: "+upt.getStore_product_ids());
				result = dao.updateStoreStorage(upt);
				System.out.println("insert 후: "+result);
			}
		}
		return result>0?"등록성공":"등록실패";
	}
}
