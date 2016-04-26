class BootStrap {
	def userSecurityService

    def init = { servletContext ->
    	if (grails.util.Environment.current == grails.util.Environment.DEVELOPMENT) {
            // 仅在开发环境下初始化代码
            userSecurityService.initDB()
        }
    }
    def destroy = {
    }
}
