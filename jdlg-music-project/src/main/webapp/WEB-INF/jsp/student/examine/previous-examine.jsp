<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>
<%

%>
<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>


<script>
    $(function () {
        ajaxShowCourses()

    })

    function ajaxShowCourses() {
        $.ajax({
            url: "showCourse",
            type: "post",
            success: function (rep) {
                courses = rep
                $.each(rep, function (i, res) {
                    //alert(res.courseName)
                    $("#selected").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                })
                showPreviousWork()
            }
        })
    }

    /*点击课程响应往期作业*/
    function showPreviousWork() {
        var cId = $("#selected").val()
        //var cName = $("#selected").find("option:selected").text();
        $.ajax({
            url: "showPrevious/showPreviousWork",
            data: {
                cId: cId
            },
            type: "post",
            //async:false,
            dataType: "json",
            success: function (rep) {
                $("#PreWorks").empty()
                $("#workContext").empty()
                //var grade = rep['grade']
                //var explain = rep['explain']
                if (rep.length != 0) {
                    //console.log(grade)
                    //console.log(explain)
                    $.each(rep, function (i, res) {
                        $("#PreWorks").append("<li >\n" +
                            "                        <span class='text'><button class='btn-success' id='shWork" + i + "'>第次" + res.times + "作业</button></span>\n" +
                            "                        <span class='text'>描述：" + res.explainContext + "</span>\n" +
                            "                        <span class='text'>总分：" + res.totalPoints + "</span>\n" +
                            "                        <span class='text' style='color: red'>我的成绩：" + res.grade + "</span>\n" +
                            "                    </li>")
                        $("#shWork" + i).on('click', function () {
                            ajaxShWorks(res.courseId, res.times)
                        })
                        // $("#alter" + i).on('click', function () {
                        //     ajaxShWorks(res.courseId, res.times)
                        // })
                        // $("#delete" + i).on('click', function () {
                        //     ajaxShWorks(res.courseId, res.times)
                        // })
                    })
                }else {
                    $("#PreWorks").append("<li >\n" +
                        "                        <span class='text'>暂无往期</span>\n" +
                        "                    </li>")
                }
            }
        })
    }

    function ajaxShWorks(cId, times) {
        $.ajax({
            url: "showPrevious/showQuestions",
            data: {
                cId: cId,
                times: times
            },
            dataType: "json",
            type: "post",
            success: function (rep) {
                $("#workContext").empty()
                var questions = rep['questions']
                var answers = rep['answers']
                $.each(questions, function (i, res) {
                    $("#workContext").append("<li>\n" +
                        "                        <i class='fa fa-hand-o-right bg-blue'></i>\n" +
                        "                        <div class='timeline-item'>\n" +
                        "                            <div class='timeline-body'>\n" +
                        "                                " + res.context + "\n" +
                        "                            </div>\n" +
                        "                            <div class='timeline-footer' id='ans" + i + "'>\n" +
                        "                                 正确答案：" + res.answer + "&nbsp;\n" +
                        "                                 我的答案：" +
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                    </li>")
                })
                $.each(answers, function (i, res) {
                    $("#ans" + i).append("<a class='btn btn-default btn-xs'>" + res.stuAnswer + "</a>")
                })
            }
        })
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
    <section class="content">
        <div class="btn-group dropdown">
            <div class="form-group">
                <label style="color: #0d6aad"><h4>选择课程</h4></label>
                <select class="form-control" style="width:300px;height:35px;font-size:16px;"  id="selected"
                        onclick="showPreviousWork()">
                </select>
            </div>
        </div>
        <!-- TO DO List -->
        <div class="box box-primary">
            <div class="box-header">
                <i class="ion ion-clipboard"></i>

                <h3 class="box-title">往期作业</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <ul class="todo-list" id="PreWorks">
                </ul>
            </div>
        </div>
        <!-- row -->
        <div class="row">
            <div class="col-md-12">
                <!-- The time line -->
                <ul class="timeline" id="workContext">
                </ul>
            </div>
            <!-- /.col -->
        </div>
    </section>
    <!-- /.content -->
</div>