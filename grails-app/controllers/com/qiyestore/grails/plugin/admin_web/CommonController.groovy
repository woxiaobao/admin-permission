package com.qiyestore.grails.plugin.admin_web

import com.qiyestore.grails.plugin.admin_web.MenuUtils

class CommonController {

    def index() { }

    def getLeftMenu(){
    	def menu = MenuUtils.menu()
    	render menu
    }
}
