package com.qiyestore.grails.plugin.admin_web

/**
 * 权限
 * @author LVBAOLIN
 *
 */

class TPermission {
	
	String permission; //具体权限
	String mname; //在module对应permission下使用
	//String type = "role";//“role”默认表示role-permission，“module”表示module-permission

    static constraints = {
    }
}
