package com.web.erp.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.erp.dao.PrmDao;
import com.web.erp.vo.Prm;
import com.web.erp.vo.PrmSch;

import jakarta.mail.Message.RecipientType;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;



@Service
public class PrmService {
	@Autowired
	private PrmDao dao;
	
	PasswordEncoder passwordEncoder;
	
	@Autowired(required=false)
	private JavaMailSender mailsender;
	
	
	public List<Prm> prm_getStoreName(Prm prm_store){
		if(prm_store.getStore_name()==null) prm_store.setStore_name("");
		return dao.prm_getStoreName(prm_store);
	}
	
	public List<Prm> prm_empList(Prm sch){
		return dao.prm_empList(sch);
	}
	
	public Prm empDetail(int employee_num){
		return dao.empDetail(employee_num);
	}
	public Prm myInfoDetail(int employee_num){
		return dao.myInfoDetail(employee_num);
	}
	
	@Value("${upload}")
	private String upload;
	public String updatePhoto(MultipartFile file, int employee_num, String employee_name) {
		System.out.println("입력한 파일 : "+file);
		System.out.println("입력한 직원번호 : "+employee_num);
		System.out.println("입력한 직원이름 : "+employee_name);
		String fname = file.getOriginalFilename();
		System.out.println("fname : "+fname);
		String Extension = fname.substring(fname.lastIndexOf("."));
		System.out.println("Extension : "+Extension);
		String newFileName = employee_num+"_"+employee_name+Extension;
		System.out.println("newFileName : "+newFileName);
		String msg = "파일 업로드 성공!!";
		String employee_photo=newFileName;
		System.out.println("사진 이름 : "+employee_photo);
		if(fname!=null && !fname.trim().equals("")) {
			File f = new File(upload+newFileName);
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				msg = "예외발생1:"+e.getMessage();
			} catch (IOException e) {
				msg = "예외발생2:"+e.getMessage();
			}
			if(msg.equals("파일 업로드 성공!!")) {
				System.out.println("파일 업로드 근황 : "+msg);
			}
		}
		return dao.updatePhoto(employee_photo, employee_num, employee_name)>0?
				"사진 등록 성공":"사진 등록 실패";
	}
	
	
	
	public String insertEmployee(Prm insert) {
		
		String emp_name = insert.getEmployee_name();
		int e_num = dao.schSeq();
		String emp_num = ""+e_num;
		insert.setEmployee_num(e_num);
		System.out.println("현재 직원 번호 "+emp_num);
		
		String date = insert.getHire_date();
		String year = date.substring(2, 4);
		System.out.println("추출한 년도 : "+year);
		
		String stNum = ""+insert.getStore_num();
		if(stNum.length()<3) {
			if(stNum.length()==2) {
				stNum="0"+stNum;
			}else if(stNum.length()==1) {
				stNum="00"+stNum;
			}
		}
		
		String userId = "ABC"+emp_num+stNum+year;
		System.out.println("직원 아이디 : "+userId);
		
		insert.setId(userId);
		
		String password = RandomStringUtils.randomAscii(8);
		System.out.println("직원 비밀번호 : "+password);
		
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		String hashed = passwordEncoder.encode(password);
		
		insert.setPassword(hashed);
		
		MimeMessage mmsg = mailsender.createMimeMessage();
		
		try {
			// 제목
			mmsg.setSubject("ABC마트 입사를 환영합니다!!");
			mmsg.setFrom(new InternetAddress("ssangyoungabc3@gmail.com"));
			// 수신자
			mmsg.setRecipient(RecipientType.TO, 
					new InternetAddress(insert.getEmail()));
			// 내용
			mmsg.setText("안녕하세요 ABC 마트입니다.\n"+emp_name+"님께서 "+date
					+"자로 ABC마트에 입사하신걸 진심으로 축하드립니다.\n"+emp_name+"직원님의 홈페이지 로그인 아이디 및 비밀번호 안내를 드립니다.\n"
					+"아이디 : "+userId+"\n비밀번호 : "+password+"\n비밀번호는 임시비밀번호이므로 개인정보 조회에서 변경하시길 권장드립니다.");
			// 발송
			mailsender.send(mmsg);
		} catch (MessagingException e) {
			System.out.println("메시지 전송 에러:"+e.getMessage());
		} catch(Exception e) {
			System.out.println("일반 에러:"+e.getMessage());
		}
		
		return dao.insertEmployee(insert)>0?emp_num:"등록실패";
	}
	
	public Prm schStorekeeper(Prm prm) {
		return dao.schStorekeeper(prm);
	}
	
	public String uptPass(Prm pass) {
			
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		String password = pass.getPassword();
		System.out.println("변경한 비밀번호 : "+password);
		String hashed = passwordEncoder.encode(password);
		
		pass.setPassword(hashed);
		
		return dao.uptPass(pass)>0?"변경 완료":"변경 실패";
	}
	
	public String uptEmployee(Prm upt) {
		
		if(upt.getResignation_day()!="") {
			upt.setAuth(5);
			upt.setId("");
			String password = RandomStringUtils.randomAscii(8);
			upt.setPassword(password);
			return dao.uptEmployee_Rd(upt)>0?"퇴사처리가 완료되었습니다":"퇴사처리 실패";
		}else {
			upt.setResignation_day("");
			String job_level = upt.getJob_level();
			int auth = upt.getAuth();
			if(auth==5) {
				if(dao.schStorekeeper(upt)==null) {
					if(job_level.equals("팀장")) upt.setAuth(2);
					if(job_level.equals("본사직원")) upt.setAuth(3);
					if(job_level.equals("점주")) upt.setAuth(2);
					if(job_level.equals("매니저")) upt.setAuth(3);
					if(job_level.equals("직원")) upt.setAuth(4);
				}else {
					if(job_level.equals("팀장")) upt.setAuth(2);
					if(job_level.equals("본사직원")) upt.setAuth(3);
					if(job_level.equals("매니저")) upt.setAuth(3);
					if(job_level.equals("직원")) upt.setAuth(4);
					if(job_level.equals("점주")) {
						return "점주의 복직 처리시에는 해당 점포의 점주유무를 확인해주세요";
					}
				}
			}
			return dao.uptEmployee(upt)>0?"직원 정보 수정이 완료되었습니다":"수정실패";
		}
	}
	
	public String delEmployee(Prm del) {
		if(del.getResignation_day()==null || del.getResignation_day().equals("")) {
			return "퇴사자만 정보 삭제가 가능합니다";
		}
		return dao.delEmployee(del)>0?"직원 삭제 완료":"삭제실패";
	}
	
	
	
	public List<Prm> schWords(PrmSch prmsch){
		// 초기값 처리로 전체 데이터 및 검색 처리
		String checking ="";
		checking= prmsch.getSchType();
		if(checking==null) checking="";
		System.out.println("입력받은 검색타입 : "+checking);
		
		if(checking=="") prmsch.setSchWord("");
		// 페이징 처리 - 불러올 전체 데이터 건수
		if(!checking.equals("")&&!checking.equals("employee_num")) {
			if(checking.equals("employee_name")) prmsch.setCount(dao.schCountEname(prmsch));
			if(checking.equals("store_name")) prmsch.setCount(dao.schCountSname(prmsch));
			if(checking.equals("job_level")) prmsch.setCount(dao.schCountJob(prmsch));
			if(checking.equals("phone_num")) prmsch.setCount(dao.schCountPnum(prmsch));
			if(checking.equals("hire_date_year")) prmsch.setCount(dao.schCountHd_year(prmsch));
			if(checking.equals("resignation_day_year")) prmsch.setCount(dao.schCountRd_year(prmsch));
			if(checking.equals("hire_date")) prmsch.setCount(dao.schCountHd(prmsch));
			if(checking.equals("resignation_day")) prmsch.setCount(dao.schCountRd(prmsch));
		}else {
			prmsch.setCount(dao.schCountEnum(prmsch));
		}
		if(prmsch.getPageSize()==0) prmsch.setPageSize(10);
		
		// 페이지 갯수 설정(전체 데이터 수에서 -1 하고, 보여줄 데이터 건수(getPageSize)로 나눈 다움에 전체값에 1을 더한다.
		// ex) 51건의 데이터가 있고, 한 페이지에 10개를 설정한다면, ((51-1)/10)+1 = 6개의 페이지
		int pageCnt = (int)Math.ceil(prmsch.getCount()/(double)prmsch.getPageSize());
		prmsch.setPageCount(pageCnt);
		
		if(prmsch.getCurPage()==0) prmsch.setCurPage(1);
		if(prmsch.getCurPage()>prmsch.getPageCount()) {
			prmsch.setCurPage(prmsch.getPageCount());
		}
		
		prmsch.setStart((prmsch.getCurPage()-1)*prmsch.getPageSize()+1);
		prmsch.setEnd(prmsch.getCurPage()*prmsch.getPageSize());
		
		prmsch.setBlockSize(5);
		
		int blockNum = (int)Math.ceil(prmsch.getCurPage()/
				(double)prmsch.getBlockSize());
		if(blockNum==0) blockNum=1;
		
		prmsch.setStartBlock((blockNum-1)*
				prmsch.getBlockSize()+1);
		prmsch.setEndBlock(blockNum*prmsch.getBlockSize());
		int endBlock = blockNum*prmsch.getBlockSize();
		if(endBlock>prmsch.getPageCount()) {
			endBlock = prmsch.getPageCount();
		}
		prmsch.setEndBlock(endBlock);
		if(!checking.equals("")&&!checking.equals("employee_num")) {
			if(checking.equals("employee_name")) return dao.schEmp_name(prmsch);
			if(checking.equals("store_name")) return dao.schStore_name(prmsch);
			if(checking.equals("job_level")) return dao.schJob_level(prmsch);
			if(checking.equals("phone_num")) return dao.schPhone_num(prmsch);
			if(checking.equals("hire_date_year")) return dao.schHire_date_year(prmsch);
			if(checking.equals("resignation_day_year")) return dao.schResignation_day_year(prmsch);
			if(checking.equals("hire_date")) return dao.schHire_date(prmsch);
			if(checking.equals("resignation_day")) return dao.schResignation_day(prmsch);
		}
		return dao.schEmp_num(prmsch);
	}
	
	
	
	
	
}








