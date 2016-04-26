<!-- sidebar menu: : style can be found in sidebar.less -->
<ul class="sidebar-menu" id="left_menu">

   <li class="${(controllerName== 'user' && actionName== 'dashboard')?'active':''}">
    <a href="${request.contextPath}/">
      <i class="fa fa-dashboard"></i>
      <span>首　　页</span>
    </a>
  </li>

  
  <shiro:hasAnyRole in="${["ROLE_ADMIN"]}">
  <g:set var="menu_usermgr" value="${controllerName== 'user' && actionName!='dashboard'}" />
  <li class="treeview ${menu_usermgr ?'active':''}"  >
    <a href="#">
      <i class="fa fa-users"></i> <span>权限管理</span><i class="fa fa-angle-left pull-right"></i>
    </a>
    <ul style="display:${menu_usermgr ? 'block' : 'none'};" class="treeview-menu">
      <li class="${controllerName== 'user' && actionName.indexOf('user') > -1 ?'active':''}">
        <a style="margin-left: 10px;" href="${request.contextPath}/user/userList"><i class="fa fa-user-plus"></i> 用户</a>
      </li>

      <li class="${controllerName== 'user' && actionName.indexOf('module') > -1 ?'active':''}">
        <a style="margin-left: 10px;" href="${request.contextPath}/user/moduleList"><i class="fa fa-folder-o"></i> 模块</a>
      </li>
      
      <li class="${controllerName== 'user' && actionName.indexOf('role') > -1 ?'active':''}">
        <a style="margin-left: 10px;" href="${request.contextPath}/user/roleList"><i class="fa fa-male"></i> 角色</a>
      </li>
    </ul>
  </li>
  </shiro:hasAnyRole>
  
  <g:include view="/leftmenu/customMenu.gsp" />

</ul>

<script type="text/javascript">
var menu = $("#left_menu");
$.ajax({
      cache: false,
      type: "GET",
      url:"/admin-permission/common/getLeftMenu",
      data:{},// 你的formid $('#form_count').serialize()
      async: false,
      error: function(request) {
          jacked.log("发生错误！");
      },
      success: function(data) {
          //console.log(data);
          menu.html(data);
      }
  });

</script>