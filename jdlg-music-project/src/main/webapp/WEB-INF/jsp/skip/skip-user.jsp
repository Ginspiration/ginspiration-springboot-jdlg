<%@ page import="java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" + request.getServerPort() +
            request.getContextPath() + "/";
%>
<html>
<head>
    <title>跳转</title>
</head>
<body>
<div align="center">
    <%

        String tName = (String) session.getAttribute("tName");
        Integer tchIdInteger = (Integer) session.getAttribute("tId");
        String tId = String.valueOf(tchIdInteger);

        String sName = null;
        String sId = null;

        /*学生是否被禁用*/
        if (session.getAttribute("used") == null) {
            sName = (String) session.getAttribute("sName");
            Integer stuIdInteger = (Integer) session.getAttribute("sId");
            sId = String.valueOf(stuIdInteger);

            /*教师登录*/
            if (tName != null && tId != null) {
                /*Base64加密属性*/
                String tNameBase64 = Base64.getEncoder().encodeToString(tName.getBytes("utf-8"));
                String tIdBase64 = Base64.getEncoder().encodeToString(tId.getBytes("utf-8"));
                response.sendRedirect(basePath + "doTeacher/indexTeacher?tName=" + tNameBase64 + "&tId=" + tIdBase64);

                /*学生登录*/
            } else if (sName != null && sId != null) {
                String sNameBase64 = Base64.getEncoder().encodeToString(sName.getBytes("utf-8"));
                String sIdBase64 = Base64.getEncoder().encodeToString(sId.getBytes("utf-8"));
                response.sendRedirect(basePath + "doStudent/indexStudent?sName=" + sNameBase64 + "&sId=" + sIdBase64);
            } else
                response.sendRedirect(basePath + "index.jsp");
        } else {
            session.invalidate();
    %>
    <h1>你已被教师禁用！</h1><br/><br/>
    <h1><a href="<%=basePath%>index.jsp">点击返回首页</a></h1>
    <%
        }
    %>
</div>
</body>
</html>
