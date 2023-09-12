package com.web.erp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.web.erp.vo.Prm;
import com.web.erp.vo.PrmSch;


@Mapper
public interface PrmDao {
	
	public List<Prm> prm_getStoreName(Prm prm_store);
	
	public List<Prm> prm_empList(Prm sch);
	
	public Prm empDetail(int employee_num);
	
	public Prm myInfoDetail(int employee_num);
	
	public int insertEmployee(Prm insert);
	
	public int schSeq(); 
	
	public int updatePhoto(String employee_photo, int employee_num, String employee_name);
	
	public Prm schStorekeeper(Prm prm);

	public int uptEmployee(Prm upt);
	
	public int uptEmployee_Rd(Prm upt);
	
	public int delEmployee(Prm del);
	
	public int uptPass(Prm pass);
	
//	public List<Prm> schEmp_All(PrmSch prmsch);
	
	public List<Prm> schEmp_num(PrmSch prmsch);
	public List<Prm> schEmp_name(PrmSch prmsch);
	public List<Prm> schStore_name(PrmSch prmsch);
	public List<Prm> schJob_level(PrmSch prmsch);
	public List<Prm> schPhone_num(PrmSch prmsch);
	public List<Prm> schHire_date_year(PrmSch prmsch);
	public List<Prm> schResignation_day_year(PrmSch prmsch);
	public List<Prm> schHire_date(PrmSch prmsch);
	public List<Prm> schResignation_day(PrmSch prmsch);
	
//	public int schEmpCount_All(PrmSch prmschW);
	
	public int schCountEnum(PrmSch prmsch);
	public int schCountEname(PrmSch prmschW);
	public int schCountSname(PrmSch prmschW);
	public int schCountJob(PrmSch prmschW);
	public int schCountPnum(PrmSch prmschW);
	public int schCountHd_year(PrmSch prmschW);
	public int schCountRd_year(PrmSch prmschW);
	public int schCountHd(PrmSch prmschW);
	public int schCountRd(PrmSch prmschW);
	
}
