<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--网站地址--%>
<%@include file="../pages/web-url.jsp" %>
<html>
<%
    String userName = null;
    //String indexPath = null;
    String Context = "../news/news-index.jsp";
    /*获取包含主体内容信息*/
    String ConMessage = (String) request.getAttribute("Context");
    if (ConMessage != null) {
        Context = ConMessage;
    }
    String stuName = (String) request.getSession().getAttribute("sName");
    Integer stuId = (Integer) session.getAttribute("sId");
    if (stuName == null || stuId == null) {
        response.sendRedirect(basePath + "index.jsp");
    } else {
        userName = stuName;
        //indexPath = "state";
    }
%>
<head>
    <%@include file="../pages/link.jsp" %>
</head>

<body class="hold-transition skin-black layout-boxed sidebar-mini">

<div class="wrapper">

    <!-- 页面头部 -->
    <header class="main-header">
        <a href="" class="logo">
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>学生</b>前台</span>
        </a>
       <%-- <%@include file="../pages/head-student.jsp" %>--%>
        <jsp:include page="../pages/head-student.jsp"/>

    </header>

    <!-- 导航侧栏 -->
    <%@include file="../pages/student-sidebar.jsp" %>

    <!-- 内容区域 -->
    <jsp:include page="<%=Context%>"/>

    <!-- 底部导航 -->
    <%@include file="../pages/footer.jsp" %>
</div>
<%--js文件--%>
<%@include file="../pages/script.jsp" %>
</body>

</html>