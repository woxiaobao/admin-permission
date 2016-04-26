<!-- User Account: style can be found in dropdown.less -->
<g:set var="currentUser" value="${com.qiyestore.grails.plugin.admin_web.UserSecurity.currentUser}" />
<li class="dropdown user user-menu">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
        <i class="glyphicon glyphicon-user"></i>
        <span>${currentUser?.nickname} <i class="caret"></i></span>
    </a>
    <ul class="dropdown-menu">
        <!-- User image  F905v2S5YI-->
        <li class="user-header bg-light-blue">
            
            <img src="${currentUser?.icon ?: assetPath(src: 'admin/AdminLTE/avatar3.png')}" class="img-circle" alt="User Image" />
            
            <p>
                ${currentUser?.nickname}
                <small>创建于： <g:formatDate format="yyyy年MM月dd日" date="${currentUser?.dateCreated}" /></small>
            </p>
        </li>
        <!-- Menu Body 
        <li class="user-body">
            <div class="col-xs-4 text-center">
                <a href="#">Followers</a>
            </div>
            <div class="col-xs-4 text-center">
                <a href="#">Sales</a>
            </div>
            <div class="col-xs-4 text-center">
                <a href="#">Friends</a>
            </div>
        </li>
        -->
        <!-- Menu Footer-->
        <li class="user-footer">
            <div class="pull-left">
                <a href="${request.contextPath}/user/userEdit?id=${currentUser?.id}&type=1" class="btn btn-default btn-flat">个人信息</a>
            </div>
            <div class="pull-right">
                <a href="${request.contextPath}/auth/logout" class="btn btn-default btn-flat">注销</a>
            </div>
        </li>
    </ul>
</li>