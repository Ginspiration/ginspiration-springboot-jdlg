<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>


<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>

<script>
    //var courses;
    $(function () {
        ajaxShowCourses()
    })

    function checkDescribe() {
        var describe = $("input[name='describe']").val()
        var times = $("input[name='nameTimes']").val()
        var totalPoints = $("input[name='totalPoints']").val()
        /*作业内容检查*/
        if (describe == '') {
            AstNotif.notify('请输入作业描述！');
            return false
        } else if (times == '' || isNaN(times)) {
            AstNotif.notify('请输入第几次作业！');
            return false
        } else if (totalPoints == '' || isNaN(totalPoints)) {
            AstNotif.notify('请输入总分！');
            return false
        } else
            return true
    }

    function checkProblem() {
        var textareaSubmit = $("textarea[name='textareaSubmit']").val()
        var answer = $("input[name='answer']").val()
        var optionA = $("input[name='optionA']").val()
        var optionB = $("input[name='optionB']").val()
        var optionC = $("input[name='optionC']").val()
        var optionD = $("input[name='optionD']").val()
        /*作业内容检查*/
        if (checkDescribe()) {
            /*作业题目检查*/
            if (textareaSubmit == '') {
                AstNotif.notify('请输入问题题目！');
                return false
            } else if (optionA == '' || optionB == '' || optionC == '' || optionD == '') {
                AstNotif.notify('请输入完整选项内容！');
                return false
            } else if (answer == '' || answer != 'A' && answer != 'B' && answer != 'C' && answer != 'D' &&
                answer != 'a' && answer != 'b' && answer != 'c' && answer != 'd'
            ) {
                AstNotif.notify('请输正确答案！');
                return false
            } else {
                ajaxSubmitProblem()
            }
        }
    }

    function ajaxShowCourses() {
        $.ajax({
            url: "addWork/showCourses",
            type: "post",
            success: function (rep) {
                //courses = rep
                $.each(rep, function (i, res) {
                    //alert(res.courseName)
                    $("#selected").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                })
                showTimes()
            }
        })

    }

    /*点击课程响应往期作业*/
    function showTimes() {
        var cId = $("#selected").val()
        var cName = $("#selected").find("option:selected").text();
        $.ajax({
            url: "addWork/showTimes",
            data: {
                courseId: cId,
                courseName: cName
            },
            type: "post",
            dataType: "text",
            success: function (rep) {
                $("#idTimes").attr('placeholder', rep)
            }
        })
    }

    function ajaxSubmitProblem() {
        //var = $("input[name='']").val()
        var optionA = $("input[name='optionA']").val()
        var optionB = $("input[name='optionB']").val()
        var optionC = $("input[name='optionC']").val()
        var optionD = $("input[name='optionD']").val()
        var context = $("textarea[name='textareaSubmit']").val()
            + "*&*" + optionA
            + "*&*" + optionB
            + "*&*" + optionC
            + "*&*" + optionD
        var cId = $("#selected").val()
        var answer = $("input[name='answer']").val()
        var times = $("input[name='nameTimes']").val()
        $.ajax({
            url: "addWork/addProblem",
            data: {
                courseId: cId,
                context: context,
                answer: answer,
                times: times
            },
            type: "post",
            dataType: "text",
            success: function (rep) {
                AstNotif.toast(rep);
                $("textarea[name='textareaSubmit']").val('')
                $("input[name='answer']").val('')
                $("input[name='optionA']").val('')
                $("input[name='optionB']").val('')
                $("input[name='optionC']").val('')
                $("input[name='optionD']").val('')
            }
        })
    }

    function ajaxSubmitWork() {
        if (checkDescribe()) {
            var cId = $("#selected").val()
            var times = $("input[name='nameTimes']").val()
            var describe = $("input[name='describe']").val()
            var totalPoints = $("input[name='totalPoints']").val()
            $.ajax({
                url: "doAddWork",
                data: {
                    courseId: cId,
                    times: times,
                    explainContext: describe,
                    totalPoints: totalPoints
                },
                type: "post",
                dataType: "text",
                success: function (rep) {
                    //AstNotif.toast(rep);
                    alert(rep)
                }
            })
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

<%--    <section class="content-header">--%>
        <div align="center">
            <h1>
                <button type="button" onclick="ajaxSubmitWork()" class="btn btn-warning"><h4>发布作业</h4></button>
            </h1>
        </div>
<%--    </section>--%>

    <section class="content">
        <div class="btn-group dropdown">
            <div class="form-group">
                <label style="color: #0d6aad"><h4>选择课程</h4></label>
                <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                <select class="form-control" style="width:300px;height:35px;font-size:16px;" id="selected"
                        onclick="showTimes()">
                </select>
            </div>
        </div>
        <br/><br/>
        <div class="box box-primary">
            <form role="form" id="formCourse">
                <div class="box-body">
                    <div class="form-group">
                        <label><h5>填好内容模块，题目可多次提交</h5>
                            <h3>内容：</h3></label>
                        <div class="form-group">
                            <label>作业说明</label>
                            <input type="text" class="form-control" placeholder="给这一次作业添加描述" name="describe">
                        </div>
                        <div class="form-group">
                            <label>第几次作业</label>
                            <input type="text" class="form-control" placeholder="往期:" name="nameTimes" id="idTimes">
                        </div>
                        <div class="form-group">
                            <label>总分</label>
                            <input type="text" class="form-control" placeholder="总分/题目数量=每道题的分数"
                                   name="totalPoints">
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="box">
            <div class="box-header">
                <h3 class="box-title">题目
                    <small>内容</small>
                </h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body pad">
                <form>
                    <textarea class="textarea" placeholder="这里输入问题描述"
                              style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"
                              name="textareaSubmit"></textarea>
                </form>
            </div>
        </div>
        <div class="form-group">
            <label>选项</label>
            <input type="text" class="form-control" placeholder="A选项内容"
                   name="optionA"><br>
            <input type="text" class="form-control" placeholder="B选项内容"
                   name="optionB"><br>
            <input type="text" class="form-control" placeholder="c选项内容"
                   name="optionC"><br>
            <input type="text" class="form-control" placeholder="D选项内容"
                   name="optionD">
        </div>
        <div class="form-group">
            <label>答案</label>
            <input type="text" class="form-control" placeholder="这里填答案：A、B、C、D"
                   name="answer">
        </div>
        <div class="container mt-5 mb-5">
            <button class="btn btn-success" id="toast" onclick="checkProblem()">提交题目</button>
            可继续添加
        </div>
    </section>
</div>