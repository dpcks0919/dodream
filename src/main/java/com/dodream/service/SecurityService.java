package com.dodream.service;

import org.springframework.stereotype.Service;

@Service
public class SecurityService {
	
	public String cleanXSS(String value) {
		
		if(  value == null || value.isEmpty() ) {
			return null;
		}
		
		value = value.replaceAll("<", " ").replaceAll(">", " ");
		value = value.replaceAll("\"", " ");
		value = value.replaceAll("\'", " ");
		value = value.replaceAll(";", " ");
		value = value.replaceAll("/", " ");
		value = value.replaceAll("script", " ");
		
		return value;	
	}
	
	public String cleanXSSSummerNote(String value) {
		
		if(  value == null || value.isEmpty() ) 
			return null;
		
		String[] imgTag = value.split("<img");
		
		if( imgTag.length > 1 ) {
			value = value.replace( imgTag[1].split("width:")[1].split(";")[0], "100%"  );
		}
		
		value = value.replaceAll("\'", "\"");
		value = value.replaceAll("script", " ");
		
		return value;	
	}
}
