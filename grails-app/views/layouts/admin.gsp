<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><g:layoutTitle default="首页"/></title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <link href="http://cdn.bootcss.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="http://cdn.bootcss.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <!-- Ionicons -->
        <link href="http://cdn.bootcss.com/ionicons/1.5.2/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <asset:stylesheet src="admin/AdminLTE/AdminLTE.css" />

        <!--alertify-->
        <asset:stylesheet src="alertify.css" />
        <!--humane-->
        <asset:stylesheet src="humane/jackedup.css"/>
 		%{-- <link href="${request.contextPath}/css/abox.css" rel="stylesheet" type="text/css" /> --}%
 		            
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <asset:javascript src="jquery" />
        <script type="text/javascript"><g:render template="/common/appjs"></g:render></script>
        
        <g:layoutHead />
    </head>
    <body class="skin-black">
        <!-- header logo: style can be found in header.less -->
        <header class="header">
            <a href="#" class="logo">
                <!-- Add the class icon to your logo image or logo icon to add the margining -->
                <b><g:message code="admin-web.title" default="AdminWeb"/></b><small>v<g:meta name="app.version"/></small>
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-right">
                    <ul class="nav navbar-nav">
                        <g:render template="/layouts/admin_usermenu"/>
                    </ul>
                </div>
            </nav>
        </header>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="${com.qiyestore.grails.plugin.admin_web.UserSecurity.currentUser?.icon ?: assetPath(src: 'admin/AdminLTE/avatar3.png')}" class="img-circle" alt="User Image" />
                        </div>
                        <div class="pull-left info">
                            <p>您好, ${com.qiyestore.grails.plugin.admin_web.UserSecurity.currentUser?.nickname}</p>

                            <a href="#"><i class="fa fa-circle text-success"></i> 在线</a>
                        </div>
                    </div>
                    <g:render template="/layouts/admin_leftmenu"/>
                    
                </section>
                <!-- /.sidebar -->
            </aside>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        ${pageProperty(name:'title')}
                        <g:if test="${pageProperty(name:'body.subtitle')}">
                        <small>${pageProperty(name:'body.subtitle')}</small>
                        </g:if>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="${request.contextPath}/"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">${pageProperty(name:'title')}</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                	<g:layoutBody/>
                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->


        <!-- Bootstrap -->
        <script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- AdminLTE App -->
        <asset:javascript src="admin/admin.js" />
        <asset:javascript src="admin/AdminLTE/app.js" />
        <asset:javascript src="admin/AdminLTE/holder.min.js" />

        <!-- 加载信息提示插件 -->
        <asset:javascript src="alertify.js" />
        <asset:javascript src="humane.js"/>
        
        <plugin:isAvailable name="openapi-client">
        <!-- 加载OpenApiClient -->
        <asset:javascript src="openapi/openapi-client.js" />
        <asset:javascript src="openapi-config.js" />
        <script type="text/javascript">
            // $(document).ready(function() {
            //     OpenApiClient.getAccessToken('${com.qiyestore.grails.plugin.admin_web.UserSecurity.currentUser?.id}');
            // });
        </script>
        </plugin:isAvailable>


        <!-- 加载自定义application.js -->
        <asset:javascript src="application.js" />


    </body>
</html>

