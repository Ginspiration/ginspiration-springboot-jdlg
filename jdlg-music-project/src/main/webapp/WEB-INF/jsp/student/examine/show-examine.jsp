<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>

<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>

<script>
    $(function () {
        ajaxShowCourses()
    })

    /*展示当前学生课程*/
    function ajaxShowCourses() {
        $.ajax({
            url: "showCourse",
            type: "post",
            dataType: "json",
            success: function (rep) {
                $.each(rep, function (i, res) {
                    $("#selected").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                })
                showWork()
            }
        })
    }

    /*显示作业*/
    function showWork() {
        var cId = $("#selected").val()
        $.ajax({
            url: "doShowExamine",
            data: {
                cId: cId
            },
            type: "post",
            dataType: "json",
            success: function (rep) {
                //console.log(rep.length)
                $("#PreWorks").empty()
                if (rep.length != 0) {
                    $.each(rep, function (i, res) {
                        $("#PreWorks").append("<li >\n" +
                            "                        <span class='text'><h4><a href='doExamine?cId=" + res.courseId + "&times=" + res.times + "' " +
                            "                               class='btn-danger'>第次" + res.times + "作业</a></h4></span>\n" +
                            "                        <span class='text'>描述：" + res.explainContext + "</span>\n" +
                            "                        <span class='text'>总分：" + res.totalPoints + "</span>\n" +
                            "                    </li>")
                    })
                } else {
                    $("#PreWorks").append("<span class='text'>这门课程暂时无作业,请查看其他课程</span>")
                }
            }
        })
    }
</script>
<div class="content-wrapper">
    <!-- 内容头部 -->
    <section class="content-header">
        <h1>
            ${sessionScope.sName}
            <small>(学生)</small>
        </h1>
    </section>
    <section class="content">
        <div class="btn-group dropdown">
            <div class="form-group">
                <label style="color: #0d6aad"><h4>选择课程</h4></label>
                <select class="form-control" style="width:300px;height:35px;font-size:16px;"  id="selected"
                        onclick="showWork()">
                </select>
            </div>
        </div>
        <!-- TO DO List -->
        <div class="box box-primary">
            <div class="box-header">
                <i class="ion ion-clipboard"></i>

                <h3 class="box-title">新作业</h3>

                <div class="box-tools pull-right">
                    <ul class="pagination pagination-sm inline">
                        <li><a href="#">&laquo;</a></li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">&raquo;</a></li>
                    </ul>
                </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <!-- See dist/js/pages/dashboard.js to activate the todoList plugin -->
                <ul class="todo-list" id="PreWorks">
                    <li>
                        <span class="text"><a class="btn-link" id="shWork" href="doExamine">第次作业</a></span>
                        <span class="text">描述：</span>
                        <span class="text">总分：</span>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <!-- /.content -->
</div>