package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.erp.security.auth.EmployeeDetails;
import com.web.erp.service.DashBoardService;
import com.web.erp.service.SessionService;
import com.web.erp.vo.DashBoard;
import com.web.erp.vo.Employee;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SessionController {
	
	@Autowired
	private SessionService service;
	@Autowired
	private DashBoardService dbService;
	
	@GetMapping("/check-session")
	public ResponseEntity<String> checkSession() {
	    return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping("/error")
	public String error() {
		return "error";
	}
	
	@RequestMapping("/main")
	public String main(@AuthenticationPrincipal EmployeeDetails employeeDetails,
			HttpSession session) {
		
		Employee employee = employeeDetails.getEmployee();
		if(employee != null) session.setAttribute("employee", employee);
		
		return "main";
	}
	
	@PreAuthorize("hasAuthority('사장')")
	@RequestMapping("index")
	public String index(Model d) {
		
		d.addAttribute("emp", dbService.empCnt());
		d.addAttribute("store", dbService.storeCnt());
		d.addAttribute("brand", dbService.brandCnt());
		d.addAttribute("item", dbService.itemCnt());
		d.addAttribute("saleByBrand", dbService.saleCntByBrand());
		
		return "index";
	}
	@RequestMapping("saleCntByBrand")
	public ResponseEntity<List<DashBoard>> saleCntByBrand(){
		return ResponseEntity.ok(dbService.saleCntByBrand());
	}
	@RequestMapping("totSaleByMonth")
	public ResponseEntity<List<DashBoard>> totSaleByMonth(){
		return ResponseEntity.ok(dbService.totSaleByMonth());
	}
	@RequestMapping("totSaleByStore")
	public ResponseEntity<List<DashBoard>> totSaleByStore(){
		return ResponseEntity.ok(dbService.totSaleByStore());
	}
	@RequestMapping("orderEndDateDesc")
	public ResponseEntity<List<DashBoard>> orderEndDateDesc(){
		return ResponseEntity.ok(dbService.orderEndDateDesc());
	}
	@RequestMapping("brandByBrandNum")
	public ResponseEntity<List<DashBoard>> brandByBrandNum(
						@RequestParam(value="brand",defaultValue="")String brand){
		return ResponseEntity.ok(dbService.brandByBrandNum(brand));
	}
    private boolean isAuthenticated() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || AnonymousAuthenticationToken.class.isAssignableFrom(authentication.getClass())) {
            return false;
        }
        return authentication.isAuthenticated();
    }
    
    @GetMapping("/loginForm")
    public String login(HttpServletRequest request,@RequestParam(value="logout", defaultValue = "0") int outFlag,
                        @AuthenticationPrincipal EmployeeDetails employeeDetails) {
        HttpSession session = request.getSession();
        String msg = (String) session.getAttribute("loginErrorMessage");
        session.setAttribute("loginErrorMessage", msg != null ? msg : "");
        System.out.println("메시지:"+msg);
        System.out.println("로그인여부:"+isAuthenticated());
        

        if(outFlag==1) {
        	session.removeAttribute("employee");
        }
        if(isAuthenticated()) {
            if(employeeDetails == null) {
            	System.out.println("#로그아웃 처리#");
            	
                return "redirect:/loginForm/logout";
            }
            	return "redirect:/main";
        }

        return "login";
    }

/*	
	@PostMapping("login")
	public String session(@RequestParam(value="id", defaultValue="") String id,
						@RequestParam(value="password", defaultValue="") String password,
						Model model,HttpServletRequest request) {
		
		
		Employee employee =  service.sessionEmp(id, password);
		
		if(employee == null) {
			model.addAttribute("loginFail","아이디 또는 비밀번호가 틀렸습니다.");
			return "login";
		}
		
		if(employee != null) {
			request.getSession().invalidate();
			HttpSession session = request.getSession(true);
			session.setAttribute("session", employee);
			if(employee.getAuth() == 1) {
				return "redirect:/index";
			}
		}
		
		
		return "redirect:/orderReg";
	}
	
	@RequestMapping("logout")
	public String logout(HttpServletRequest request) {
		
		HttpSession logout = request.getSession(false);
		
		if(logout != null) {
			logout.invalidate();
		}
		
		return "redirect:/login";
	}*/
	
}
