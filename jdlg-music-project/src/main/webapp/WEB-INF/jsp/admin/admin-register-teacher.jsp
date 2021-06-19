<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../pages/web-url.jsp" %>
<html>

<head>
    <%@include file="../pages/link.jsp" %>
</head>

<body class="hold-transition register-page">
<div class="register-box">
    <div class="register-logo">


        <a href="skip/skip.jsp"><b>教师</b>后台管理注册</a>


    </div>

    <div class="register-box-body">
        <p class="login-box-msg">验证成功，请注册</p>
        <form action="regMessage" method="post">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="姓名" name="sRegName">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="教师号" name="sRegNumber">
                <span class="glyphicon glyphicon-pencil form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="密码" name="sRegPwd">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="确认密码" name="sRegPwd2">
                <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
            </div>
            <div class="row"><%--
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox"> 我同意 <a href="#">协议</a>
                        </label>
                    </div>
                </div>--%>
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat" id="sub">注册</button>
                </div>
                <!-- /.col -->
            </div>
        </form>


        <a href="<%=basePath%>loginTeacher/Teacher" class="text-center">我有账号，现在就去登录</a>
    </div>
    <!-- /.form-box -->
</div>
<%@include file="../pages/script.jsp" %>
>
<script>
    $(function () {
        $("#sub").click(function () {
            uName = $("input[name = 'sRegName']").val()
            uNumber = $("input[name = 'sRegNumber']").val()
            uPwd = $("input[name = 'sRegPwd']").val()
            uPwd2 = $("input[name = 'sRegPwd2']").val()
            if (uName == '' || uPwd == '' || uPwd2 == '' || uNumber == '') {
                alert("请填写完整信息！")
                return false
            }
            if (uPwd != uPwd2) {
                alert("两次输入密码不一致！")
                $("input[name = 'sRegPwd']").val('')
                $("input[name = 'sRegPwd2']").val('')
                return false
            }
        })
    })
</script>
</body>

</html>