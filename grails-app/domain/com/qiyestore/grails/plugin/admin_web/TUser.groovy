package com.qiyestore.grails.plugin.admin_web

class TUser {

	def static Integer STATUS_NOACTIVE = 0 //未激活
	def static Integer STATUS_USE = 1;//正常使用(已激活)
	def static Integer STATUS_EXPIRE = -1;//到期 开发者账号到期
	def static Integer STATUS_LOCK = -2;//锁定
	def static Integer STATUS_DELETE = -3;//已删除
	

	String username
	String name
	String password
	String email
	String phone
	String nickname
	String comment
	Integer status=STATUS_NOACTIVE
	boolean enabled = true
	Date dateCreated
	Date lastUpdated
	Long lastLoginTime
	String lastRemoteIp
	String icon;
	Long createdById
	Long accountExpiredTime
	
	static constraints = {

		username blank: false, unique: true
		email blank: false, email: true
		password blank: false
	}

	static mapping = { 
		version false
		cache true
	}


	Set<TRole> getAuthorities() {
		TUserTRole.findAllByUser(this).collect { it.role } as Set
	}

	String toString() {
		"${username}"
	}

	boolean getAccountEnabled() {

		def bool = enabled;
		if(bool){
			if(accountExpiredTime){
				def nowTimes = (new Date()).getTime();
				if(nowTimes > accountExpiredTime){
					bool = false;
				}
			}
		}
		return bool;
	}
	
}
