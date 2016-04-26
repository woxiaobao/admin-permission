package com.qiyestore.grails.plugin.admin_web

import org.apache.shiro.authc.AccountException
import org.apache.shiro.authc.IncorrectCredentialsException
import org.apache.shiro.authc.UnknownAccountException
import org.apache.shiro.authc.LockedAccountException

import org.apache.shiro.authc.SimpleAccount
import org.apache.shiro.authz.permission.WildcardPermission


class ShiroDbRealm {
    static authTokenClass = org.apache.shiro.authc.UsernamePasswordToken

    def credentialMatcher
    def shiroPermissionResolver

    def authenticate(authToken) {
        log.info "Attempting to authenticate ${authToken.username} in DB realm..."
        //print "Attempting to authenticate ${authToken.username} in DB realm..."
        def username = authToken.username

        // Null username is invalid
        if (username == null) {
            throw new AccountException("Null usernames are not allowed by this realm.")
        }

        // Get the user with the given username. If the user is not
        // found, then they don't have an account and we throw an
        // exception.
        def user = TUser.findByUsername(username)

        //println "bool="+user.enabled;

        if (!user) {
            throw new UnknownAccountException("No account found for user [${username}]")
        }

        def nowDate = new Date();
        if(user.accountExpiredTime && user.accountExpiredTime < nowDate.getTime()){
            throw new LockedAccountException("账号已经到期！");
        }

        def enabled = user.enabled;
        if(!enabled){

            throw new LockedAccountException ("账号被锁定！");
        }

        log.info "Found user '${user.username}' in DB"

        // Now check the user's password against the hashed value stored
        // in the database.
        def account = new SimpleAccount(username, user.password, "ShiroDbRealm")
        if (!credentialMatcher.doCredentialsMatch(authToken, account)) {
            log.info "Invalid password (DB realm)"
            throw new IncorrectCredentialsException("Invalid password for user '${username}'")
        }
        
        UserSecurity.initUser(user);
        return account
    }

    def hasRole(principal, roleName) {
         return UserSecurity.hasRole(roleName);
    }
    
    
    
    def isPermitted(principal, requiredPermission) {
        
        def permissions = UserSecurity.getAllPermission();
        //println "principal="+principal;
        //println "userPerm="+permissions;
        //println "requiredPermission="+requiredPermission;
        
        //permissions = permissions.split(",");
        
        //return true;
        
        
        def retval = false;
        if(permissions){
            permissions?.each{ permString ->
                def perm = shiroPermissionResolver.resolvePermission(permString)
                if (perm.implies(requiredPermission)) {
                    retval = true;
                    return;
                }
            }
        }
        //println "retval="+retval;
        return retval
        
        
    }
}
