package com.qiyestore.grails.plugin.admin_web

class TModule {
	
	String name;
	String tname;
	String taction;
	String moduleImg;
	Long  parentId;
	Integer sortTop=0;
	
	static constraints = {
	}
	
	static mapping = {
		version false
		cache true
	}
	
}
