<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin"/>
		<title>角色管理</title>
        <asset:stylesheet src="admin/ztree/zTreeStyle" />
	</head>
	<body subtitle="角色列表">
		<div class="row">
            <div class="col-xs-12">
                <div class="box-footer">
                    <form class="form-inline" action="${request.contextPath}/user/roleList" method="get"  name="searchForm" id="searchForm">

                        <div class="form-group">
                            <label for="appName">角色名称</label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="角色名称" value="${params.name}" >
                        </div>

                        <button type="button"   onclick="$('#searchForm').submit()" class="btn btn-default"><i class="fa fa-search"></i> 查询</button>
                        <a class="btn btn-default" href="${request.contextPath}/user/roleEdit" title="新建微信息"><i class="fa fa-plus"></i>新建</a>
                    </form>
                </div>
                <br/>
            </div>
            
            


	        <div class="col-md-12">
	            <div class="box box-primary">
                    <div class="box-body">
                        <table class="table table-hover table-striped table-applist">
                        	<thead>
                        		<tr>
                                    <th>序号</th>
                                    <th>角色名称</th>
                                    <th>说明</th>
                                    <th>状态</th>
                                    <th>操作</th>
                            	</tr>
                        	</thead>
                            <tbody>


                    <g:each in="${result}" var="role" status="i">
                        <tr>
                            <td>
                                ${i+1}
                            </td>
                            <td>
                                ${role.authority}
                            </td>
                            <td>
                                ${role.comment}
                            </td>
                            <td>
                                <g:if test="${role.enabled}">
                                    <button class="btn btn-success btn-sm">启用</button>
                                </g:if>
                                <g:else>
                                    <button class="btn btn-warning btn-sm">停用</button>
                                </g:else>
                            </td>
                             
                            <td>
                                <button class="btn btn-default btn-sm" onclick="location.href='${request.contextPath}/user/roleEdit?id=${role.id}'">
                                    <i class="fa fa-edit"></i>编辑
                                </button>
                            </td>
                        </tr>
                    </g:each>
            </tbody></table>
                    </div><!-- /.box-body -->
                    <div class="box-footer clearfix">
                    	<g:render template="/common/paginate" model="[totalCount:total]" />
                    </div>
                </div>
	        </div>

	    </div>

        <br/>
        <br/>
        <br/>
        <br/>
        <asset:javascript src="admin/jquery.form.min.js" />
        
        <asset:javascript src="admin/ztree/jquery.ztree.core-3.5.min.js" />
        <asset:javascript src="admin/ztree/jquery.ztree.excheck-3.5.min.js" />

        <script type="text/javascript">
            $(function(){
               
            });

        </script>
    </body>

</html>
