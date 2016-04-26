<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin"/>
		<title>首页</title>
    <asset:stylesheet src="admin/AdminLTE/morris/morris.css" />
	</head>
	<body>
    <div class="callout callout-info">
      <h4>v1.0即将上线，敬请期待！</h4>
      <p>
          使用企用，一年买车，两年买房不再是梦。
      </p>
    </div>
    
    <div>
      
    <div class="row" >

      <!-- ios -->
      <div class="col-xs-6 col-md-3">
        <!-- small box -->
        <div class="small-box bg-aqua">
          <div class="inner">
            <h3>${userCount?:0}</h3>
            <p>用户</p>
          </div>
          <div class="icon">
            <i class="fa fa-user"></i>
          </div>
          <a href="${request.contextPath}/user/userList" class="small-box-footer">查看全部 <i class="fa fa-arrow-circle-right"></i></a>
        </div>
      </div>

    </div>
    
    <div class="row">
      <div class="col-md-6 col-xs-12">
        <div class="box box-primary">
          <div class="box-header">
            <i class="ion ion-pie-graph"></i>
            <h3 class="box-title">系统通知</h3>
          </div>
          <div class="box-body chat" style="min-height:320px">
            <!-- chat item -->
%{--             <div class="item" ng-repeat="notice in notices">
              <asset:image src="AdminLTE/avatar3.png" alt="user image" class="offline" />
              <p class="message">
                <a href="#" class="name">
                  <small class="text-muted pull-right"><i class="fa fa-clock-o"></i> {{notice.lastUpdated | date:'yyyy-MM-dd'}}</small>
                  {{notice.title}}
                </a>
                {{notice.content}}
              </p>
            </div><!-- /.item --> --}%
          </div><!-- /.box-body -->
        </div>
      </div>
      <div class="col-md-6 col-xs-12">
        <div class="box box-primary">
          <div class="box-header">
            <i class="ion ion-pie-graph"></i>
            <h3 class="box-title">最新推广</h3>
          </div>
          <div class="box-body chart-responsive">
            <div class="chart" id="app-chart" style="height: 300px; position: relative;"></div>
          </div><!-- /.box-body -->
        </div>
      </div>
    </div>
    
    </div>
    <asset:javascript src="admin/AdminLTE/morris/morris.min.js" />
	</body>
</html>
