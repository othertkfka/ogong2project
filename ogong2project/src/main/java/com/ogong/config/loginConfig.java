/*
 * package com.ogong.config;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.context.annotation.Bean; import
 * org.springframework.context.annotation.Configuration; import
 * org.springframework.web.servlet.config.annotation.InterceptorRegistry; import
 * org.springframework.web.servlet.config.annotation.WebMvcConfigurer; import
 * com.ogong.common.web.LogonCheckInterceptor;
 * 
 * @Configuration public class loginConfig implements WebMvcConfigurer{
 * 
 * @Autowired LogonCheckInterceptor logonCheckInterceptor;
 * 
 * @Bean public LogonCheckInterceptor logonCheckInterceptor() { return new
 * LogonCheckInterceptor(); }
 * 
 * @Override public void addInterceptors(InterceptorRegistry registry) {
 * registry.addInterceptor(logonCheckInterceptor)
 * .addPathPatterns("/user/getProfile") .addPathPatterns("/user/restore")
 * .addPathPatterns("/user/updateProfile")
 * .addPathPatterns("/user/withdrawreason")
 * .addPathPatterns("/user/Changedpassword") .addPathPatterns("/study/**")
 * .addPathPatterns("/board/**") .addPathPatterns("/studyroom/**")
 * .excludePathPatterns("/user/loginView") .excludePathPatterns("/user/addUser")
 * .excludePathPatterns("/user/Changedpassword")
 * .excludePathPatterns("/user/getPassword");
 * 
 * } }
 */