<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="admin"/>
        <title>角色管理</title>
        <asset:stylesheet src="admin/ztree/zTreeStyle" />
    </head>
    <body subtitle="角色信息">
        
        <div class="row">
            <div class="col-md-6">
                <div class="box box-primary">
                    <form name="roleForm" id="roleForm" action="${request.contextPath}/user/roleSave" method="POST">
                        <div class="box-body">
                            <input type="hidden" name="id" id="id" value="${role?.id}" />
                            
                            <input type="hidden" name="permission" id="permission" value="" />
                            <div class="form-group">
                                <label for="authority">角色名称</label>
                                
                                <input class="form-control" id="authority" value="${role?.authority}" name="authority" type="text" placeholder="角色名称">
                            </div>
                            
                            <div class="form-group">
                                <label for="comment">备注</label>
                                
                                <input class="form-control" id="comment" value="${role?.comment}" name="comment" type="text" placeholder="备注">
                            </div>


                            <div class="form-group">
                                <label for="enabled">状态</label>
                                <select class="form-control" name ="enabled">
                                    <option value="true" <g:if test="${role.enabled}"> selected="true" </g:if> >开通</option>
                                    <option value="false" <g:if test="${!role.enabled}"> selected="true" </g:if> >停用</option>
                                </select>
                            </div>


                            <div class="form-group">
                                <label for="enabled">权限</label>
                                <!-- <div id="treeDemo" class="ztree"> checked-->
                                <div class="form-group">
                                    <g:each in="${permission}" var="per" status="i">
                                        <g:if test="${per.actions}">
                                          <h4>${per.name}</h4>
                                        </g:if>
                                        <g:each in="${per.actions}" var="action" status="j">
                                            <input type="checkbox"  value="${action.id}"/>${action.name}
                                        </g:each>
                                            
                                    </g:each>
                                </div>
                                    
                                </div>
                            </div>
                        </div><!-- /.box-body -->
                    </form>
                    <div class="box-footer subBtn">

                            <button type="button"  data-loading-text="正在保存..."  onclick="$(this).button('loading');subRoleForm();" class="btn btn-primary pull-right margin" autocomplete="off"><i class="fa fa-save"></i> 保存</button>

                            <a href="javascript:history.go(-1);" class="btn btn-default margin"><i class="fa fa-reply"></i> 返 回</a>
                        </div>
                </div>
            </div>
        </div>
        
        <asset:javascript src="admin/jquery.form.min.js" />
        
        <asset:javascript src="admin/ztree/jquery.ztree.core-3.5.min.js" />
        <asset:javascript src="admin/ztree/jquery.ztree.excheck-3.5.min.js" />
        
        <script type="text/javascript">
            
            $(document).ready(function() {

                //获取role的permission
                $.ajax({
                      cache: false,
                      type: "GET",
                      url:app.contextPath+"/user/getPerByRole/"+$("#id").val(),
                      data:{},// 你的formid $('#form_count').serialize()
                      async: false,
                      error: function(request) {
                          jacked.log("发生错误！");
                      },
                      success: function(data) {
                          if(data == "new"){
                            //jacked.log("发生错误！");
                            return;
                          }
                          for(var d in data){
                            $("input[value='"+data[d]+"']").attr("checked",true);
                          }
                      }
                  });
            });

            function subRoleForm(){
                var per = new Array();
                $($("input:checked")).each(function(){
                    per.push( $(this).attr('value') );
                });
                console.log(per.join(","));
                $("#permission").val(per.join(","));
                 $.ajax({
                      cache: false,
                      type: "POST",
                      url:app.contextPath+"/user/roleSave",
                      data:$('#roleForm').serialize(),// 你的formid $('#form_count').serialize()
                      async: false,
                      error: function(request) {
                          jacked.log("发生错误！");
                      },
                      success: function(data) {
                          if(data == "success"){
                            jacked.log("保存成功！");
                            window.setTimeout("history.go(-1)",1500);
                          }
                          //menu.html(data);
                      }
                  });
            }

            

        </script>
    </body>
</html>
