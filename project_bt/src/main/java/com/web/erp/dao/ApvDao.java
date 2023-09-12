package com.web.erp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.web.erp.vo.Approval;
import com.web.erp.vo.DupStr;
import com.web.erp.vo.SchApv;

@Mapper
public interface ApvDao {
	public List<Approval> schOrderID();
	public List<Approval> schApprover();
	public int apvIns(Approval ins);
	public List<Approval> apvList(SchApv apv);
	public int totApv(SchApv apv);
	public int totFil(SchApv apv);
	public int totAll(SchApv apv);	
	public List<Approval> apvFilter(SchApv apv);
	public List<Approval> apvAll(SchApv apv);
	public Approval apvDetail(String approval_id);
	
	public int uptApvCon(Approval apv);
	public int delApv(Approval apv);
	
	public int uptApvAgr(String approval_id);
	public int uptApvDeny(String approval_id);
	public int uptOrdAgr(String order_id);
	public int uptOrdDeny(String order_id);
	
	public int insApvAgrStr(String order_id);
	public DupStr dupStr(String order_id);
	
	public int ordCount(String order_id);
	public String ssCount(String order_id);
	public int hopCount(String order_id);
	
	public int ssUpt(@Param("count") int count, @Param("order_id") String order_id);
	public int hopUpt(@Param("count") int count, @Param("order_id") String order_id);
	
}
