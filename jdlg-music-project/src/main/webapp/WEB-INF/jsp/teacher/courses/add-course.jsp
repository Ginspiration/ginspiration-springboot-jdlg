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
        function checkCourse() {
            var name = $("input[name='courseName']").val()
            var id = $("input[name='courseId']").val()
            if (name == '' || id == '') {
                alert("填入完整信息！")
                return false
            } else
                doAjax()
        }

        function doAjax() {
            $.ajax({
                url: "doAddCourse",
                data: $("#formCourse").serialize(),
                type: "post",
                dataType: "text",
                success: function (rep) {
                    alert(rep)
                }
            })
        }
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
                        </div>
                        <div class="box-footer">
                            <button type="button" class="btn btn-primary" onclick="checkCourse()">添加</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
</div>
</body>
</html>
