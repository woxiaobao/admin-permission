<div class="col-md-6 col-xs-12">
  <div class="box box-primary">
    <div class="box-header">
      <i class="ion ion-help-buoy"></i>
      <h3 class="box-title">用户操作</h3>
    </div>
    <div class="box-body chat" style="max-height:300px">
      <g:each var="userLog" in="${userLogs}">
      <!-- chat item -->
      <div class="item">
        <img src="${userLog.user?.icon ?: assetPath(src: 'admin/AdminLTE/avatar3.png')}" class="" alt="User Image" />
        <p class="message">
          <a href="#" class="name">
            <small class="text-muted pull-right"><i class="fa fa-clock-o"></i> <g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${userLog.actionTime}"/></small>
            ${userLog.user?.nickname}
          </a>
          <g:message code="admin-web.dashboard.userLog.actionType.title.${userLog.actionType}" default="进行了一次操作" />
        </p>
      </div><!-- /.item -->
      </g:each>
    </div><!-- /.box-body -->
  </div>
</div>