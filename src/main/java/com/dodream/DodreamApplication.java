package com.dodream;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;

import com.navercorp.lucy.security.xss.servletfilter.XssEscapeServletFilter;

@SpringBootApplication
public class DodreamApplication {

	public static void main(String[] args) {
		SpringApplication.run(DodreamApplication.class, args);
	}

}

//package com.dodream;
//
//import org.springframework.boot.SpringApplication;
//import org.springframework.boot.autoconfigure.SpringBootApplication;
//import org.springframework.boot.builder.SpringApplicationBuilder;
//import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
//
//@SpringBootApplication
//public class DodreamApplication extends SpringBootServletInitializer {
//
//   @Override
//   protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
//      return application.sources(DodreamApplication.class);
//   }
//   
//   public static void main(String[] args) {
//      SpringApplication.run(DodreamApplication.class, args);
//   }
//
//}