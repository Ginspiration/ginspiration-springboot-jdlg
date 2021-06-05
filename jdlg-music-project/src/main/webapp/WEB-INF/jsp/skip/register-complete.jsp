<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" + request.getServerPort() +
            request.getContextPath() + "/";
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div align="center">
    <h1>注册成功！</h1>
    <%
        String message = null;
        String user = null;
        String sName = (String) request.getAttribute("sName");
        String tName = (String) request.getAttribute("tName");
        if (sName != null) {
            user = "学生";
            message = "loginStudent/state?sName=" + sName;
        } else if (tName != null) {
            user = "教师";
            message = "loginTeacher/state?tName=" + tName;
        } else
            response.sendRedirect(basePath);
    %>
    <a href="<%=basePath+message%>"><h1>点击进入<%=user%>首页</h1></a>
</div>
</body>
</html>
