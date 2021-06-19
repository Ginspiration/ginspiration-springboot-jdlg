<%@ page import="jdlg.musicproject.entries.student.StudentDoWork" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>
<%
    Map<Integer, StudentDoWork> questions = (Map<Integer, StudentDoWork>) session.getAttribute("questionMap");
%>
<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
<style>
    input[type="checkbox"] {
        width: 20px;
        height: 20px;
        display: inline-block;
        text-align: center;
        vertical-align: middle;
        line-height: 18px;
        margin-right: 10px;
        position: relative;
    }
</style>
<script>
    var userAnswer = new Array();
    var answer = new Array();
    var qId = new Array();

    function changChick(target, i) {
        $(".changChick" + i).each(function () {
            $(this).attr('checked', false);
        });
        target.checked = true
    }

    function answers() {
        $("input[name='option']:checkbox").each(function () {
            if ($(this).prop('checked')) {
                //alert($(this).attr('value'))
                userAnswer.push($(this).attr('value'))
            }
            ;
        });
        showGrade()
    }

    function showGrade() {
        var rightCount = 0;
        var answers = new Array();

        for (let i = 0; i < answer.length; i++) {
            //console.log(userAnswer[i] +answer[i])
            if (userAnswer[i] == answer[i]) {
                rightCount++;
            }
        }
        $.each(qId, function (i) {
            var uAnswer = userAnswer[i].substring(0, 1)
            answers.push({questionId: qId[i], studentId:${sessionScope.sId}, stuAnswer: uAnswer})
        })
        //console.log(answers)
        $.ajax({
            url: "storageAnswer",
            data: JSON.stringify(answers),
            type: "post",
            contentType: "application/json",
            success:function () {
            }
        })
        $(location).attr('href', '<%=basePath%>doStudent/showGrade?rCount=' + rightCount);
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
        <%
            for (Map.Entry<Integer, StudentDoWork> node : questions.entrySet()) {
                StudentDoWork q = node.getValue();
        %>
        <script>
            answer.push('<%=q.getAnswer()+node.getKey()%>')
            qId.push('<%=q.getqId()%>')
        </script>
        <div class="row">
            <div class="col-md-12">
                <!-- The time line -->
                <ul class="timeline" id="workContext">
                    <!-- timeline time label -->
                    <li class="time-label">
                          <span class="bg-black">
                              第<%=node.getKey() + 1%>题
                          </span>
                    </li>
                    <!-- timeline item -->
                    <li>
                        <i class="fa fa-hand-o-right bg-black"></i>
                        <div class="timeline-item">
                            <div class="timeline-body">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=q.getContext()%>
                            </div>
                            <div class="box content">
                                <br>
                                A、
                                <input type="checkbox" name="option" class="changChick<%=node.getKey()%>"
                                       onclick="changChick(this,<%=node.getKey()%>)" value="A<%=node.getKey()%>"/>
                                <%=q.getOptionA()%>
                                <br><br>
                                B、
                                <input type="checkbox" name="option" class="changChick<%=node.getKey()%>"
                                       onclick="changChick(this,<%=node.getKey()%>)" value="B<%=node.getKey()%>"/>
                                <%=q.getOptionB()%>
                                <br><br>
                                C、
                                <input type="checkbox" name="option" class="changChick<%=node.getKey()%>"
                                       onclick="changChick(this,<%=node.getKey()%>)" value="C<%=node.getKey()%>"/>
                                <%=q.getOptionC()%>
                                <br><br>
                                D、
                                <input type="checkbox" name="option" class="changChick<%=node.getKey()%>"
                                       onclick="changChick(this,<%=node.getKey()%>)" value="D<%=node.getKey()%>"/>
                                <%=q.getOptionD()%>
                                <br><br>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- /.col -->
        </div>

        <%
            }
        %>
        <div align="center">
            <h2>
                <button class="bg-light-blue-active" onclick="answers()">提交</button>
            </h2>
        </div>
    </section>
</div>