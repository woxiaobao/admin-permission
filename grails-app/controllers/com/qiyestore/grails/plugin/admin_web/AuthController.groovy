package com.qiyestore.grails.plugin.admin_web
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.LockedAccountException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.web.util.SavedRequest
import org.apache.shiro.web.util.WebUtils

class AuthController {
    def shiroSecurityManager

    def index = { redirect(action: "login", params: params) }

    def login = {
        // println 'user login'
        render(view: "/auth/login",model:[ username: params.username, rememberMe: (params.rememberMe != null), targetUri: params.targetUri ]);
    } 

    def logout = {
        redirect action: 'signOut'
    }
    

    def signIn = {
        
        //println "==============="+params.username;
        
        def authToken = new UsernamePasswordToken(params.username, params.password as String)

        // Support for "remember me"
        if (params.rememberMe) {
            authToken.rememberMe = true
        }
        
        // If a controller redirected to this page, redirect back
        // to it. Otherwise redirect to the root URI.
        def targetUri = "/";
        
        // Handle requests saved by Shiro filters.
        SavedRequest savedRequest = WebUtils.getSavedRequest(request)
        if (savedRequest) {
            targetUri = savedRequest.requestURI - request.contextPath
            if (savedRequest.queryString) targetUri = targetUri + '?' + savedRequest.queryString
        }
        
        boolean loginFail = false;
        try{
            
            //println "params.username="+params.username;
            //println "params.password="+params.password;
            
            // Perform the actual login. An AuthenticationException
            // will be thrown if the username is unrecognised or the
            // password is incorrect.
            SecurityUtils.subject.login(authToken)

            log.info "Redirecting to '${targetUri}'."
            
            //println "targetUri="+targetUri;
            redirect(uri: targetUri)
        }catch(LockedAccountException e){
            flash.message = "${e.message}";
            loginFail = true;
        }
        catch (AuthenticationException ex){

            loginFail = true;
            flash.message = "用户名密码错误！"
        }

        if(loginFail){

            def m = [ username: params.username ]
            if (params.rememberMe) {
                m["rememberMe"] = true
            }

            // Remember the target URI too.
            if (params.targetUri) {
                m["targetUri"] = params.targetUri
            }

            // Now redirect back to the login page.
            redirect(action: "login", params: m)
        }
    }

    def signOut = {
        // Log the user out of the application.
        SecurityUtils.subject?.logout()
        webRequest.getCurrentRequest().session = null
        
        // For now, redirect back to the home page.
        redirect(uri: "/")
    }

    def unauthorized = {
        
        println "no unauthorized";
//        redirect(uri: "/500")
    }
}
