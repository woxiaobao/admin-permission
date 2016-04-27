<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin"/>
		<title>模块管理</title>

		<asset:stylesheet src="admin/ztree/zTreeStyle.css" />
		
	</head>
	<body subtitle="模块列表">
		<div class="row">
	        <div class="col-md-4">
	            <div class="box box-primary">
	            	<input id="treeJson" name="treeJson" value="${treeJson}" type="hidden" />
                    <div class="box-body" >
                    	<div class="ztree" id="treeDemo">
                    	</div>
		            </div><!-- /.box-body -->
		        </div>
	        </div>

	        <div class="col-md-8">
	            <div class="box box-primary">
                    <div class="box-body">
                        <table class="table table-hover table-striped table-applist">
                        	<thead>
                        		<tr>
                                    <th colspan="4">上级模块：<strong style="color: red;"><g:if test="${parentModule}">${parentModule?.name}</g:if><g:else>根模块</g:else></strong>
                                    <a class="btn btn-success pull-right" href="${request.contextPath}/user/moduleEdit?parentId=${parentModule?.id}" title="新建微信息"><i class="fa fa-plus"></i>新建</a>
                                    </th>
                            	</tr>
                        		<tr>
                                    <th>序号</th>
									<th>模块名称</th>
									<th>controller</th>
									<th>action</th>
									<th>图标</th>
									<th>操作</th>
                            	</tr>
                        	</thead>
                            <tbody>
                    			<g:if test="${modules}">
									<g:each in="${modules }" var="m" status="s">
										<tr>
											<td>${s+1 }</td>
											<td>${m?.name }</td>
											<td>${m?.tname}</td>
											<td>${m?.taction}</td>
											<td><i class="fa ${m?.moduleImg}"></i></td>
											<td>
												<shiro:hasPermission permission ="user:moduleEdit">
													<a class="btn btn-default btn-sm" href="${request.contextPath }/user/moduleEdit?id=${m.id}"> <i class="fa fa-edit"></i>编辑 </a>
												</shiro:hasPermission>
												<shiro:hasPermission permission ="user:moduleDel">
													<a class="btn btn-default btn-sm" href="javascript:delModule(${m.id},'${m.name }');"> <i class="fa fa-remove"></i>删除 </a>
												</shiro:hasPermission>
											</td>
										</tr>
									</g:each>
								</g:if>
								<g:else>
									<tr class="odd gradeX">
											<td colspan="4" class="center">没有子模块</td>
									</tr>
								</g:else>
            				</tbody>
            			</table>
                    </div><!-- /.box-body -->
                </div>
	        </div>
	    </div>

	    <asset:javascript src="admin/ztree/jquery.ztree.core-3.5.min.js" />

        <script type="text/javascript">

	        var setting = {};
	        var treeJson = $("#treeJson").val();

			var zNodes =eval('('+treeJson+')'); 
	        $(document).ready(function(){
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			});

			function callback(id){
         		document.location.href = app.contextPath+"/user/moduleList?parentId="+id;
	        }

            function delModule(id,moduleName){
	
			if(confirm("您确定删除模块("+moduleName+")吗？")){
				$.ajax({
				    type: "POST",
					url: app.contextPath + "/user/moduleDel",
					data:{'id':id},
					dataType:"text",					
					success: function(data){
				 		if(data=="success"){
								abox("success","操作成功！",function (){
				 				window.location.reload(); 
				 			});	
				 		}else if(data=="child"){
				 			abox("error","该模块有子模块，请删除子模块后在操作!");
					 	}
				 	}
				 });
			}
		}

		function checkNumber(value){    
			var reg = /^((\d+)|(-\d+))$/;    
			if(!reg.test($.trim(value))){    
				return false;    
			}    
			return true;    
		}

		function checkIsNull(value){
			 if($.trim(value).length<1){
			 	return true;
			 }
			 return false;
		}

    </script>
	</body>
</html>
