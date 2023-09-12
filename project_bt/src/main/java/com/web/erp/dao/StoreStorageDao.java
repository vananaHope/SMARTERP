package com.web.erp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.web.erp.vo.StoreStorage;

@Mapper
public interface StoreStorageDao {
	public List<StoreStorage> schStoreStorage(int store_num);

	public int delSsPrd(StoreStorage del);

	public int uptSsPrd(StoreStorage upt);
}
