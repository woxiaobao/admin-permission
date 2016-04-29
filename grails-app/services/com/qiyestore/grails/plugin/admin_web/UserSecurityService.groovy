package com.qiyestore.grails.plugin.admin_web

class UserSecurityService {

	def shiroSecurityService

	/**
	 * 加密密码
	 * @param pwd
	 * @return
	 */
	def encodePassword(String pwd){
		return shiroSecurityService.encodePassword(pwd);
	}


	def initDB() {
		def adminUser = TUser.createCriteria().get {
        	eq('username', 'admin')
        }
        if(adminUser) {
        	log.debug 'Username "admin" exists!'
        } else {
            print "initDB"
        	adminUser = new TUser(username:'admin', name:'系统管理员', password:this.encodePassword('111111'), email:'admin@qiyestore.com', nickname:'Admin', status:TUser.STATUS_USE, comment:'GENERATED at BOOTSTRAP').save(flush:true)
        	
            def ind = new TPermission(mname:'查',permission:'dashboard:*').save(flush:true)

            def baseModule = new TModule(name:'首   页',moduleImg:'fa-dashboard', tname:'dashboard',taction:'index',, permissions:[ind]).save(flush:true)

            def a = new TPermission(mname:'查',permission:'user:index,dashboard,userList').save(flush:true)
            def aa = new TPermission(mname:'增',permission:'user:checkUsername,userEdit,userSave').save(flush:true)
            def aaa = new TPermission(mname:'删',permission:'user:userDel').save(flush:true)

            def b = new TPermission(mname:'查',permission:'user:moduleTreeJson,moduleList').save(flush:true)
            def bb = new TPermission(mname:'增',permission:'user:moduleEdit,moduleSave').save(flush:true)
            def bbb = new TPermission(mname:'删',permission:'user:moduleDel').save(flush:true)

            def c = new TPermission(mname:'查',permission:'user:roleList').save(flush:true)
            def cc = new TPermission(mname:'增',permission:'user:roleEdit,getPerByRole,roleSave').save(flush:true)

        	def baseRole = new TRole(authority:'ROLE_USER', permissions:[ind, a, b, c]).save(flush:true)

            def adminRole = new TRole(authority:'ROLE_ADMIN', permissions:[ind, a, b, c, aa, bb, cc, aaa, bbb]).save(flush:true)
            new TUserTRole(role:adminRole, user: adminUser).save(flush:true)

            def adminModule = new TModule(name:'权限管理', moduleImg:'fa-users', tname:'user').save(flush:true)
            def moduleModule = new TModule(name:'模块管理', moduleImg:'fa-folder-o', tname:'user',taction:'moduleList', parentId: adminModule.id, permissions:[b, bb, bbb]).save(flush:true)
            def roleModule = new TModule(name:'角色管理', moduleImg:'fa-male', tname:'user',taction:'roleList', parentId: adminModule.id, permissions:[c, cc]).save(flush:true)
            def userModule = new TModule(name:'用户管理', moduleImg:'fa-user-plus', tname:'user', taction:'userList', parentId: adminModule.id, permissions:[a, aa, aaa]).save(flush:true)

            log.debug 'DB init OK!'

        }

        def dbBoxes = TDashboardBox.count()
        if(dbBoxes==0) {
            log.debug 'DashboardBox is empty. Init It!'

            new TDashboardBox(title:'用户数', description:'显示用户总数', type:TDashboardBox.TYPE_COUNTBOX, controllerName:'dashboard', actionName:'countAllUser').save(flush:true)
            new TDashboardBox(title:'系统通知', description:'最新的5条系统通知列表', type:TDashboardBox.TYPE_LISTBOX, controllerName:'dashboard', actionName:'listSystemMessage').save(flush:true)
            new TDashboardBox(title:'用户操作记录', description:'最新的6条用户操作记录', type:TDashboardBox.TYPE_LISTBOX, controllerName:'dashboard', actionName:'listUserLog').save(flush:true)
            log.debug 'DashboardBox init OK!'

        }
	}
}
