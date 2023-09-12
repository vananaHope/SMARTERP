package com.web.erp.dao;
import java.util.List;

//	com.web.erp.dao.StoreDao
import org.apache.ibatis.annotations.Mapper;

import com.web.erp.vo.SchStore;
import com.web.erp.vo.StoreVO;

@Mapper
public interface StoreDao {
	
	public List<StoreVO> allStoreInfo(String store_name);
	// 점포당 직원 수 가져오기
	public int storeEmpCnt(int store_num);
	// 점포당 점주 가져오기
	public String getStoreKeeper(int store_num);
	// 본사 사장 가져오기
	public String getHOKeeper(int store_num);
	// 점포 상세 조회
	public StoreVO getStoreByNum(int store_num);
	// 점포 수정
	public int uptStoreInfo(StoreVO upt);
	// 점포 삭제
	public int delStoreInfo(int store_num);
	// 페이징 처리를 위한 전체 점포 건수를 중복제거한 값
	public int totStoreManage(SchStore sch);
	// 점포 리스트 조회 및 페이징 처리
	public List<StoreVO> schStoreManage(SchStore sch);
}
