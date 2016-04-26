<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="admin"/>
        <title>用户管理</title>
        <link href="http://cdn.bootcss.com/bootstrap-tokenfield/0.12.0/css/bootstrap-tokenfield.min.css" rel="stylesheet">
    </head>
    <body subtitle="用户信息">
        
        <div class="row">
            <div class="col-md-6">

                <div class="box box-primary">
                    <!-- form start -->
                    <form name="userForm" id="userForm" action="${request.contextPath}/user/userSave" method="POST">
                        <div class="box-body">
                            
                            <input type="hidden" name="id" id="userId" value="${user?.id}" />

                            <div class="form-group">
                                <label class="control-label">
                                    <div style="overflow:hidden;width: 100px;height: 20px;">
                                    
                                    </div>
                                </label>
                                <div >
                                    <div class="userIcon uploadBtn">
                                        <img alt="图标" data-src="holder.js/120x120/text:应用图标 \n 120x120" src="${user?.icon}" width="120" height="120"  />
                                        <a style="cursor: pointer;"><i class="fa fa-cloud-upload"></i> 头像上传</a>
                                        <input type="hidden" name="userIcon" id="userIcon" value="${user.icon}" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="username">用户名</label>
                                <g:if test="${user?.username}">
                                     <input class="form-control" disabled="true" value="${user?.username}" name="un" type="text" placeholder="用户名">
                                </g:if>
                                <g:else>
                                    <input class="form-control" id="username" name="username" type="text" placeholder="用户名">
                                </g:else>
                            </div>


                            <div class="form-group">
                                <label for="password">密码</label>
                                <input class="form-control" id="password" name="pwd" type="password" placeholder="密码">
                                <label class="control-label" for="inputWarning"><i class="fa fa-warning"></i>密码为空时，不修改原密码！</label>
                            </div>


                            <div class="form-group">
                                <label for="email">邮箱</label>
                                <input class="form-control" id="email" name="email"  value="${user.email}" type="text" placeholder="邮箱">
                            </div>

                            <div class="form-group">
                                <label for="name">姓名</label>
                                <input class="form-control" id="name" name="name"  value="${user.name}" type="text" placeholder="姓名">
                            </div>

                            <div class="form-group">
                                <label for="nickname">昵称</label>
                                <input class="form-control" id="nickname" name="nickname" value="${user.nickname}" type="text" placeholder="姓名">
                            </div>

                            <div class="form-group">
                                <label for="nickname">电话</label>
                                <input class="form-control" id="phone" name="phone" value="${user.phone}" type="text" placeholder="电话">
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
        <asset:javascript src="openapi/openapi-upload.js" />
                
        <script src="http://cdn.bootcss.com/bootstrap-tokenfield/0.12.0/bootstrap-tokenfield.min.js"></script>
        <script type="text/javascript">
            


            $('.tokenfield').tokenfield();
            
            $('.url_input').click(function() {
                $('.url_input').toggleClass('hide');
                $('.url_input').toggleClass('');
                
                var $input = $('.url_input').parent().parent().find('input');
                
                if($input.attr('disabled')) $input.removeAttr('disabled');
                else $input.attr('disabled','disabled');
            });


            $(document).ready(function() {
                
                $(".uploadBtn").each(function(){
                    new OpenApiUpload(this, function(dom, fileUrl) {
                        $(dom).find('img').attr('src', fileUrl);
                        $(dom).find('input#userIcon').val(fileUrl);
                    }).init();
                });

                loadAjaxForm();
            });

            function loadAjaxForm(){
                var options = {
                        dataType:"text",
                        type:"post",
                        beforeSubmit : function(arr, $form, options) {

                        cleanFormErrors();
                        
                        var bool = true;
                        
                        var userId = $("#userId").val();
                        var password = $.trim($("#password").val());
                        var email    = $.trim($("#email").val());

                        if(bool && email==""){
                           showFormErrors($("#email"),"邮箱不能为空!!!");
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
