package com.kh.common.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionCounterListener implements HttpSessionListener {
	public static int activeSessions = 0;

	private void printSessionCount() {
		System.out.println("[현재 접속자 수 : "+activeSessions+" ]");
	}
	
	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		activeSessions++;
		printSessionCount();
	}


	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		activeSessions--;
		printSessionCount();
	}

}
