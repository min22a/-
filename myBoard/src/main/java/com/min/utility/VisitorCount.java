package com.min.utility;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import lombok.Getter;

@Getter
public class VisitorCount implements HttpSessionListener{

	public static int visitorcount;
	
	public static int getvisitorcount() {
		return visitorcount;
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
		HttpSession session = se.getSession();
		
		session.setMaxInactiveInterval(1200);	
		
		visitorcount++;
		
		session.getServletContext().log(session.getId()+"세션ID"+"접속자수는" +visitorcount);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
		visitorcount--;
		if(visitorcount<0) {
			visitorcount = 0;
		}
		
		HttpSession session = se.getSession();
		
		session.getServletContext().log("세션종료"+"접속자수는" +visitorcount);
	}
	
	
}
