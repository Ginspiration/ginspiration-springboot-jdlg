<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../pages/web-url.jsp" %>
<html>

<head>
    <%@include file="../pages/link.jsp" %>
</head>

<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">


        <a href="skip/skip.jsp"><b>教师</b>后台管理</a>


    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">用户名或密码错误！重新输入</p>

        <form action="TchJudge" method="post" id="form1">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="教师号" name="tId">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="密码" name="tPwd">
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
        <a href="all-admin-register.html" class="text-center">新用户注册</a>

    </div>
    <!-- /.login-box-body -->
</div>
</body>
<%@include file="../pages/script.jsp" %>
<script>
    $(function () {
        $("#sub").click(function () {
            var tId = $("input[name = 'tId']").val()
            var tPwd = $("input[name = 'tPwd']").val()
            var reg=new RegExp(/^[0-9][0-9]{6}$/);
            if (tId == '' ||tPwd  == '') {
                alert("内容不可为空！")
                return false
            }else if (!reg.test(tId)){
                //console.log(reg.test(tId));
                alert("输入不规范！")
                return false
            }
        })
    })
</script>
</body>

</html>