package com.qiyestore.grails.plugin.admin_web

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import com.qiyestore.grails.plugin.admin_web.UserSecurity;
import grails.converters.JSON;

class MenuUtils{

	def static menu(def request){
		/*
			def menu="""
				<li class=''>
				    <a href='${request.contextPath}/'>
				      <i class='fa fa-dashboard'></i>
				      <span>首　　页</span>
				    </a>
				</li>

			"""
			*/
		Set<String> userPermi = UserSecurity.getAllPermission()
		Set<String> list=[]
		userPermi.each{ per ->
			//print per
			def moduleString = per.split(":")[0]
			//if(moduleString != 'dashboard') 
			list << moduleString
			//getModuleByName(moduleString)
		}
		def menu = getModuleByName(list, request)
		print menu
		menu
	}

	def static getModuleByName(def tname, def request){
		def menu=''
		//使用set集合去重
		Set<TModule> set = []
		def list = TModule.createCriteria().list {
			'in'("tname",tname);
		}
		list.each{
			set << it
			if(it.parentId) set << TModule.get(it.parentId)
			
		}
		menu = getMenuByModule(set, request)
		menu
	}

	def static getMenuByModule(def list, def request){
		//print list
		def menu = ''
		def parentMenu = []
		def sonMenu = []
		list.each{
			if(!it?.parentId) parentMenu << it
			else sonMenu << it
		}
		parentMenu.each{ p ->
			def hasSon = false
			sonMenu.each{ s ->
				if(s?.parentId == p?.id) hasSon = true
			}

			if(hasSon){
				menu += """
				<li class='treeview active' >
				    <a href="#">
				      <i class='fa ${p.moduleImg}'></i> <span>${p.name}</span><i class='fa fa-angle-left pull-right'></i>
				    </a>
				    <ul style='display:none;' class='treeview-menu'>
				"""
				sonMenu.each{ s ->
					if(s.parentId == p.id){
						menu += """
						<li class=''>
					      <a style='margin-left: 10px;' href='${request.contextPath}/${s.tname}/${s.taction}'><i class='fa ${s.moduleImg}'></i> ${s.name}</a>
					    </li>
						"""
					}
				}

				menu += """
					</ul>
				</li>
				"""
			}else{
				menu += """
				<li class=''>
				  <a href='${request.contextPath}/${p?.tname}/${p?.taction}'>
				    <i class='fa ${p?.moduleImg}'></i> <span>${p?.name}</span></i>
				  </a>
				</li>
				"""
			}
		}
		menu

	}

}