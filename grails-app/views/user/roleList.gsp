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
            
            <!--modal 设置权限弹出框 -->
            <div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"><i class="fa fa-user"></i> 权限信息</h4>
                        </div>
                        <form id="form_c" method="post">
                            <input name="time" id="addtime" type="hidden" class="">
                            <div class="modal-body">
                                <div class="ztree" id="moduleTree">
                                </div>
                            </div>
                            </form>
                            <div class="modal-footer clearfix">
                                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> 取消</button>
                                <button onclick="save_role()" id="save_role" class="btn btn-primary pull-left"><i class="fa fa-save"></i> 保存</button>
                            </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->


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
                                    <th>权限</th>
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
                                <button class="btn btn-default btn-sm" onclick="add_c(${role.id})">
                                    <i class="fa fa-search"></i>查看
                                </button>
                                <button class="btn btn-default btn-sm" onclick="add_c(${role.id})">
                                    <i class="fa fa-plus"></i>新增
                                </button>
                                <button class="btn btn-default btn-sm" onclick="add_c(${role.id})">
                                    <i class="fa fa-edit"></i>编辑
                                </button>
                                <button class="btn btn-default btn-sm" onclick="add_c(${role.id})">
                                    <i class="fa fa-times"></i>删除
                                </button>
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
            function save_role(){
                jacked.log("功能还在开发中！"); 
            }

            //权限弹出框
            function add_c(id){
                //初始化树
                var setting = {
                    check: {
                        enable: true
                    },
                    data: {
                        simpleData: {
                            enable: true
                        }
                    }
                };

                var treeJson;
                $.ajax({
                    cache: false,
                    type: "GET",
                    url:"${request.contextPath}/user/moduleTreeJson?id="+id,
                    data:{},// 你的formid
                    async: true,
                    dataType: "json",
                    error: function(request) {
                        //jacked.log("发生错误！");
                        alertify.error("error");
                    },
                    success: function(data) {
                        //console.log(data);
                        treeJson = data;
                        //var zNodes = eval("("+treeJson+")");
                        $.fn.zTree.init($("#moduleTree"), setting, treeJson);
                        //modal show
                        $('#compose-modal').modal('show');
                    }
                });

                alertify.success("success");
                //alertify.error("error");
            }

        </script>
    </body>

</html>
