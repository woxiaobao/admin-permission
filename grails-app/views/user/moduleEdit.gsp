<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="admin"/>
        <title>模块管理</title>
    </head>
    <body subtitle="编辑信息">
        
        <div class="row">
            <div class="col-md-8">

                <div class="box box-primary">
                    <!-- form start -->
                    <form name="moduleForm" id="moduleForm" action="${request.contextPath}/user/moduleSave" method="POST">
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
                                    <input type="hidden" name="mid" id="mid" value="">
                                    <input type="hidden" name="perName" id="per_name" value="">
                                    <input type="hidden" name="perValue" id="per_value" value="">
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

                            <div class="form-group" id="perlist">
                                <label for="moduleImg">具有权限</label>
                                <button type="button" class="btn" style="" onclick="addPer()">增加</button>
                                <g:if test="${permissions}">
                                    <g:each in="${permissions }" var="m" status="i">
                                        <div class="form-group ${i == 0?'modulePer':''}">
                                            <div class="input-group">
                                                <span class="input-group-addon">名称:</span>
                                                <input name="" type="hidden" value="${m.id}" class="per_id">
                                                <input name="" type="text" value="${m.perName}" class="form-control per_name" placeholder="列表">
                                                <span class="input-group-addon">权限:</span>
                                                <input name="" type="text" value="${m.perValue}" class="form-control per_value" placeholder="user:moduleList">
                                                <!-- <div class="input-group-addon" ><i class="fa fa-trash-o" onclick="delPer()"></i></div> -->
                                            </div>
                                        </div>
                                    </g:each>
                                </g:if>
                                <g:else>
                                    <div class="form-group modulePer">
                                            <div class="input-group">
                                                <span class="input-group-addon">名称:</span>
                                                <input name="" type="text" value="" class="form-control per_name" placeholder="列表">
                                                <span class="input-group-addon">权限:</span>
                                                <input name="" type="text" value="" class="form-control per_value" placeholder="user:moduleList">
                                                <!-- <div class="input-group-addon" ><i class="fa fa-trash-o" onclick="delPer()"></i></div> -->
                                            </div>
                                        </div>
                                </g:else>
                                

                            </div>


                        </div><!-- /.box-body -->
                    </form>
                    <!-- $(this).button('loading'); -->
                    <div class="box-footer subBtn">
                         <button type="button"  data-loading-text="正在保存..."  onclick="save_module();" class="btn btn-primary pull-right margin" autocomplete="off"><i class="fa fa-save"></i> 保存</button>

                        <a href="javascript:history.go(-1);" class="btn btn-default margin"><i class="fa fa-reply"></i> 返 回</a>
                    </div>
                    
                </div>
            </div>
        </div>
       
        
        <asset:javascript src="admin/jquery.form.min.js" />
        
        
        <script type="text/javascript">

            
            $(document).ready(function() {
                loadAjaxForm();
            });

            //添加权限
            //var $per = null;//用于增加权限节点
            function addPer(){
                //console.log($per);
                var $per = $(".modulePer").clone(true);
                $per.removeClass("modulePer");
                $per.find("input").each(function(){
                    $(this).val("");
                })
                var $perlist = $("#perlist");
                $perlist.append($per);
            }

            //删除权限
            function delPer(){
                var orig = event.target;
                var $orig = $(orig);
                console.log(orig);
                $orig.parent().parent().remove();
            }

            //保存module
            function save_module(){
                var per_name = new Array();
                var per_value = new Array();
                var per_id = new Array();
                $($(".per_name")).each(function(){
                    if($(this).val()) per_name.push( $(this).val() );
                    per_id.push( $(this).prev().val() );
                    if($(this).next().next().val()) per_value.push( $(this).next().next().val() );
                });
                if(per_name.length != per_value.length){
                    alertify.error("填写的信息不全面！");
                    return;
                }
                console.log(per_name.join("||"));
                console.log(per_value.join("||"));
                console.log(per_id.join(","));
                $("#per_name").val(per_name.join("||"));
                $("#per_value").val(per_value.join("||"));
                $("#mid").val(per_id.join(","));
                 $.ajax({
                      cache: false,
                      type: "POST",
                      url:app.contextPath+"/user/moduleSave",
                      data:$('#moduleForm').serialize(),// 你的formid $('#form_count').serialize()
                      async: false,
                      error: function(request) {
                          jacked.log("发生错误！");
                      },
                      success: function(data) {
                          if(data == "success"){
                            jacked.log("保存成功！");
                            var refererUrl = "${refererUrl}";
                            var m = refererUrl.replace(/amp;/g,"");
                            console.log(m);
                            //location.href=m;
                            window.setTimeout("window.location.href='"+m+"'",1500);
                            //window.setTimeout("history.go(-1)",1500);
                          }
                          //menu.html(data);
                      }
                  });


            }
            
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
