package com.web.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.ProductPropertiesDao;
import com.web.erp.vo.ProductProperties;

@Service
public class ProductPropertiesService {
	@Autowired
	private ProductPropertiesDao dao;

	public List<ProductProperties> schPer(int properties_num) {
		return dao.schPer(properties_num);
	}
	public List<ProductProperties> schPersize(int ref_num) {
		return dao.schPersize(ref_num);
	}
}
