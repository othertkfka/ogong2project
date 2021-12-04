package com.ogong;


import javax.servlet.http.HttpSessionListener;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

import com.ogong.config.SessionListener;

@ServletComponentScan
@EnableAspectJAutoProxy
@SpringBootApplication
public class OgongApplication {

	public static void main(String[] args) {
		SpringApplication.run(OgongApplication.class, args);
	}
	
	@Bean
	public HttpSessionListener httpSessionListener() {
		return new SessionListener();
	}

}
