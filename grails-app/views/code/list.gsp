<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin"/>
		<title>健身code信息</title>
	</head>
	<body subtitle="code信息内容">
		<div class="row">
            <div class="col-xs-12">
                <div class="box-footer">
                    <form class="form-inline" action="${request.contextPath}/code/list" method="get"  name="searchForm" id="searchForm">

                        <div class="form-group">
                            <label for="appName">code:</label>
                            <input type="text" class="form-control" id="code" name="code" placeholder="10001" value="${params.code}" >
                        </div>

                        <button type="button"   onclick="$('#searchForm').submit()" class="btn btn-default"><i class="fa fa-search"></i> 查询</button>
                        <a class="btn btn-default" href="${request.contextPath}/code/edit" title="新建"><i class="fa fa-plus"></i> 新建</a>
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
                                    <th>序号/id</th>
                                    <th>code</th>
                                    <th>message</th>
                                    <th>描述</th>
                                    <th>操作</th>
                            	</tr>
                        	</thead>
                            <tbody>


                    <g:each in="${data}" var="item" status="i">
                        <tr>
                            <td>
                               ${params.offset+i+1}/${item.id}
                            </td>
                            <td>
                                <h4>${item.code}</h4>
                            </td>
                            <td>
                                ${item.message}
                            </td>
                            <td>
                                ${item.description}
                            </td>
                            <td>
                                <button class="btn btn-default" onclick="location.href='${request.contextPath}/code/edit?id=${item.id}'">
                                    <i class="fa fa-edit"></i> 编辑
                                </button>

                                <button class="btn btn-default deleteBtn" data-id="${item.id}" data-name="${item.title}">
                                    <i class="fa fa-remove"></i> 删除
                                </button>

                            </td>
                        </tr>
                    </g:each>
            </tbody></table>
                    </div><!-- /.box-body -->
                    <div class="box-footer clearfix">
                    	<g:render template="/common/paginate" model="[totalCount: total]" />
                    </div>
                </div>
	        </div>
	    </div>
		<script type="text/javascript">

			$(".deleteBtn").click(function() {
				if(confirm("您确定要删除 "+$(this).attr('data-name')+" 吗?")) {
					$.ajax({
						url: app.contextPath + '/code/delete',
						data: {id: $(this).attr('data-id')},
						success: function(resp) {
							window.location.reload();
							// $(this).remove();
						},
						error: function(err) {
							console.error(err);
							alert('删除失败，请稍后重试');
						}
					})
				}
			});
		</script>
	</body>
</html>
