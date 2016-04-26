package com.qiyestore.grails.plugin.admin_web

import com.qiyestore.grails.plugin.admin_web.MenuUtils

class DashboardController {

	def index() {
		
		def countBoxes = TDashboardBox.createCriteria().list {
			eq('type', TDashboardBox.TYPE_COUNTBOX)
		}
		def listBoxes = TDashboardBox.createCriteria().list {
			eq('type', TDashboardBox.TYPE_LISTBOX)
		}
		render view:'/dashboard/index', model:[countBoxes:countBoxes, listBoxes:listBoxes]
	}

	def countAllUser() {
		def userCount = TUser.createCriteria().get {
			eq('enabled', true)
			projections {
				rowCount()
			}
		}
		render view:'/dashboard/countAllUser', model:[userCount: userCount, link: '/user/userList']
	}

	def listSystemMessage() {
		// FOR TEST
		render view:'/dashboard/listSystemMessage', model:[]
	}


	def listUserLog() {
		def userLogs = TUserLog.createCriteria().list(max:5) {
			order('id','desc')
		}
		render view:'/dashboard/listUserLog', model:[userLogs: userLogs]	
	}
}