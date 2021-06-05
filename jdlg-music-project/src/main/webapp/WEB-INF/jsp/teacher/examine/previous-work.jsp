<%@ page import="java.util.List" %>
<%@ page import="jdlg.musicproject.entries.common.Courses" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>

<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>

<script>
    $(function () {
        ajaxShowCourses()
    })

    /*总排名*/
    function ajaxShowRanking() {
        var cId = $("#selected").val()
        //console.log(cId)
        $.ajax({
            url: "totalRanking",
            data: {
                cId: cId
            },
            dataType: "json",
            type: "post",
            success: function (rep) {
                $('#overallRanking').empty()
                //console.log(rep)
                if (rep.length != 0) {
                    $.each(rep, function (i, res) {
                        $('#overallRanking').append("<li>\n" +
                            "                        <span class='handle'>\n" +
                            "                        <i class='fa fa-ellipsis-v'></i>\n" +
                            "                        </span>\n" +
                            "                        <span class='btn'>学号：" + res.sId + "</span>\n" +
                            "                        <span class='btn'>姓名：" + res.sName + "</span>\n" +
                            "                        <span class='btn'>平均成绩：" + res.grade + "</span>\n" +
                            "                        </li>")
                    })
                } else {
                    $('#overallRanking').append("<li>\n" +
                        "                        <span class='btn'>暂时未发布作业</span>\n" +
                        "                        </li>")
                }
            }
        })
    }

    /*展示当前教师课程*/
    function ajaxShowCourses() {
        $.ajax({
            url: "addWork/showCourses",
            type: "post",
            success: function (rep) {
                courses = rep
                $.each(rep, function (i, res) {
                    //alert(res.courseName)
                    $("#selected").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                })
                showPreviousWork()
                ajaxShowRanking()
            }
        })
    }

    /*点击课程响应往期作业*/
    function showPreviousWork() {
        var cId = $("#selected").val()
        //var cName = $("#selected").find("option:selected").text();
        $.ajax({
            url: "previousWork/showPreviousWork",
            data: {
                cId: cId
            },
            type: "post",
            dataType: "json",
            success: function (rep) {
                $("#PreWorks").empty()
                $("#workContext").empty()
                if (rep.length != 0 ) {
                    $.each(rep, function (i, res) {
                        $("#PreWorks").append("<li >\n" +
                            "                        <span class='text'><button class='btn-success' id='shWork" + i + "'>第次" + res.times + "作业</button></span>\n" +
                            "                        <span class='text'>描述：" + res.explainContext + "</span>\n" +
                            "                        <span class='text'>总分：" + res.totalPoints + "</span>\n" +
                            "                        <div class='tools'>\n" +
                            "                            <button class='btn-link' data-toggle='modal' data-target='#myModal' id='show" + i + "'>完成情况</button>\n" +
                            // "                            <button class='btn-warning' id='alter" + i + "'>修改</button>\n" +
                            "                            <button class='btn-danger' id='dlt" + i + "'>删除</button>\n" +
                            "                        </div>\n" +
                            "                    </li>")
                        $("#shWork" + i).on('click', function () {
                            ajaxShWorks(res.courseId, res.times, 1)
                        })
                        $("#show" + i).on('click', function () {
                            ajaxShowCompletion(res.courseId, res.times)
                        })
                        $("#dlt" + i).on('click', function () {
                            ajaxDeleteExplain(res.courseId, res.times)
                        })
                    })
                }else {
                    $('#PreWorks').append("<li >\n" +
                        "                        <span class='text'>暂无往期</span>\n" +
                        "                  </li>")
                }
            }
        })
        ajaxShowRanking()
    }

    /*删除作业*/
    function ajaxDeleteExplain(courseId, times) {
        $.ajax({
            url: "previousWork/deleteExplain",
            data: {
                cId: courseId,
                times: times
            },
            dataType: "text",
            type: "post",
            success: function (rep) {
                alert(rep)
                showPreviousWork()
            }
        })
    }

    /*计算当前页数*/
    var countPage = 1;
    /*每页条数*/
    var pageSize = 10;
    /*总页数*/
    var TotalPages = 0;

    /*显示作业题目*/
    function ajaxShWorks(cId, times, pageIndex) {
        $.ajax({
            url: "previousWork/showQuestions",
            data: {
                cId: cId,
                times: times,
                index: pageIndex,
                size: pageSize
            },
            dataType: "json",
            success: function (rep) {
                $("#workContext").empty()
                $.each(rep, function (i, res) {
                    if (res.courseId != null && res.context != null && res.answer != null && res.qId != null) {
                        $("#workContext").append("<li>\n" +
                            "                        <i class='fa fa-hand-o-right bg-blue'></i>\n" +
                            "                        <div class='timeline-item'>\n" +
                            "                            <div class='timeline-body'>\n" +
                            "                                " + res.context + "\n" +
                            "                            </div>\n" +
                            "                            <div class='timeline-footer'>\n" +
                            "                                 答案：" + res.answer + "&nbsp;\n" +
                            "                                <a class='btn btn-danger btn-xs' id='d" + i + "'>删除</a>\n" +
                            "                            </div>\n" +
                            "                        </div>\n" +
                            "                    </li>")
                        $("#d" + i).on('click', function () {
                            //alert("ok"+i)
                            //console.log(res.qId,res.courseId, res.times)
                            deleteQuestion(res.qId, res.courseId, res.times, pageIndex)
                        })
                    } else {
                        TotalPages = res.qId;
                    }
                })
                $('#pages').empty()
                $('#pages').append("         <li><a>共" + TotalPages + "页</a></li>\n" +
                    "                        <li><a id='firstPage'>首页</a></li>\n" +
                    "                        <li><a>第</a></li>\n" +
                    "                        <li><a id='upPage'>&laquo;</a></li>\n" +
                    "                        <li><a id='#'>" + countPage + "</a></li>\n" +
                    "                        <li><a id='downPage'>&raquo;</a></li>\n" +
                    "                        <li><a>页</a></li>\n" +
                    "                        <li><a id='lastPage'>尾页</a></li>")

                $("#firstPage").on('click', function () {
                    ajaxShWorks(cId, times, 1)
                    countPage = 1;
                })
                $("#upPage").on('click', function () {
                    if (countPage != 1) {
                        ajaxShWorks(cId, times, pageIndex - 1)
                        countPage -= 1;
                    }
                })
                $("#downPage").on('click', function () {
                    if (countPage != TotalPages) {
                        ajaxShWorks(cId, times, pageIndex + 1)
                        countPage += 1;
                    }
                })
                $("#lastPage").on('click', function () {
                    ajaxShWorks(cId, times, TotalPages)
                    countPage = TotalPages;
                })
            }
        })
    }

    /*删除问题*/
    function deleteQuestion(qId, courseId, times, index) {
        $.ajax({
            url: "previousWork/deleteQuestion",
            data: {qId: qId},
            type: "post",
            dataType: "text",
            success: function (rep) {
                alert(rep)
                ajaxShWorks(courseId, times, index)
            }
        })
    }

    /*完成情况*/
    var studentCompletion = new Array();

    function ajaxShowCompletion(cId, times) {
        $.ajax({
            url: "previousWork/showCompletion",
            data: {
                cId: cId,
                times: times
            },
            type: "post",
            success: function (rep) {
                $('#showCompletion').empty()
                $('#ranking').empty()
                $.each(rep, function (i, res) {
                    //console.log(res)
                    if (res.grade !== null) {
                        $('#showCompletion').append("<li>\n" +
                            "                            <span class='handle'><i class='icon ion-checkmark'></i></span>\n" +
                            "                            <span class='text'>学号：" + res.sId + "</span>\n" +
                            "                            <span class='text'>姓名：" + res.sName + "</span>\n" +
                            "                            <span class='text' style='color: #00a65a'>成绩：" + res.grade + "</span>\n" +
                            "                        </li>")
                        studentCompletion.push(res)
                    } else {
                        $('#showCompletion').append("<li>\n" +
                            "                            <span class='handle'><i class='icon ion-close'></i></span>\n" +
                            "                            <span class='text'>学号：" + res.sId + "</span>\n" +
                            "                            <span class='text'>姓名：" + res.sName + "</span>\n" +
                            "                            <span class='text' style='color: red'>未完成</span>\n" +
                            "                        </li>")
                    }
                })
                ranking()
            }
        })
    }

    /*排名*/
    function ranking() {
        //console.log(studentCompletion)
        var completion = new Array();
        //var keep = -1;
        if (Array.isArray(studentCompletion)) {
            for (var i = studentCompletion.length - 1; i > 0; i--) {
                for (var j = 0; j < i; j++) {
                    if (studentCompletion[j].grade < studentCompletion[j + 1].grade) {
                        [studentCompletion[j], studentCompletion[j + 1]] = [studentCompletion[j + 1], studentCompletion[j]];
                    }
                }
            }
        }
        $.each(studentCompletion, function (i, res) {
            $('#ranking').append("<li>\n" +
                "                     <span class='text'>" + (i + 1) + "</span>\n" +
                "                     <span class='text'>学号：" + res.sId + "</span>\n" +
                "                     <span class='text'>姓名：" + res.sName + "</span>\n" +
                "                     <span class='text' style='color: #00a65a'>成绩：" + res.grade + "</span>\n" +
                "                 </li>")
        })
        studentCompletion.length = 0
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
                <select class="form-control" style="width:150px;height:35px;font-size:16px;" id="selected"
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
                <!-- See dist/js/pages/dashboard.js to activate the todoList plugin -->
                <ul class="todo-list" id="PreWorks">

                </ul>
            </div>
        </div>
        <br>
        <!-- row -->
        <div class="row">
            <%--<div class="box-tools pull-left ">--%>
            <div class="col-md-offset-1">

                <ul class="pagination pagination-sm inline" id="pages">

                </ul>
            </div>
            <br><br><br>
            <div class="col-md-12">
                <!-- The time line -->

                <ul class="timeline" id="workContext">
                    <!-- timeline time label -->
                    <li class="time-label">
                        <span class="bg-red">点击作业显示内容</span>
                    </li>

                </ul>


            </div>
            <!-- /.col -->
        </div>
        <br/><br/><br/><br/>
        <div class="box box-primary">
            <div class="box-header">
                <i class="icon ion-stats-bars"></i>

                <h3 class="box-title">课程总分排名(总分/次数)</h3>

            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <!-- See dist/js/pages/dashboard.js to activate the todoList plugin -->
                <ul class="todo-list" id="overallRanking">
                    <%--                    <li>--%>
                    <%--                        <span class="handle">--%>
                    <%--                        <i class="fa fa-ellipsis-v"></i>--%>
                    <%--                        </span>--%>
                    <%--                        <span class="btn">张三</span>--%>
                    <%--                    </li>--%>
                </ul>
            </div>
        </div>
        <!-- 模态框（Modal） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <%--完成情况--%>
                    <section class="content">
                        <div class="box box-primary">
                            <div class="box-header">
                                <i class="icon ion-bookmark"></i>

                                <h3 class="box-title">&nbsp;完成情况</h3>

                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <!-- See dist/js/pages/dashboard.js to activate the todoList plugin -->
                                <ul class="todo-list" id="showCompletion">

                                </ul>
                            </div>
                        </div>
                        <%--排名--%>
                        <div class="box box-primary">
                            <div class="box-header">
                                <i class="icon ion-stats-bars"></i>

                                <h3 class="box-title">&nbsp;排名</h3>

                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <!-- See dist/js/pages/dashboard.js to activate the todoList plugin -->
                                <ul class="todo-list" id="ranking">
                                    <li>
                                        <span class="text">张三</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                            </button>
                        </div>
                    </section>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
    </section>
    <!-- /.content -->
</div>