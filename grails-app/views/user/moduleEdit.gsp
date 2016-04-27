<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="admin"/>
        <title>模块管理</title>
    </head>
    <body subtitle="编辑信息">
        
        <div class="row">
            <div class="col-md-6">

                <div class="box box-primary">
                    <!-- form start -->
                    <form name="userForm" id="userForm" action="${request.contextPath}/user/moduleSave" method="POST">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="username">父模块名称</label>
                                <div>
                                    <g:if test="${parentModule }">
                                        ${parentModule.name}
                                   </g:if>
                                   <g:else>
                                        根模块
                                   </g:else>
                                    <input type="hidden" name="id" value="${module?.id }">
                                    <input type="hidden" name="parentId" value="${parentModule?.id }">
                                </div>
                            </div>


                            <div class="form-group">
                                <label for="username">模块名称</label>
                                <input type="text" value="${module?.name}" name="name" class="form-control" id="name">
                            </div>

                            <div class="form-group">
                                <label for="tname">controller</label>
                                <input type="text" value="${module?.tname}" name="tname" class="form-control" id="tname">
                            </div>

                            <div class="form-group">
                                <label for="taction">action</label>
                                <input type="text" value="${module?.taction}" name="taction" class="form-control" id="taction">
                            </div>

                            <div class="form-group">
                                <label for="moduleImg">图标</label>
                                <input type="text" value="${module?.moduleImg}" name="moduleImg" class="form-control" id="moduleImg">
                            </div>

                        </div><!-- /.box-body -->
                        
                        <div class="box-footer subBtn">
                             <button type="button"  data-loading-text="正在保存..."  onclick="$(this).button('loading');$('#userForm').submit();" class="btn btn-primary pull-right margin" autocomplete="off"><i class="fa fa-save"></i> 保存</button>

                            <a href="javascript:history.go(-1);" class="btn btn-default margin"><i class="fa fa-reply"></i> 返 回</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
       
        
        <asset:javascript src="admin/jquery.form.min.js" />
        
        
        <script type="text/javascript">

            
            $(document).ready(function() {
                loadAjaxForm();
            });


            
            function loadAjaxForm(){
                var options = {
                        dataType:"text",
                        type:"post",
                        beforeSubmit : function(arr, $form, options) {
                        
                        //去除错误样式
                        cleanFormErrors();
                    
                        var bool = true;
                        
                        var name = $("#name").val();

                        if(name==""){
                            showFormErrors($("#name"),"模块名称不能为空！");
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
                $('#userForm').ajaxForm(options);
            }

            

        </script>
    </body>
</html>
