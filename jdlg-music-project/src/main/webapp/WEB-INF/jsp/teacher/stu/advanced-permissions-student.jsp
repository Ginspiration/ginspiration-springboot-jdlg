<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>
<html>
<head>

    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>static/plugins/base64/base64.js"></script>

    <script>
        function checkRegisterStudent() {
            uName = $("input[name = 'sRegName']").val()
            uNumber = $("input[name = 'sRegNumber']").val()
            uPwd = $("input[name = 'sRegPwd']").val()
            uPwd2 = $("input[name = 'sRegPwd2']").val()
            if (uName == '' || uPwd == '' || uPwd2 == '' || uNumber == '') {
                alert("请填写完整信息！")
                return false
            } else if (uPwd != uPwd2) {
                alert("两次输入密码不一致！")
                $("input[name = 'sRegPwd']").val('')
                $("input[name = 'sRegPwd2']").val('')
                return false
            } else
                ajaxRegisterStudent()
        }

        function ajaxRegisterStudent() {
            $.ajax({
                url: "regStudent",
                data: $("#form1").serialize(),
                dataType: "text",
                type: "post",
                success: function (rep) {
                    //alert($("#form1").serialize())
                    alert(rep)
                }
            })
            $("input[name = 'sRegName']").val('')
            $("input[name = 'sRegNumber']").val('')
            $("input[name = 'sRegPwd']").val('')
            $("input[name = 'sRegPwd2']").val('')
        }

        $(function () {
            $("#subAble").click(function () {
                check()
            })
            $("#subDisable").click(function () {
                check2()
            })
        })

        function check() {
            var msg = $("input[name='seekId']").val()
            if (msg == '') {
                alert("请填写完整信息！")
                return false
            } else
                ajaxAble()
        }

        function check2() {
            var msg = $("input[name='seekId2']").val()
            if (msg == '') {
                alert("请填写完整信息！")
                return false
            } else
                ajaxDisable()
        }

        function ajaxAble() {
            var Id = $("input[name='seekId']").val()
            $.ajax({
                url: "ableStudent",
                type: "post",
                dataType: "text",
                data: {
                    seekId: Id
                },
                success: function (rep) {
                    alert(rep)
                }
            })
        }

        function ajaxDisable() {
            var Id = $("input[name='seekId2']").val()
            $.ajax({
                url: "disableStudent",
                type: "post",
                dataType: "text",
                data: {
                    seekId: Id
                },
                success: function (rep) {
                    alert(rep)
                }
            })
        }

        function ajaxDeleteStu() {
            var deleteNumber = $("input[name='deleteStu']").val()

            confirm({
                title: '确认删除',
                content: '',
                doneText: '确认',
                cancelText: '取消'
            }).then(() => {
                //console.log('已确认')
                if (deleteNumber !== '') {
                    $.ajax({
                        url: 'deleteStudent',
                        data: {
                            deleteNumber: deleteNumber
                        },
                        dataType: 'text',
                        type: 'post',
                        success: function (resp) {
                            alert(resp)
                        }
                    })
                } else
                    alert('请输入学号！')
            }).catch(() => {
                //console.log('已取消')
            })

        }

        function ajaxResetPasswordBysId() {
            var sId = $("input[name='resetSId']").val()
            var firstPassword = $("input[name='resetFirstPassword']").val()
            var secondPassword = $("input[name='resetSecondPassword']").val()
            if (sId !== '' && firstPassword !== '' && secondPassword !== '') {
                if (firstPassword === secondPassword) {
                    $.ajax({
                        url: 'resetStudentPassword',
                        data: {
                            sId: sId,
                            password: firstPassword
                        },
                        type: 'post',
                        dataType: 'text',
                        success: function (resp) {
                            alert(resp)
                        }

                    })
                } else {
                    alert('两次密码输入不一致，请重试')
                    $("input[name='resetFirstPassword']").val('')
                    $("input[name='resetSecondPassword']").val('')
                    return false
                }
            } else {
                alert('输入完整内容！')
                return false
            }
        }

        function ajaxResetAllStudentPassword() {
            var firstPassword = $("input[name='resetAllStudentPassword']").val()
            var secondPassword = $("input[name='resetAllStudentPassword2']").val()
            if (firstPassword !== '' && secondPassword !== '') {
                if (firstPassword === secondPassword) {
                    $.ajax({
                        url: 'resetAllStudentPassword',
                        data: {
                            password: firstPassword
                        },
                        dataType: 'text',
                        type: 'post',
                        success: function (resp) {
                            alert(resp)
                        }
                    })
                } else {
                    alert('两次密码不一致')
                    $("input[name='resetAllStudentPassword']").val('')
                    $("input[name='resetAllStudentPassword2']").val('')
                    return false
                }
            } else {
                alert('输入完整信息')
            }
        }
        function ajaxFindStudentByName() {
            var name = $("input[name='nameSearch']").val()
            if (name!==''){
                $.ajax({
                    url:'queryStudentsByName',
                    data:{
                        sName:name
                    },
                    dataType:'json',
                    type:'post',
                    success:function (resp) {
                        if (resp.length !== 0){
                            $('#showStudent').empty()
                            $('#showStudent').append("           <tr>\n" +
                                "                                    <td>学号</td>\n" +
                                "                                    <td>姓名</td>\n" +
                                "                                    <td>是否被禁用</td>\n" +
                                "                                </tr>")
                            $.each(resp,function (i,res) {
                                var used = '否'
                                if (res.used===1)
                                    used = '是'
                                $('#showStudent').append("           <tr>\n" +
                                    "                                    <td>"+res.student_id+"</td>\n" +
                                    "                                    <td>"+res.student_name+"</td>\n" +
                                    "                                    <td>"+used+"</td>\n" +
                                    "                                </tr>")
                            })
                        }else {
                            $('#showStudent').empty()
                            $('#showStudent').append("暂无结果")
                        }
                    }
                })
            }else {
                alert('输入信息')
                return false
            }
        }
    </script>
</head>
<body>
<div class="content-wrapper">
    <!-- 内容头部 -->
    <section class="content-header">
        <h1>
            ${sessionScope.tName}
            <small>(教师)</small>
        </h1>
    </section>

    <section class="content">
        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#activity" data-toggle="tab">学生管理</a></li>
            </ul>

            <div class="tab-content">
                <div class="active tab-pane" id="activity">

                    <hr/>
                    <div class="row">
                        <div class="col-sm-offset-4">
                            <form class="navbar-form navbar-left">
                                <div class="form-group">
                                    <input type="text" class="form-control" placeholder="学生姓名" name="nameSearch">
                                </div>
                                <button type="button" class="btn btn-default" onclick="ajaxFindStudentByName()">学生搜索</button>
                            </form>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-offset-5">
                            <h6>(通过学生姓名关键字查找)</h6>
                        </div>
                        <div class="col-sm-6 col-sm-offset-3" >
                            <table border="2" id="showStudent" width="600">

                            </table>
                        </div>
                    </div>
                    <hr/>
                    <div class="row">
                        <div class="col-sm-1"></div>
                        <div class="col-sm-4" style="background: #97c1ec">
                            <div align="center"><h4>添加学生</h4>
                                <form method="post" id="form1">
                                    <div class="form-group has-feedback">
                                        <input type="text" class="form-control" placeholder="姓名" name="sRegName">
                                        <span class="glyphicon glyphicon-user form-control-feedback"></span>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <input type="text" class="form-control" placeholder="学号" name="sRegNumber">
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
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <button type="button" class="btn btn-default btn-block btn-flat"
                                                    onclick="checkRegisterStudent()">添加
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-sm-2"></div>
                        <div class="col-sm-4" style="background: #97c1ec">
                            <div align="center"><h4>禁用学生</h4>
                                <form id="formDisable" method="post">
                                    <div class="form-group has-feedback">
                                        <input type="text" class="form-control" placeholder="输入要禁用的学号" name="seekId2">
                                        <span class="glyphicon glyphicon-pencil form-control-feedback"></span>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <button type="button" class="btn btn-default btn-block btn-flat"
                                                    id="subDisable">提交
                                            </button>
                                        </div>
                                    </div>
                                </form>
                                <h4>启用学生</h4>
                                <form id="formAble" method="post">
                                    <div class="form-group has-feedback">
                                        <input type="text" class="form-control" placeholder="输入要启用的学号" name="seekId">
                                        <span class="glyphicon glyphicon-pencil form-control-feedback"></span>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <button type="button" class="btn btn-dark btn-block btn-flat"
                                                    id="subAble">提交
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <div class="row">
                        <div class="col-sm-1"></div>
                        <div class="col-sm-4" style="background: #97c1ec">
                            <div align="center"><h4>删除学员</h4>
                                <form id="formDisable2" method="post">
                                    <div class="form-group has-feedback">
                                        <input type="text" class="form-control" placeholder="输入要删除的学号" name="deleteStu">
                                        <span class="glyphicon glyphicon-pencil form-control-feedback"></span>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <button type="button" class="btn btn-default btn-block btn-flat"
                                                    onclick="ajaxDeleteStu()">提交
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-sm-2"></div>
                        <div class="col-sm-4" style="background: #97c1ec">
                            <div align="center"><h4>重置学员密码</h4>
                                <form id="formDisable3" method="post">
                                    <div class="form-group has-feedback">
                                        <input type="text" class="form-control" placeholder="输入要重置的学号" name="resetSId">
                                        <span class="glyphicon glyphicon-pencil form-control-feedback"></span>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <input type="password" class="form-control" placeholder="新密码"
                                               name="resetFirstPassword">
                                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                    </div>
                                    <div class="form-group has-feedback">
                                        <input type="password" class="form-control" placeholder="确认新密码"
                                               name="resetSecondPassword">
                                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <button type="button" class="btn btn-default btn-block btn-flat"
                                                    onclick="ajaxResetPasswordBysId()">提交
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <div >
                    <div class="row">
                        <div class="col-sm-4 col-sm-offset-4" >
                            <div class="form-group has-feedback">
                                <input type="password" class="form-control" placeholder="新密码"
                                       name="resetAllStudentPassword">
                                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                            </div>
                            <div class="form-group has-feedback">
                                <input type="password" class="form-control" placeholder="确认新密码"
                                       name="resetAllStudentPassword2">
                                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="col-sm-6 col-sm-offset-4">
                            <button class="btn btn-danger" onclick="ajaxResetAllStudentPassword()"><h3>重置所有学员密码</h3>
                            </button>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
</div>
</body>
</html>
