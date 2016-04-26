package com.qiyestore.grails.plugin.admin_web

class TConfig {
	
	String code;
	String value;
	String remark;
	
	
	static constraints = {
		remark nullable :true
	}
	
	static mapping = {
		version false
		cache true
	}
	
}
