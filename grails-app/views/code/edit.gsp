<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin"/>
    <title>code信息</title>
    <link href="http://cdn.bootcss.com/jquery-tagsinput/1.3.6/jquery.tagsinput.min.css" rel="stylesheet">
    <link href="http://cdn.bootcss.com/rateYo/2.0.1/jquery.rateyo.min.css" rel="stylesheet">
    <asset:stylesheet src="ejianlian/code.css" />
    <!--humane-->
    <asset:stylesheet src="humane/jackedup.css"/>
</head>
<body subtitle="编辑code信息">

    <div class="row">
        <div class="col-md-6">
            <div class="box box-primary">
                <form name="form" id="form" action="${request.contextPath}/code/save" method="POST">
                    <input type="hidden" name="id" id="id" value="${item?.id}" />

                    <div class="box-body">
                        <g:render template="form" module="[item: item]" />
                    </div><!-- /.box-body -->
                </form>
                <div class="box-footer subBtn">
                    <button type="button"  data-loading-text="正在保存..."  onclick="save_item(); return true;" class="btn btn-primary pull-right margin" autocomplete="off"><i class="fa fa-save"></i> 保存</button>
                    <a href="javascript:history.go(-1);" class="btn btn-default margin"><i class="fa fa-reply"></i> 返 回</a>
                </div>

            </div>
        </div>
    </div>
    <script src="http://cdn.bootcss.com/holder/2.9.3/holder.min.js"></script>
    <script src="http://cdn.bootcss.com/jquery-tagsinput/1.3.6/jquery.tagsinput.min.js"></script>
    <script src="http://cdn.bootcss.com/rateYo/2.0.1/jquery.rateyo.min.js"></script>
    <asset:javascript src="ejianlian/code.js" />

    <asset:javascript src="humane.js"/>

    <script type="text/javascript">
            var jacked = humane.create({baseCls: 'humane-jackedup', addnCls: 'humane-jackedup-success'});
            
            //保存
            function save_item(){
                $('.contentImages > img.hide').remove();
                $('#contentImages').val($.map($(".contentImages > img"), function(dom) {
                    return $(dom).attr('src');
                }).join(','));

                $.ajax({
                    cache: false,
                    type: "POST",
                    url:"${request.contextPath}/code/save",
                    data:$('#form').serialize(),// 你的formid
                    async: true,
                    error: function(request) {
                        jacked.log("发生错误！");
                    },
                    success: function(data) {
                        console.log(data);
                        if(data=="success"){
                            jacked.log("保存成功！"); 
                            window.setTimeout("window.location.href='${request.contextPath}/code/index'",1500);
                            //window.setTimeout("history.back()",3000);
                            //window.setTimeout("history.go(-1)",3000);
                            //window.location.reload();
                        }
                        if(data=="error"){
                            jacked.log("发生错误！");
                        }
                    }
                });
            }

            $(function() {
                
            });
        </script>
</body>
</html>
