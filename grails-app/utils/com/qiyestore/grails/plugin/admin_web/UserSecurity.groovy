package com.qiyestore.grails.plugin.admin_web

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;


class UserSecurity {
	
	//当前用户
	private def static final CURRENT_USER_ID_KEY = "current_user_id";
	//当前用户连接
	private def static final CURRENT_USER_PERMISSION_KEY = "current_user_permission";
	//当前用户角色
	private def static final CURRENT_USER_ROLE_KEY = "current_user_role";

	def static initUser(def user){
		//print "initUser"
		def roles = TUserTRole.createCriteria().list {
			createAlias "user", "user" 
			createAlias "role", "role"
			eq("user",user);
			projections {  
				property("role")
			}
		}
		//将用户角色以及权限添加到session中
		def userRoles = [];
		Set<String> userPermi = new HashSet<String>();


		if(roles){
			roles.each {role->
				userRoles << role.authority;
				if(role.permissions){
					role.permissions.each {per->
						//print "\\|\\|"+per.permission
						def pary = per.permission.split("\\|\\|");
						pary.each {p->
							//print p
							userPermi.add(p);
						}
						//能够登陆就有的权限
						userPermi.add("common:*");
					}
				}

			}
			
			
			
		}

		// add userlog
		new TUserLog(user:user, actionType: TUserLog.ACTIONTYPE_LOGIN, actionTime: new Date()).save(flush:true)

		//初始化session 数据库
		getSession().setAttribute(CURRENT_USER_ID_KEY, user?.id);
		getSession().setAttribute(CURRENT_USER_ROLE_KEY, userRoles)
		getSession().setAttribute(CURRENT_USER_PERMISSION_KEY,userPermi)
		
	}
	
	def static getCurrentUserId(){
		return getSession().getAttribute(CURRENT_USER_ID_KEY) as Long;
	}
	
	
	/**
	 * 获得当前用户
	 * @return
	 */
	def static getCurrentUser(){
		
		return TUser.get(getCurrentUserId());
	}
	
	/**
	 * 当前用户是否包含某个角色
	 * @param permission
	 * @return
	 */
	def static hasRole(def roleName) {
		
		def roles = getAllRole();
		
		return roles?.contains(roleName);
	}
	
	
	/**
	 * 包含任意角色
	 * @return
	 */
	def static hasAnyRole(def roleNames){
		
		def roles = getAllRole();
		
		def tv = roleNames.each {role->
			if(roles?.contains(role)){
				return true;
			}
		}
		if(tv){
			return tv;
		}else{
			return false;
		}
	}
	
	
	/**
	 * 获得用户所有的角色
	 * @return
	 */
	def static getAllRole(){
		
		return getSession().getAttribute(CURRENT_USER_ROLE_KEY);
	}
	
	
	/**
	 * 获得用户的所有权限
	 * @return
	 */
	def static getAllPermission(){
		
		return getSession().getAttribute(CURRENT_USER_PERMISSION_KEY);
	}
	
	
	/**
	 * 获得
	 * @return
	 */
	def static Session getSession(){
		
		return SecurityUtils.subject.session;
	}
}

