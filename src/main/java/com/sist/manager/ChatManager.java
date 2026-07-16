package com.sist.manager;
import java.util.*;

import com.sist.vo.ChatVO;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.EndpointConfig;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint(value="/chat",configurator=WebSocketSessionConfigurator.class)
public class ChatManager {
	private static Map<Session, ChatVO> users=Collections.synchronizedMap(new HashMap<Session, ChatVO>());
	
	@OnOpen
	public void connection(Session session,EndpointConfig config) throws Exception{
		ChatVO vo=new ChatVO();
		HttpSession hs=(HttpSession)config.getUserProperties().get(HttpSession.class.getName());
		vo.setId((String)hs.getAttribute("user.id"));
		vo.setName((String)hs.getAttribute("user.name"));
		vo.setSession(session);
		users.put(session, vo);
		Iterator<Session> it=users.keySet().iterator();
		while(it.hasNext()) {
			Session ss=it.next();
			if(!ss.getId().equals(session.getId())) {
				ss.getBasicRemote().sendText(
						"msg:[📢 알림]"+vo.getName()+"님이 입장하셨습니다"
						);
			}
		}
		System.out.println("클라이언트 접속:"+vo.getId()+","+vo.getName()+","+vo.getSession().getId());
	}
	@OnClose
	public void disConnection(Session session) throws Exception {
		ChatVO vo = users.get(session);
		if(vo!=null) {
			Iterator<Session> it=users.keySet().iterator();
			while(it.hasNext()) {
				Session ss=it.next();
				if(!ss.getId().equals(session.getId())) {
					ss.getBasicRemote().sendText(
							"msg:[📢 알림]"+vo.getName()+"님이 퇴장하셨습니다"
							);
				}
			}
			System.out.println("클라이언트 접속 종료:"+users.get(session).getName());
			users.remove(session);
		}
	}
	@OnMessage
	public void message(String message,Session session) throws Exception {
		System.out.println("수신된 메세지:"+message+","+users.get(session).getName());
		Iterator<Session> it=users.keySet().iterator();
		while(it.hasNext()) {
			Session ss=it.next();
			ChatVO vo=users.get(session);
			if(session.getId().equals(ss.getId())) {
				ss.getBasicRemote().sendText(
						"my:["+vo.getName()+"] "+message
						);
			}else {
				ss.getBasicRemote().sendText(
						"you:["+vo.getName()+"] "+message
						);
			}
		}
	}
	@OnError
	public void error(Session session,Throwable ex) {
		ex.printStackTrace();
	}
}
