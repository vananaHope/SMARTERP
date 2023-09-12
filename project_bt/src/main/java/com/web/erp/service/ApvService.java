package com.web.erp.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.erp.dao.ApvDao;
import com.web.erp.vo.Approval;
import com.web.erp.vo.DupStr;
import com.web.erp.vo.SchApv;
import com.web.erp.vo.StoreVO;

@Service
public class ApvService {
	@Autowired
	private ApvDao dao;
	
	public List<Approval> schOrderID(){
		return dao.schOrderID();
	}
	
	public List<Approval> schApprover(){
		return dao.schApprover();
	}
	
	public String apvIns(Approval ins) {
		return dao.apvIns(ins)>0?"결재 신청이 완료되었습니다"
				:"결재 신청이 실패하였습니다. 담당자에게 문의하세요";
	}
	
	public String uptApvCon(Approval apv) {
		return dao.uptApvCon(apv)>0?"수정 성공":"수정 실패";
	}
	
	public String delApv(Approval apv) {
		return dao.delApv(apv)>0?"삭제 성공":"삭제 실패";
	}
	
	public List<Approval> apvList(SchApv sch){

		// 초기값 처리로 전체 데이터 및 검색 처리
		if(sch.getSubject()==null) sch.setSubject("");
		
		// 페이징 처리
		sch.setCount(dao.totApv(sch));
		if(sch.getPageSize()==0) sch.setPageSize(10);
		
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
		
		return dao.apvList(sch);	
	}
	
	public List<Approval> apvAll(SchApv sch){
		
		// 초기값 처리로 전체 데이터 및 검색 처리
		if(sch.getSubject()==null) sch.setSubject("");
		
		// 페이징 처리
		sch.setCount(dao.totAll(sch));
		if(sch.getPageSize()==0) sch.setPageSize(10);
		
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
		
		return dao.apvAll(sch);	
	}
	
	public List<Approval> apvFilter(SchApv sch){
				
		// 초기값 처리로 전체 데이터 및 검색 처리
		if(sch.getSubject()==null) sch.setSubject("");
		
		// 페이징 처리
		sch.setCount(dao.totFil(sch));
		if(sch.getPageSize()==0) sch.setPageSize(10);
		
		int pageCnt = (int)Math.ceil(sch.getCount()/(double)sch.getPageSize());
		sch.setPageCount(pageCnt);
		
		
	    if (sch.getCurPage() <= 0) {
	        sch.setCurPage(1); 
	    }
	    
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
		
		
		return dao.apvFilter(sch);
	}
	
	public Approval apvDetail(String approval_id) {
		return dao.apvDetail(approval_id);
	}
	
	// 결재 승인, 반려 
	public String upt(String approval_id, String order_id, int num) {
		String result = "";
		DupStr ds = dao.dupStr(order_id);

		if(num == 1) {
			int ord = dao.ordCount(order_id);
			String ss = dao.ssCount(order_id);
			int hop = dao.hopCount(order_id);
			int ssNum = 0;
			
			if(ss == null || ss == "") {
				ssNum = 0;
			}else {
				ssNum = Integer.parseInt(ss);
			}
			
			if(hop == 0) {
				result = "재고 부족! 담당자에게 문의하세요";
				return result;
			}
			
			if(hop > 0 && hop >= ord) {
				int ssCnt = ord + ssNum;
				int hopCnt = hop - ord;
				if(ds == null) {
					dao.uptApvAgr(approval_id);
					dao.uptOrdAgr(order_id);
					dao.insApvAgrStr(order_id);
					dao.hopUpt(hopCnt,order_id);
					result = "승인되었습니다!";
					return result;
				}else if(ds != null) {
					dao.uptApvAgr(approval_id);
					dao.uptOrdAgr(order_id);
					dao.ssUpt(ssCnt,order_id);
					dao.hopUpt(hopCnt,order_id);
					result = "승인되었습니다.";
					return result;
				}
				
			}else if(hop > 0 && hop < ord) {
				result = "재고 부족! 담당자에게 문의하세요";
				return result;
			}
		}
		if(num == 2) {
			dao.uptApvDeny(approval_id);
			dao.uptOrdDeny(order_id);
			result = "반려되었습니다.";
		}
		return result;
	}
}
