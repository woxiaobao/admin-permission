<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin"/>
		<title>用户管理</title>
	</head>
	<body subtitle="用户列表">
		<div class="row">
            <div class="col-xs-12">
                <div class="box-footer">
                    <form class="form-inline" action="${request.contextPath}/user/userList" method="get"  name="searchForm" id="searchForm">

                        <div class="form-group">
                            <label for="appName">用户名</label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="用户名" value="${params.username}" >
                        </div>

                        <div class="form-group">
                            <label for="appName">姓名</label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="姓名" value="${params.name}" >
                        </div>

                        <div class="form-group">
                            <label for="appName">角色</label>
                            
                            <select class="form-control" id="roleId" name="roleId">
                               <option value="">--选择角色--</option>
                               <g:each in="${roles}" var="role">
                                    <option value="${role.id}" <g:if test="${params.roleId == role.id}"> selected="selected" </g:if> >${role.authority}</option>
                               </g:each>
                            </select>
                            
                        </div>

                        <button type="button"   onclick="$('#searchForm').submit()" class="btn btn-default"><i class="fa fa-search"></i> 查询</button>
                        <a class="btn btn-default" href="${request.contextPath}/user/userEdit" title="新建微信息"><i class="fa fa-plus"></i>新建</a>
                    </form>
                </div>
                <br/>
            </div>

	        <div class="col-xs-12">
	            <div class="box box-primary">
                    <div class="box-body">
                        <table class="table table-hover table-striped table-applist">
                        	<thead>
                        		<tr>
                                    <th>用户名</th>
                                    <th>姓名</th>
                                    <th>邮箱</th>
                                    <th>手机号</th>
                                    <th>更新时间</th>
                                    <th>开通</th>
                                    <th>操作</th>
                            	</tr>
                        	</thead>
                            <tbody>


                    <g:each in="${result}" var="user" status="i">
                        <tr>
                            <td>
                               ${params.offset+i+1}、${user.username}
                            </td>
                            <td>${user.name }</td>
                            <td>
                                ${user.email}
                            </td>
                            <td>
                                ${user.phone}
                            </td>
                            <td><g:formatDate format="yyyy年MM月dd日 HH:mm:ss" date="${user.lastUpdated}" /></td>
                            <td>
                                <g:if test="${user.enabled}">
                                    <button class="btn btn-success btn-sm">已开通</button>
                                </g:if>
                                <g:else>
                                    <button class="btn btn-warning btn-sm">已锁定</button>
                                </g:else>
                            </td>
                            <td>
                                <button class="btn btn-default btn-sm" onclick="location.href='${request.contextPath}/user/userEdit?id=${user.id}'">
                                    <i class="fa fa-edit"></i>编辑
                                </button>

                                <button class="btn btn-default btn-sm" onclick="delUser(${user.id},'${user.name}')">
                                    <i class="fa fa-remove"></i>删除
                                </button>
                            
                            </td>
                        </tr>
                    </g:each>
            </tbody></table>
                    </div><!-- /.box-body -->
                    <div class="box-footer clearfix">
                    	<g:render template="/common/paginate" model="[totalCount: result?.totalCount]" />
                    </div>
                </div>
	        </div>
	    </div>

        <br/>
        <br/>
        <br/>
        <br/>

        <script type="text/javascript">


            function delUser(id,name){
                if(confirm("您确定要删除["+name+"]吗？")){
                    var data = {
                        "id":id
                    };
                    $.ajax({
                        type: "POST",
                        data:data,
                        url: app.contextPath+"/user/userDel",
                        dataType:"text",
                        success: function(res) {
                            if(res=="success"){
                                alert("删除成功!");
                                document.location.reload();
                            }else{
                                alert("删除失败!");
                            }
                        }
                    });
                }
            }


    </script>
	</body>
</html>
