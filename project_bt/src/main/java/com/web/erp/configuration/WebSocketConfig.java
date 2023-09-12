package com.web.erp.configuration;

import java.util.logging.SocketHandler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.web.erp.util.ChatHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer{
	
	@Autowired
	ChatHandler chatHandler;

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// TODO Auto-generated method stub
		registry.addHandler(chatHandler, "/chat-ws");
		
	}
	
	
	

}
