<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>
<html>
<head>
    <title>添加课程</title>
    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
    <style type="text/css">
        #div1 {
            width: 500px;
            margin: 0 auto;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#post_btn").click(function () {
                // 获取下拉框选中的id 的name 属性值 0 为
                //var index = $("#select_type option:selected").attr("name");
                // 获取课程名称， 课程id
                var name = $("input[name='courseName']").val()
                var id = $("input[name='courseId']").val()

                //处理图片
                var formDate = new FormData();
                if ($('#upFile')[0].files.length>1){
                    alert("至多选择一个文件！")
                    return false
                }
                //遍历所有文件
                for (var i = 0; i < $('#upFile')[0].files.length; i++) {
                    //最后出现'.'处的索引
                    var index = $('#upFile')[0].files[i].name.lastIndexOf(".");
                    //往后截取
                    //console.log($('#fileInput')[0].files[i].name.substring(index + 1));
                    var fileName = $('#upFile')[0].files[i].name.substring(index + 1);
                    //console.log(fileName)
                    if (fileName !== 'jpg' && fileName !== 'jpeg' && fileName !== 'png') {
                        alert("文件类型错误，重新上传.")
                        return;
                    }else
                        formDate.append("file", $('#upFile')[0].files[i])
                }
                //创建正则表达式，/^[0-9][0-9]{6}$/ ：匹配6位数字
                var reg=new RegExp(/^[0-9][0-9]{6}$/);
                //匹配返回true否则false
                ifTrue = reg.test(id);
                 if (id===''||name===''){
                    alert("请输入完整内容")
                    return false
                }else if (!ifTrue){
                     alert("课程编号格式不正确！")
                     return false
                 }
                formDate.append("cId",id)
                formDate.append("cName",name)
                if (name == '' || id == '') {
                    alert("填入完整信息！");
                } else {
                        // 为教师添加课程
                        $.ajax({
                            url: "addTchCourse",
                            data: formDate,
                            cache: false,
                            //async: false,
                            //不处理数据
                            processData: false,
                            //不设置内容类型
                            contentType: false,
                            type: "post",
                            dataType: 'json',
                            success: function (rep) {
                                if (rep == 1) {
                                    alert("添加成功，两秒后跳转")
                                    setTimeout(function () {
                                        //方法体
                                        $(location).attr('href', 'indexCourse')
                                    },2000)
                                } else {
                                    alert("课程已存在！");
                                }
                            }
                        });
                }
            });

            function doAjax() {
                $.ajax({
                    url: "doAddCourse",
                    data: $("#formCourse").serialize(),
                    type: "post",
                    dataType: "text",
                    success: function (rep) {
                        alert(rep)
                    }
                });
            }

        });
    </script>
</head>
<body>
<div class="content-wrapper">

    <section class="content">
        <div id="div1">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h1 class="box-title"><h1>课程添加</h1></h1>
                </div>
                <form role="form" id="formCourse">
                    <div class="box-body">
                        <div class="form-group">
                            <label for="exampleInputEmail1"><h4>说明：</h4><h5>为当前登录的教师添加课程</h5></label>

                            <select id="select_type" class="form-control" style="width: 200px;">
                                <option name="0">为当前教师添加新课程</option>
                            </select>

                            <div class="form-group">
                                <label for="exampleInputEmail1">Course Name</label>
                                <input type="text" class="form-control" id="exampleInputEmail1" placeholder="课程名"
                                       name="courseName">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Course Id</label>
                                <input type="text" class="form-control" id="exampleInputPassword1" placeholder="课程编号"
                                       name="courseId">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">课程封面</label>
                                <input type="file" id="upFile">
                            </div>
                        </div>
                        <div class="box-footer">
                            <button id="post_btn" type="button" class="btn btn-primary">添加</button>
                        </div>
                        <hr/>
                        <a href="indexCourse"><h4>返回课程首页</h4></a>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>
</body>
</html>
