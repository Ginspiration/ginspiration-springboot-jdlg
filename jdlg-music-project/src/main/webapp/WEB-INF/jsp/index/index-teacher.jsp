<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%--网站地址--%>
<%@include file="../pages/web-url.jsp" %>
<%
    String userName = null;
    String indexPath = null;
    String Context = "../news/news-index.jsp";
    /*获取包含主体内容信息*/
    String ConMessage = (String) request.getAttribute("Context");
    if (ConMessage != null) {
        Context = ConMessage;
    }
    String tName = (String) session.getAttribute("tName");

    Integer tchIdInteger = (Integer) session.getAttribute("tId");
    String tId = String.valueOf(tchIdInteger);

    if (tName == null || tId == null) {
        response.sendRedirect(basePath + "index.jsp");
    } else {
        userName = tName;
        indexPath = "state";
    }
%>
<head>
    <%@include file="../pages/link.jsp" %>

</head>
<body class="hold-transition skin-black sidebar-mini">
<%--<body class="hold-transition skin-black layout-boxed sidebar-mini">--%>

<div class="wrapper">

    <!-- 页面头部 -->
    <header class="main-header">
        <a href="state" class="logo">
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>教师</b>后台管理</span>
        </a>
        <%@include file="../pages/head-teacher.jsp" %>
    </header>

    <!-- 导航侧栏 /-->
    <%@include file="../pages/teacher-sidebar.jsp" %>

    <!-- 内容区域 -->
    <jsp:include page="<%=Context%>"/>

    <!-- 底部导航 -->
    <%@include file="../pages/footer.jsp" %>
</div>
<%--引入js--%>
<%@include file="../pages/script.jsp" %>

</body>

</html>
<!---->