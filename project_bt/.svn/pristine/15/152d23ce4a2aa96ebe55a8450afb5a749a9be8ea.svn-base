package com.web.erp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.erp.util.ChatHandler;

@Controller
public class ChattingController {
	@Autowired
	private ChatHandler chatHandler;
	
	@GetMapping("chatting")
	public String chatting() {
		return "chatting";
	}
	
	@GetMapping("getChatMem")
	public ResponseEntity<List<String>> getChatMem(){
		return ResponseEntity.ok(chatHandler.getIds());
	}
	
	// choMems.do
	@GetMapping("choMems")
	public ResponseEntity<String> choMems(
			@RequestParam("members") List<String> mems) {
		System.out.println("서버에 있는 데이터 크기 :"+mems.size());
		return ResponseEntity.ok(chatHandler.setMembers(mems));
	}
	
}
