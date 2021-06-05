<%@include file="../../pages/web-url.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>

<script>
    <%--检查标题是否为空--%>
    function checkTitleNull(){
        let title = $("#title").val();
        if ( title == "" ){
            $("#titleInfo").css("color", "red");
            $("#titleInfo").html("标题不能为空");

        }
    }

    $(function () {
        //Tab键排版
        $("textarea").on(
            'keydown',
            function (e) {
                if (e.keyCode == 9) {
                    e.preventDefault();
                    var indent = '       ';
                    var start = this.selectionStart;
                    var end = this.selectionEnd;
                    var selected = window.getSelection().toString();
                    selected = indent + selected.replace(/\n/g, '\n' + indent);
                    this.value = this.value.substring(0, start) + selected
                        + this.value.substring(end);
                    this.setSelectionRange(start + indent.length, start
                        + selected.length);
                }
            }
        )

        //给新闻内容赋值
        let context;
        context = "${newContext}"
        context = context.replace(/<br\/>/g,"\n")
        document.getElementById("context").innerHTML = context
    })

    /*通过提交按钮执行提交函数*/
    function dosubmit() {

        //定义变量radio
        let radio
        //确定radio被谁选中，以决定文件上传方式
        if( document.getElementById("optionsRadios1").checked == true)
            radio = 1
        else if( document.getElementById("optionsRadios2").checked == true)
            radio = 2
        else if( document.getElementById("optionsRadios3").checked == true)
            radio = 3
        else{
            alert("需要选择上传图片方式")
            return
        }

        //做修改函数
        //文件的有无决定了请求的不同，所以需先判断
        if( document.getElementById("file").value == '') {
            let thisData = new FormData();
            let marked
            //判断推荐新闻mark是否选中
            if($('#mark').is(':checked')) {
                // 不设置，默认值为marked
                marked = "marked"
            }else{
                //设false
                marked = "false"
            }

            let title = $("#title").val();
            //若标题不为空，则进行提交处理
            if ( title == "" ) {
                alert("标题不能为空");
                return
            }
            else{
                //将其他类型的数据放入formDate
                console.log($("#mark").val())
                console.log($("input[name='title']").val())
                thisData.append("title",$("input[name='title']").val())
                //将context中的换行转为字符以被数据库识别
                let context = $("#context").val()
                context = context.replace(/\n/g,"<br/>")
                thisData.append("context",context)
                thisData.append("marked",marked)
                thisData.append("radio",radio)

                console.log(thisData)
                // 4、ajax提交文件给后端
                $.ajax({
                    url:'upDateNewNoFile',
                    type: 'post',
                    data: thisData,
                    dataType: 'text',
                    cache: false,
                    //async: false,
                    //不处理数据
                    processData: false,
                    //不设置内容类型
                    contentType: false,
                    success: function (data) {
                        if ( data == 1000){
                            confirm({
                                title: '修改成功',
                                content: '',
                                doneText: '确认',
                            }).then(() => {
                                window.location.href = "${pageContext.request.contextPath}/doTeacher/viewNews?nowPage=1&updatePage=0&mark=2"
                            }).catch(() => {
                                window.location.href = "${pageContext.request.contextPath}/doTeacher/viewNews?nowPage=1&updatePage=0&mark=2"
                            })``

                        }else if(data == 1002){
                            alert("标题不存在")
                            title = "";
                        }
                    }
                })
            }
        }
        else{

            let thisData = new FormData();
            let marked

            //判断推荐新闻mark是否选中
            if($('#mark').is(':checked')) {
                // 不设置，默认值为marked
                marked = "marked"
            }else{
                //设false
                marked = "false"
            }

            let title = $("#title").val();
            //若标题不为空，则进行提交处理
            if ( title == "" ) {
                alert("标题不能为空");
            }
            else{
                let thisFiles = $('#file')
                //1、遍历所有文件，查看文件类型
                for (let i = 0; i < thisFiles[0].files.length; i++) {
                    //最后出现'.'处的索引
                    let index = thisFiles[0].files[i].name.lastIndexOf(".");
                    //往后截取
                    let fileName = thisFiles[0].files[i].name.substring(index + 1);
                    //获取文件后缀名
                    console.log(fileName)
                }
                //2、将文件放入formDate()
                for (let i = 0; i < thisFiles[0].files.length; i++) {
                    thisData.append("files",thisFiles[0].files[i])
                }
                //3、将其他类型的数据放入formDate
                console.log($("#mark").val())
                thisData.append("title",$("input[name='title']").val())
                //将context中的换行转为字符以被数据库识别
                let context = $("#context").val()
                context = context.replace(/\n/g,"<br/>")
                thisData.append("context",context)
                thisData.append("marked",marked)
                thisData.append("radio",radio)

                //sleep
                console.log(thisData)
                // 4、ajax提交文件给后端
                $.ajax({
                    url:'upDateNew',
                    type: 'post',
                    data: thisData,
                    dataType: 'text',
                    cache: false,
                    //async: false,
                    //不处理数据
                    processData: false,
                    //不设置内容类型
                    contentType: false,
                    success: function (data) {
                        if ( data == 1000){
                            confirm({
                                title: '添加成功',
                                content: '',
                                doneText: '确认',
                            }).then(() => {
                                window.location.href = "${pageContext.request.contextPath}/doTeacher/viewNews?nowPage=1&updatePage=0&mark=2"
                            }).catch(() => {
                                window.location.href = "${pageContext.request.contextPath}/doTeacher/viewNews?nowPage=1&updatePage=0&mark=2"
                            })``

                        }else if(data == 1001){
                            alert("文件上传失败")
                        }else if(data == 1002){
                            alert("标题重复")
                            title = "";
                        }
                    }
                })
            }
        }

    }

</script>

<div class="content-wrapper">
    <!-- 内容头部 -->
    <section class="content-header">
        <h1>
            ${sessionScope.tName}
            <small>(教师)</small>
        </h1>
    </section>

    <%--    </section>--%>
    <section class="content">
        <div class="box-body">
            <div class="nav-tabs-custom">
                <div class="tab-content">

                    <div class="form-group">
                        <div class="form-group">
                            <form action="" role="form" id="formNews"  method="post" enctype="multipart/form-data">
                                <label>新闻标题</label>
                                <input type="text" class="form-control" value="${newTitle}" name="title" onblur="checkTitleNull()"><span id="titleInfo"></span><br/>
                                <label>新闻内容</label>

                                <%--新闻内容输入框--%>
                                <div class="box">
                                    <div class="box-header">
                                        <!-- tools box -->
                                        <div class="pull-right box-tools">
                                            <button type="button" class="btn btn-default btn-sm" data-widget="collapse" data-toggle="tooltip"
                                                    title="Collapse">
                                                <i class="fa fa-minus"></i></button>
                                            <button type="button" class="btn btn-default btn-sm" data-widget="remove" data-toggle="tooltip"
                                                    title="Remove">
                                                <i class="fa fa-times"></i></button>
                                        </div>
                                        <!-- /. tools -->
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body pad">
                                                <textarea  name="context"  class="textarea"  onblur="a()" id="context"
                                                           style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                                    </div>
                                </div>

                                <label>图片添加</label>
                                <input type="file" onclick="" multiple="multiple" id="file"/>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" style="" id="optionsRadios1" value="option1" >
                                        添加更多图片（若无图片则不添加）
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" style=""  id="optionsRadios2" value="option2">
                                        删除原先图片后添加（若无图片则只删除图片）
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" style=""  id="optionsRadios3" value="option3">
                                        不更改图片
                                    </label>
                                </div>

                                <br/>
                                <br/>

                                <label class="checkbox-inline">
                                    <input type="checkbox" id="mark" value="marked"> 标记为推荐新闻   <%--值有误--%>
                                </label>
                                <br>
                                <br>
                                <div class="container mt-5 mb-5" >
                                    <input type="button" style="left:10px" class="btn btn-success" id="toast" onclick="dosubmit()" value="提交新闻"></input>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>