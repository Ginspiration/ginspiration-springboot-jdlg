<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>
    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>

    <%
        int webUsed = (int) session.getAttribute("webUsed");
        int webRegister = (int) session.getAttribute("webRegister");

        String used = null;
        String register = null;
        if (webUsed == 0) {
            used = "允许学生访问网站";
        } else if (webUsed == 1) {
            used = "禁止学生访问网站";
        }
        if (webRegister == 0) {
            register = "允许学生注册";
        } else if (webRegister == 1) {
            register = "禁止学生注册";
        }
    %>
    <script type="text/javascript">
        var flagUse = '<%=webUsed%>';
        var flagReg = '<%=webRegister%>';
        $(function () {
            //$('#selectWebUse').find("option[]")
            if (flagUse == 0) {
                $('#selectWebUse').find("option[value='0']").attr('selected', true)
            } else {
                $('#selectWebUse').find("option[value='1']").attr('selected', true)
            }
            if (flagReg == 0) {
                $('#selectRegister').find("option[value='0']").attr('selected', true)
            } else {
                $('#selectRegister').find("option[value='1']").attr('selected', true)
            }
        })

        function submit() {
            flagUse = $('#selectWebUse').val()
            flagReg = $('#selectRegister').val()
            //alert(flagUse+flagReg)
            $.ajax({
                url: "webSubmit",
                data: {
                    webUsed: flagUse,
                    registered: flagReg
                },
                type: "post",
                dataType: "text",
                success: function (rep) {
                    alert(rep)
                }
            })
        }
    </script>
    <style>
        .shortselect {
            background: #fafdfe;
            height: 28px;
            width: 180px;
            line-height: 28px;
            border: 1px solid #9bc0dd;
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
            border-radius: 2px;
        }
    </style>
<div class="content-wrapper">
    <!-- 内容头部 -->
    <section class="content-header">
        <h1>
            ${sessionScope.tName}
            <small>(教师)</small>
        </h1>
    </section>

    <section class="content">
        <div class="row">
            <div align="center">
                <select id="selectWebUse" class="shortselect">
                    <option value="">---请选择--</option>
                    <option value="0">允许学生访问网站</option>
                    <option value="1">禁止学生访问网站</option>
                </select>
                ---------网站管理-----------
                <select id="selectRegister" class="shortselect">
                    <option value="">---请选择--</option>
                    <option value="0">允许学生注册</option>
                    <option value="1">禁止学生注册</option>
                </select>
                <br/><br/><br/><br/><br/><br/><br/>
                <button type="button" onclick="submit()" class="btn btn-warning">确认提交</button>
            </div>
        </div>
    </section>
</div>
