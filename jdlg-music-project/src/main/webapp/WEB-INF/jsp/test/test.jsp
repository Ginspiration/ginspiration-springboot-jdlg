<!--整个文件是放在WEB-INF的jsp目录下的，如果应用文件路径不对，可以手动修改-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!--这是basePath包含文件，获取网站的url-->
<%@include file="../pages/web-url.jsp" %>
<!--这是<basePath包含文件，获取网站的url-->

<html>
<head>
    <!--由于是用jsp:include page=""动态包含，所以每个新建的jsp文件都要加入自己的引用文件jQuery，bootstrap等-->
    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
<!--这里是主体内容窗口-->
<div class="content-wrapper">
    <!--内容头部显示用户名称-->
    <section class="content-header">
        <h1>
            ${sessionScope.tName}
            <small>(教师)</small>
        </h1>
    </section>
    <!--内容头部显示用户名称-->

    <!--这里是内容主体居中显示，放在section里面-->
    <section class="content">
        <!-- 这里可以添加div内容，content表示居中，其他div可以自己添加-->
        <div class="container">
            <audio src="test/孙燕姿%20-%20遇见.mp3" controls="controls"></audio>
            <video src='' controls='controls' width='20%' height='21%'></video>
        </div>
        <!-- 这里可以添加div内容，content表示居中，其他div可以自己添加-->
    </section>
    <!--这里是内容主体居中显示，放在section里面-->
</div>
<!--这里是主体内容窗口-->
</body>
</html>
