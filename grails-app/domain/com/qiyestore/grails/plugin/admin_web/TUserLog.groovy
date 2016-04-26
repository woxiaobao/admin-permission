package com.qiyestore.grails.plugin.admin_web

class TUserLog {
	static Integer ACTIONTYPE_DEFAULT = 0
	static Integer ACTIONTYPE_LOGIN = 1

	TUser user
	Integer actionType = ACTIONTYPE_DEFAULT
	Date actionTime = new Date()

	static constraints = {
	}

	static mapping = { 
		version false
		cache true
	}

}