package com.web.erp.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.HeadOfficeProductDao;
import com.web.erp.vo.HeadOfficeProduct;
import com.web.erp.vo.SchPrd;

@Service
public class HeadOfficeProductService {
	@Autowired
	private HeadOfficeProductDao dao;

	public List<SchPrd> schHeadPrd(String item_name) {
		return dao.schHeadPrd(item_name);
	}

	// 삭제
	public String delHeadPrd(HeadOfficeProduct del) {
		int results = 0;
		for (int idx = 0; idx < del.getProduct_nums().length; idx++) {

			HeadOfficeProduct hop = new HeadOfficeProduct();
			hop.setProduct_num(del.getProduct_nums()[idx]);
			results = dao.delHeadPrd(hop);
		}

		return results > 0 ? "삭제를 성공했습니다" : "삭제실패";
	}

	public String insHeadPrd(HeadOfficeProduct ins) {
		String msg = "상품을 등록 했습니다";

		for (int idx = 0; idx < ins.getProperties_num().length; idx++) {
			ins.setProperties_nums(ins.getProperties_num()[idx]);

			if (dao.insHeadPrd(ins) == 0) {
				msg = "failure";
				break;
			}
		}

		return msg;
	}


	// 업데이트
	public String uptHeadPrd(HeadOfficeProduct upt) {
		String msg = "sucs";

		for (int idx = 0; idx < upt.getProduct_nums().length; idx++) {
			upt.setProduct_num(upt.getProduct_nums()[idx]);
			upt.setProduct_count(upt.getCounts()[idx]); // 이렇게 사용

			if (dao.uptHeadPrd(upt) == 0) {
				msg = "failure2";
				break;
			}
		}

		return msg;
	}

}
