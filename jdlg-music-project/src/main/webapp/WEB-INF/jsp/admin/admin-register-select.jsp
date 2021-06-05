<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../pages/web-url.jsp" %>
<html>

<head>
    <%@include file="../pages/link.jsp" %>
</head>
<body>
<div align="center">
    <ol class="breadcrumb">
        <li><a href="index.jsp"><i class="fa fa-dashboard"></i> 首页</a></li>
    </ol>
    <br/><br/><br/><br/><br/>
    <div class="small-box bg-green" style="width: 400px">
        <div class="inner">
            <h3>学生<sup style="font-size: 20px">注册</sup></h3>
        </div>
        <div class="icon">
            <i class="ion ion-person-add"></i>
        </div>
        <a href="registerStudent/regStudent" class="small-box-footer">点击进入<i
                class="fa fa-arrow-circle-right"></i></a>
    </div>
    <!-- small box -->
    <div class="small-box bg-yellow" style="width: 400px">
        <div class="inner">
            <h3>教师<sup style="font-size: 20px">注册</sup></h3>
        </div>
        <div class="icon">
            <i class="ion ion-person-add"></i>
        </div>
        <a href="registerTeacher/regTeacher" class="small-box-footer">点击进入<i
                class="fa fa-arrow-circle-right"></i></a>
    </div>
</div>

<%@include file="../pages/script.jsp" %>
</body>

</html>
<!---->