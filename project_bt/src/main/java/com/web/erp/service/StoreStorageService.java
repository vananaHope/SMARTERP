package com.web.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.StoreStorageDao;
import com.web.erp.vo.StoreStorage;

@Service
public class StoreStorageService {
	@Autowired
	private StoreStorageDao dao;

	// 점포에 등록된 상품 조회
	public List<StoreStorage> schStoreStorage(int store_num) {
		
		return dao.schStoreStorage(store_num);
	}

	// 점포에 등록된 상품 삭제
	public String delSsPrd(StoreStorage del) {
		int result = 0;
		for (int idx = 0; idx < del.getProduct_nums().length; idx++) {
			StoreStorage ss = new StoreStorage();
			ss.setProduct_num(del.getProduct_nums()[idx]);
			result = dao.delSsPrd(ss);
		}
		return result > 0 ? "삭제성공" : "삭제실패";
	}

	// 점포에 등록된 재고 업데이트

	public String uptSsPrd(StoreStorage upt) {
		String msg = "sucs";
		for (int idx = 0; idx < upt.getProduct_nums().length; idx++) {
			upt.setProduct_num(upt.getProduct_nums()[idx]);
			upt.setStorage_count(upt.getCounts()[idx]);

			if (dao.uptSsPrd(upt) == 0) {
				msg = "failure2";
				break;
			}
		}

		return msg;
	}

}
