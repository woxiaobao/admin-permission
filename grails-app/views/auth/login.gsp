<!DOCTYPE html>
<html class="lockscreen">
    <head>
        <meta charset="UTF-8">
        <title><g:message code="admin-web.title" default="AdminWeb"/> - 登录</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <link href="http://cdn.bootcss.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <asset:stylesheet src="admin/AdminLTE/AdminLTE.css" />

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>

        <div class="form-box" id="login-box">
            <div class="header bg-light-blue"><b><g:message code="admin-web.title" default="AdminWeb"/></b> v<g:meta name="app.version"/></div>
            <form action="signIn" method="post">
                <div class="body bg-gray">
                
                    <g:if test="${flash.message}">
                      <div class="message">${flash.message}</div>
                    </g:if>

                    <input type="hidden" name="targetUri" value="${targetUri}" />
                    <div class="form-group">
                        <input type="text" value="" name="username" class="form-control" placeholder="用户名"/>
                    </div>
                    <div class="form-group">
                        <input type="password" name="password" value="" class="form-control" placeholder="密码"/>
                    </div>
                    <div class="form-group">
                        <input type="checkbox" name="rememberMe"  value="${rememberMe}" /> 保存登录状态
                    </div>
                </div>
                <div class="footer">
                    <button type="submit" class="btn bg-light-blue btn-block">登录</button>
                </div>
            </form>
        </div>

        <asset:javascript src="jquery" />
        <script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    
    </body>
</html>
