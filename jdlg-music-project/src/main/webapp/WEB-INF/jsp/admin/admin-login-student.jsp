<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../pages/web-url.jsp" %>
<html>

<head>
    <%@include file="../pages/link.jsp" %>
</head>

<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">


        <a href="skip/skip.jsp"><b>学生</b>学习登录</a>


    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">登录</p>

        <form action="stuJudge" method="post" id="form1">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="学号" name="sId">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="密码" name="sPwd">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="row">
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat" id="sub">确认</button>
                </div>
                <!-- /.col -->
            </div>
        </form>
        <!-- /.social-auth-links -->

        <a href="#">忘记密码</a><br>
        <a href="all-admin-register.html" class="text-center">新用户注册</a>

    </div>
    <!-- /.login-box-body -->
</div>
</body>
<%@include file="../pages/script.jsp" %>
<script>
    $(function () {
        $("#sub").click(function () {
            //创建正则表达式，/^[0-9][0-9]{6}$/ ：匹配6位数字
            var reg=new RegExp(/^[0-9][0-9]{6}$/);
            if ($("input[name = 'sId']").val() == '' || $("input[name = 'sPwd']").val() == '') {
                alert("内容不可为空！")
                return false
            }else if (!reg.test($("input[name = 'sId']").val())){
                alert("输入不规范！")
                return false
            }
        })
    })
</script>
</body>

</html>