package com.web.erp.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.StoreDao;
import com.web.erp.entity.Store;
import com.web.erp.repository.StoreRepository;
import com.web.erp.vo.SchStore;
import com.web.erp.vo.StoreVO;

@Service
public class StoreService {
	@Autowired
	private StoreRepository storeRepository;
	// 점포 리스트 - 점포 등록
	public String save(Store store) {
		return storeRepository.save(store)!=null?"등록성공":"등록실패";
	}
	// 카카오맵 마커 position에 할당될 위/경도
	public List<Store> findAll(){
		return storeRepository.findAll();
	}
	// 점포 조회 검색
	public List<Store> findByNameAndCity(Store sch){
		if(sch.getStore_name()==null) sch.setStore_name("");
		if(sch.getCity()==null) sch.setCity("");
		if(sch.getRegion()==null) sch.setRegion("");
		
		return storeRepository.findByNameAndCity(sch);
	}
	// 점포별 지역 중복 제거 값 (시/도 검색)
	public List<String> findDistinctCities(){
		return storeRepository.findDistinctCities();
	}
	
	
	@Autowired
	private StoreDao dao;
	
	public List<StoreVO> schStoreList(SchStore sch){
		List<StoreVO> stList = new ArrayList<StoreVO>();
		// 초기값 처리로 전체 데이터 및 검색 처리
		if(sch.getStore_name()==null) sch.setStore_name("");
		
		// 페이징 처리
		sch.setCount(dao.totStoreManage(sch));
		if(sch.getPageSize()==0) sch.setPageSize(5);
		
		int pageCnt = (int)Math.ceil(sch.getCount()/(double)sch.getPageSize());
		sch.setPageCount(pageCnt);
		
		
		if(sch.getCurPage()==0) sch.setCurPage(1);
		if(sch.getCurPage()>sch.getPageCount()) {
			sch.setCurPage(sch.getPageCount());
		}
		
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		sch.setEnd(sch.getCurPage()*sch.getPageSize());
		
		sch.setBlockSize(5);
		int blockNum = (int)Math.ceil(sch.getCurPage()/
							(double)sch.getBlockSize());
		if(blockNum==0) blockNum = 1;
		sch.setStartBlock((blockNum-1)*
						sch.getBlockSize()+1);
		sch.setEndBlock(blockNum*sch.getBlockSize());
		int endBlock = blockNum*sch.getBlockSize();
		if(endBlock>sch.getPageCount()) {
			endBlock = sch.getPageCount();
		}
		sch.setEndBlock(endBlock);
		
		
//		if(sch.getStore_name()==null) sch.setStore_name("");
		for(StoreVO st:dao.schStoreManage(sch)) {
			// 점포 별 직원 수
			st.setStEmpCnt(dao.storeEmpCnt(st.getStore_num()));
			if(st.getStore_num()==0) {
				// 본사 사장 (점포번호 = 0) 
				st.setStKeeper(dao.getHOKeeper(st.getStore_num()));
			} else {
				// 점포 별 점주
				st.setStKeeper(dao.getStoreKeeper(st.getStore_num()));
			}
			
			System.out.println(st.getStEmpCnt());
			System.out.println(st.getStKeeper());
			stList.add(st);
		}
	
		return stList;
	};
	
	public StoreVO getStoreByNum(int stNum) {
		return dao.getStoreByNum(stNum);
	}
	
	public String uptStoreInfo(StoreVO upt) {
		return dao.uptStoreInfo(upt)>0?"수정성공":"수정실패";
	}
	public String delStoreInfo(int stNum) {
		return dao.delStoreInfo(stNum)>0?"삭제성공":"삭제실패";
	}
}
