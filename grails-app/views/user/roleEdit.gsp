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
                            
                            <input type="hidden" id="treeJson" name="treeJson" value="${treeJson}"/>

                            <input type="hidden" name="rs" id="rs" value="" />
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
                                        <h2>${per.controller}</h2>
                                        <div class="form-group">
                                            <g:each in="${per.actions}" var="action" status="j">
                                                <label>
                                                    <input type="checkbox" class="flat-red" checked name="${per.controller}" value="${per.controller}:${action}"/>${action}
                                                </label>
                                            </g:each>
                                            
                                        </div>


                                    </g:each>
                                </div>
                                    
                                </div>
                            </div>
                        </div><!-- /.box-body -->

                        <div class="box-footer subBtn">

                            <button type="button"  data-loading-text="正在保存..."  onclick="$(this).button('loading');subRoleForm();" class="btn btn-primary pull-right margin" autocomplete="off"><i class="fa fa-save"></i> 保存</button>

                            <a href="javascript:history.go(-1);" class="btn btn-default margin"><i class="fa fa-reply"></i> 返 回</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <asset:javascript src="admin/jquery.form.min.js" />
        
        <asset:javascript src="admin/ztree/jquery.ztree.core-3.5.min.js" />
        <asset:javascript src="admin/ztree/jquery.ztree.excheck-3.5.min.js" />
        
        <script type="text/javascript">
            
            $(document).ready(function() {
                loadAjaxForm();
                $("input[type='checkbox']").each(function(){
                    if ("checked" == $(this).attr("checked")) {
                        console.log( $(this).attr('name') );
                          console.log( $(this).attr('value') );
                    }
                });
            });



            function loadAjaxForm(){
                var options = {
                        dataType:"text",
                        type:"post",
                        beforeSubmit : function(arr, $form, options) {
                        var bool = true;
                        
                        //去除错误样式
                        cleanFormErrors();

                        var authority = $("#authority").val();
                        var comment = $("#comment").val();

                        if(authority==""){
                            showFormErrors($("#authority"),"角色名称不能为空！");
                            bool = false;
                        }else if(comment==""){
                            showFormErrors($("#comment"),"备注不能为空！");
                            bool = false;
                        }

                        if(bool){
                            $("div.subBtn").find("button").each(function (){
                                $(this).attr("disabled","disabled");
                                $(this).addClass("disabled");
                            });
                        }else{

                            $("div.subBtn").find("button").each(function (){
                               $(this).button('reset');
                            });
                        }

                        return bool;
                    },
                    success: function(data) {
                       if(data=="success"){

                            abox("success","操作成功！",function (){
                                var refererUrl = "${refererUrl}";
                                var m = refererUrl.replace(/amp;/g,"");
                                location.href=m;
                            });
                       }else{

                            abox("error","操作失败！");
                       }
                    }
                }; 
                $('#roleForm').ajaxForm(options);
            }

        </script>
    </body>
</html>
