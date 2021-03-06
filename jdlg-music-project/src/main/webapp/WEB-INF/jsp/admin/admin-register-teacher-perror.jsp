<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../pages/web-url.jsp" %>
<html>

<head>
    <%@include file="../pages/link.jsp" %>
</head>

<body class="hold-transition register-page">
<div class="register-box">
    <div class="register-logo">
        <a><b>教师注册权限</b></a>
    </div>
    <div class="register-box-body">
        <p class="login-box-msg">邀请码错误，请重试</p>
        <form action="regTeacherPermit" method="post" id="form1">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="邀请码" name="adminName">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <%--            <div class="form-group has-feedback">--%>
            <%--                <input type="password" class="form-control" placeholder="输入管理员密码" name="adminPassword">--%>
            <%--                <span class="glyphicon glyphicon-lock form-control-feedback"></span>--%>
            <%--            </div>--%>
            <div class="row">
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat" id="sub">确认</button>
                </div>
                <!-- /.col -->
            </div>
        </form>

        <a href="<%=basePath%>loginTeacher/Teacher" class="text-center">我有账号，现在就去登录</a>
    </div>
    <!-- /.form-box -->
</div>

<%@include file="../pages/script.jsp" %>
<script type="text/javascript">
    $(function () {
        $("#sub").click(function () {

            if ($("input[name = 'adminName']").val() == '' || $("input[name = 'adminPassword']").val() == '') {
                alert("内容不可为空！")
                return false
            }
        })
    })
</script>
</body>

</html>