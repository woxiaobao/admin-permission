<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="admin"/>
        <title>用户管理</title>
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

                            <div class="form-group">
                                <label for="comment">开通</label>
                                <select class="form-control" name ="enabled">
                                    <option value="true" <g:if test="${user.enabled}"> selected="true" </g:if> >开通</option>
                                    <option value="false" <g:if test="${!user.enabled}"> selected="true" </g:if> >锁定</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="comment">备注</label>
                                <input class="form-control" id="comment" name="comment" type="text" value="${user.comment}" placeholder="备注">
                            </div>

                            <div class="form-group">
                                <label for="comment">用户角色</label>
                                <select class="form-control" id="roleId" name="roleId">
                                   <option value="">--选择角色--</option>
                                   <g:each in="${roles}" var="role">
                                        <option value="${role.id}" <g:if test="${existStr == role.id}"> selected="selected" </g:if> >${role.authority}</option>
                                   </g:each>
                                </select>
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
       
        
        <asset:javascript src="admin/jquery.form.min.js"/>
        
        <script type="text/javascript">




            $(document).ready(function() {
                loadAjaxForm();
            });

            
            //验证用户名
            function checkUsername(username){
                var bool = true;
                if(username!=""){
                    var data = {
                            "username":username
                        }
                    $.ajax({
                        type: "POST",
                        data:data,
                        async:false,
                        url: app.contextPath+"/user/checkUsername",
                        dataType:"text",
                        success: function(res) {
                            if(res=="1"){
                                bool =true;
                            }else{
                                bool = false;
                            }
                        }
                    });
                }else{
                    bool =  false;
                }
                return bool;
            }


            function loadAjaxForm(){
                var options = {
                        dataType:"text",
                        type:"post",
                        beforeSubmit : function(arr, $form, options) {

                        cleanFormErrors();
                        
                        var bool = true;
                        
                        var userId = $("#userId").val();
                        var username = $.trim($("#username").val());
                        var password = $.trim($("#password").val());
                        var email    = $.trim($("#email").val());

                        if(userId ==""){

                            if(username==""){
                                showFormErrors($("#username"),"用户名不能为空!");
                                bool = false;
                            }else if(!checkUsername(username)){

                                showFormErrors($("#username"),"用户名已存在");
                                bool = false;
                            }else if(password==""){
                                
                                showFormErrors($("#password"),"密码不能为空!");
                                bool = false;
                            }

                        }

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
