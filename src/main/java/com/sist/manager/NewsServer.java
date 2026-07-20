package com.sist.manager;

import jakarta.websocket.server.ServerEndpoint;

/*
 *     프로그램 시작
 *        | ==> 접속자 저장 => Set : 중복 방지 = static : 한개만 가지고 사용
 *     스케쥴러 생성 => 쓰레드
 *        |
 *     1분마다 실행
 *        |
 *     뉴스 검색
 *        | JSON
 *     접속자에게 전송 Ajax 출력
 *        
 */
import java.util.*;
import java.util.concurrent.*;
import jakarta.websocket.*;
import jakarta.websocket.server.*;
import java.io.*;
@ServerEndpoint("/news")
public class NewsServer {
	private static Set<Session> clients=ConcurrentHashMap.newKeySet();
	private static ScheduledExecutorService scheduler=Executors.newScheduledThreadPool(1);
	static {
		scheduler.scheduleAtFixedRate(()->{
			try {
				String json=NewsManagerRT.newsRealTimeData("K리그");
				if (json != null) {
	                broadcast(json);
	            }
			}catch(IllegalStateException e){
				scheduler.shutdown();
			}
			catch(Exception ex) {
				ex.printStackTrace();
			}
		},0,60,TimeUnit.SECONDS);
	}
	@OnOpen
	public void onOpen(Session session) {
		clients.add(session);
		System.out.println("클라이언트 접속:"+session.getId());
	}
	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("클라이언트 종료:"+session.getId());
	}
	@OnMessage
	public void onMessage(String msg,Session session) {
		System.out.println("클라이언트 메세지:"+msg);
	}
	public static void broadcast(String message) {
		for(Session session:clients) { 
			if(session.isOpen()) {
				try {
					session.getBasicRemote().sendText(message);
				}catch(Exception ex) {
					ex.printStackTrace();
				}
			}
		}
	}
}