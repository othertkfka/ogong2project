package com.ogong.config;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebListener
public class SessionListener implements HttpSessionListener {

	private Logger log = LoggerFactory.getLogger(this.getClass());

    @Override
    public void sessionCreated(HttpSessionEvent se) {

        se.getSession().setMaxInactiveInterval(60*600); //세션만료600분

    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {

    }

}
