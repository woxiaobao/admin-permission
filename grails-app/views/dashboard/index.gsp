<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin"/>
		<title>首页</title>
	</head>
	<body>
    <div class="callout callout-info">
      <h4>v1.0即将上线，敬请期待！</h4>
      <p>
          使用企用，一年买车，两年买房不再是梦。
      </p>
    </div>
    
    <div class="row" >
      <g:each var="cb" in="${countBoxes}"> 
      <!-- CountBox ${cb.title} -->
      <g:include controller="${cb.controllerName}" action="${cb.actionName}" />
      </g:each>
    </div>
    
    <div class="row">
      <g:each var="lb" in="${listBoxes}"> 
      <!-- ListBox ${lb.title} -->
      <g:include controller="${lb.controllerName}" action="${lb.actionName}" />
      </g:each>
      
    </div>
	</body>
</html>
