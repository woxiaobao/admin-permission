package com.qiyestore.grails.plugin.admin_web

class TDashboardBox {

	static Integer TYPE_COUNTBOX = 1
	static Integer TYPE_LISTBOX = 2
	
	String image			// 图片
	String title			// 标题
	String descrption		// 描述
	Integer type = TYPE_COUNTBOX	// 类型
	String controllerName	// controllerName
	String actionName		// actionName
	
	static constraints = {
	}
	
	static mapping = {
		version false
		cache true
	}
	
}
