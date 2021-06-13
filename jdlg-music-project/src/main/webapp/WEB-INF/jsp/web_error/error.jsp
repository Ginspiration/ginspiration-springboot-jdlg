<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../pages/web-url.jsp" %>
<html>
<head>
    <title>错误页面</title>
    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <%--    <script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>--%>
    <script>
        $(function () {
            $('.errorContext').empty()
            var statusNumber = ${errorStatus};
            var statusStr;
            if (statusNumber === 87654321)
                statusStr = '发生了未知错误...'
            else if (statusNumber === 500) {
                statusStr = '服务器开小差了...';
            } else if (statusNumber === 404)
                statusStr = '页面未找到...'
            var context = "<br/><br/><br/><br/><br/><br/>\n" +
                "    <h1>Opps! " + statusStr + "，您可以返回</h1><a href=\"/\">首页</a>"
            $('.errorContext').append(context)
        })
    </script>
</head>
<body>
<div align="center" class="errorContext">
</div>
</body>
</html>
