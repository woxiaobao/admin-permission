package com.qiyestore.grails.plugin.admin_web

import grails.converters.JSON;

class UserController {

	def userSecurityService

	def index() { redirect uri:'/dashboard'}


	def dashboard() {
    	render view:'/user/dashboard'
	}
	
	
	
    /***
	*	用户信息列表
	*
	**/
    def userList() {

		params.max = 25
		params.offset = params.offset?params.int('offset'):0
		def result;
		if(params.roleId){
			params.roleId = params.roleId as Long
			result = TUserTRole.createCriteria().list(max: params.max, offset: params.offset){
					createAlias "user", "user"
					createAlias "role", "role" 
					eq("role.id",params.roleId)
					if(params.username) eq("user.username",params.username)
					if(params.name) ilike("user.name", "%${params.name}%")
					order("user.id","desc");
					projections {
						property("user");
					}
				}
		}else{
			
			result = TUser.createCriteria().list(max: params.max, offset: params.offset, sort: 'dateCreated', order: 'desc'){
				ne("status",-1);
				if(params.username) eq("username",params.username)
				if(params.name) ilike("name", "%${params.name}%")
			}
		}


		def roles  = TRole.createCriteria().list(){};



		render(view: "/user/userList",model: [params:params,result:result,roles:roles,total:result.totalCount])
	}


	/***
	* 编辑用户管理
	*
	**/
	def userEdit = {


		//信息来源
		def refererUrl = request.getHeader("Referer");
		def user
		def existStr;//,";

		if(params.id){
			user = TUser.get(params.id as Long);
			if(user){

				def esits = TUserTRole.findAllByUser(user);
				if(esits){

					esits.each{
						//existStr = existStr + it.role?.id+",";
						existStr = it.role?.id;
						return;
					}
				}
			}
		}else{
			user = new TUser();
		}
		
		def roles = TRole.createCriteria().list(){};
		if(params.type=="1"){
			render(view: "/auth/authInfo",model: [params:params,user:user,roles:roles,existStr:existStr,refererUrl:refererUrl]);
			return
		}
		render(view: "/user/userEdit",model: [params:params,user:user,roles:roles,existStr:existStr,refererUrl:refererUrl]);
	}


	/***
	*
	* 验证用户名
	***/
	def checkUsername = {

		def username = params.username;

		//println "username="+username;


		def result = TUser.createCriteria().list(){
			eq("username",username);
		};

		if(result){//已经存在 不可以添加

			render(text: "0",contentType: "text/plain", status:response.SC_OK)
		}else{

			render(text: "1",contentType: "text/plain", status:response.SC_OK)
		}
	}

	def userSave = {
		//print "params="+params
		def user;
		if(params.id){
			user = TUser.get(params.id as Long);
		}

		if(!user){
			user = new TUser();
		}


		user.properties = params;

		def savePath = "${grailsApplication.config.upfile.savePath}";

		def userIcon = params.userIcon;
		if(userIcon){//将临时文件拷贝到正式文件夹
			// if(userIcon.indexOf("/tmp/")>-1){
			// 	def tmpPath = savePath + userIcon
			// 	def icon = userIcon.replace("/tmp/","${GlobalUtil.IMG_IOCN_PATH_PRE}/");
			// 	common.FileUtil.copy(tmpPath,(savePath+icon),true);
				user.icon = userIcon;
			// }
		}

		user.createdById = UserSecurity.currentUserId;
		if(params.pwd){
			user.password =userSecurityService.encodePassword(params.pwd);
			//log.info "user.password="+user.password
		}
		//print "user="+user.properties
		user.save(flush:true);

		if(params.roleId){
			def role = TRole.get(params.roleId as Long);
			if(role){
				TUserTRole.executeUpdate("delete TUserTRole m where m.user.id=:uid", [uid:user.id]);
				def  userTRole = new TUserTRole();
				userTRole.role = role;
				userTRole.user = user;
				userTRole.save(flush:true);
			}
		}

		render(text:"success",contentType: "text/plain", status:response.SC_OK)
	}


	/***
	*	删除用户
	*
	*
	****/
	def userDel = {

		if(params.id){
			
			def user = TUser.get(params.id as Long);
			user.status = -1;
			user.enabled = false;
			user.save(flush:true);
			render(text:"success",contentType: "text/plain", status:response.SC_OK)
		}else{

			render(text:"error",contentType: "text/plain", status:response.SC_OK)
		}

	}






	/**
	 * 创建模块
	 */
	def moduleEdit = {

		//信息来源
		def refererUrl = request.getHeader("Referer");
		
		def module;
		def parentModule;
		
		if(params.id){
			
			module = TModule.get(params.id as Long);
			if(module){
				parentModule = TModule.get(module.parentId);
			}
		}else{
			
			module = new TModule();
		}
		
		if(!parentModule && params.parentId){
			
			parentModule =  TModule.get(params.parentId as Long);
		}
		
		render(view: "/user/moduleEdit",model: [module:module,parentModule:parentModule,refererUrl:refererUrl]);
	}
	
	
	
	/**
	 * 保存模块
	 */
	def moduleSave = {
		
		def result = "success";
		def module;
		if(params.id){
			module = TModule.get(params.id as Long);
		}
		if(!module){
			module = new TModule();
		}
		module.properties = params
		
		module.save(flush:true);

		if(module.hasErrors()){
			println "module save error:"+module.errors;
			result ="fail";
		}
		
		render(text:result,contentType: "text/plain", status:response.SC_OK)
	}
	
	
	/**
	 * 删除模块
	 *
	 */
	def moduleDel = {
		
		def result = "success";
		def module;
		
		//println "params.id="+params.id;
		
		if(params.id){
			def chind = TModule.createCriteria().list {
				eq("parentId",params.id as Long);
			}
			
			if(chind){
				result ="child";
			}else{
				module = TModule.get(params.id as Long);
				if(module){
					module.delete(flush:true);
					//删除关联关系
					TRoleTModule.executeUpdate("delete TRoleTModule m where m.module.id=:mid", [mid:params.id as Long])
				}
			}
			
		}
		render(text:result,contentType: "text/plain", status:response.SC_OK)
	}

	//获取模块数
	def moduleTreeJson = {
		def role 
		def roleModules;
		def modules
		//信息来源
		def refererUrl = request.getHeader("Referer");
		
		modules = TModule.createCriteria().list {
			order("sortTop","desc")
		};

		if(params.id){
			role = TRole.get(params.id as Long);
			if(role){
				roleModules = TRoleTModule.createCriteria().list {
					eq("role",role)
					projections {
						property("module.id")
					}
				}
			}
		}

		def roleModuleStr="";
		if(roleModules){
			roleModuleStr = ",${roleModules.join(',')},";
		} 

		def treeJson = [];
		treeJson << [id:0, pId:-1, name:"模块", open:true];
		if(modules){
			modules.each{
				def pId = it.parentId?:0;
				def checked = false;
				if(roleModules){
					checked = roleModuleStr.indexOf(",${it.id},")>-1?true:false;
				}
				treeJson <<[id:it.id, pId:pId,isParent:true,checked:checked,name:"${it.name}", open:true];
			}
		}

		if(!role){
			role = new TRole();
		}
		render treeJson as JSON
	}



	def roleList = {

		params.max = 25
		params.offset = params.offset?params.int('offset'):0

		def result = TRole.createCriteria().list(max: params.max, offset: params.offset){

			if(params.name) eq("authority",params.name);
		};
		
		render(view: "/user/roleList",model: [params:params,result:result,total:result.totalCount]);

	}

	def roleEdit = {

 		def role 
		def roleModules;
		def modules
		//信息来源
		def refererUrl = request.getHeader("Referer");
		//print refererUrl
		modules = TModule.createCriteria().list {
			order("sortTop","desc")
		};

		if(params.id){
			role = TRole.get(params.id as Long);
			
		}

		//assets,auth,common,dashboard,code,user
		def control = ["assets","auth","common"]
		def data = []
         grailsApplication.controllerClasses.each { cont ->
         	
        	if(!control.any{ it == cont.logicalPropertyName}){
        		def controllerInfo = [:]
	    		controllerInfo.controller = cont.logicalPropertyName
	         	Set<String> actions = []
               	cont.getURIs().each {uri ->
                 	actions << cont.getMethodActionName(uri)
               	}
               	controllerInfo.actions = actions.sort()
               	data << controllerInfo
           	}
           
   		}
        //print data as JSON

		def roleModuleStr="";
		

		def treeJson = [];
		treeJson << [id:0, pId:-1, name:"模块", open:true];
		
		if(!role){
			role = new TRole();
		}

       render(view: "/user/roleEdit",model:[treeJson:treeJson as JSON,role: role,refererUrl:refererUrl, permission: data]);
    }
	
	

    /****
    *
	*	保存角色
    ***/
    def roleSave = {

    	def role; 

    	if(params.id){

    		role = 	TRole.get(params.id);
    	}

    	if(!role){
    		role = new TRole();
    		role.dateCreated = new Date(); 
    	}


    	role.lastUpdated = new Date(); 

        role.properties = params


		if(role.id){
			TRoleTModule.executeUpdate("delete TRoleTModule m where m.role.id=:rid", [rid:role.id])
		}
		
		role.save(flush:true);
		def rm = params.rs;

		//println "rm="+rm;
		if(rm){
			rm = rm.split(",");
			for(int i=0;i<rm.length;i++){
				def moduleId = rm[i];
				if(moduleId){
					def module = TModule.get(moduleId as Long);
					if(module){
						def t = new TRoleTModule();
						t.module = module;
						t.role = role;
						t.save(flush:true);
						if(t.hasErrors()){
							println t.errors;
						}
					}
				}
			}
		}
		render(text:"success",contentType: "text/plain", status:response.SC_OK)
    }

    def moduleList = {
		
		def modules;
		def parentModule;
		if(params.parentId){
			
			parentModule = TModule.get(params.parentId as Long);
			modules = TModule.createCriteria().list {
				eq("parentId",params.parentId as Long);
				order("sortTop","desc");
			}
		}else{
			
			modules = TModule.createCriteria().list {
				isNull("parentId")
				order("sortTop","desc");
			}
		}
		def treeJsonObject=[]; 
		def rs = TModule.createCriteria().list {
			isNull("parentId");
		};
		if(rs){
			rs.each{r->
				def children = getChildNodes(r);
				treeJsonObject << [name:"${r.name}",isParent:true,open:true,click:"callback(${r.id})",children:children];
			}
		}
		def treeJson = [];
		treeJson << [name:"模块",open:true,click:"callback('')",children:treeJsonObject];
		render(view: "/user/moduleList",model: [modules:modules,parentModule:parentModule,treeJson: treeJson as JSON]);
	}


    def getChildNodes(def module){

    	def result = [];
		def rs = TModule.createCriteria().list{
			eq("parentId",module?.id);
		}
		if(rs){
			rs.each{r->
				def children = getChildNodes(r);
				result << [name:"${r.name}",open:true,click:"callback(${r.id})",isParent:true,children:children];
			}
		}
		return result;
	}

}
