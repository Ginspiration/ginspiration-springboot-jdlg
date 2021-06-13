<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" + request.getServerPort() +
            request.getContextPath() + "/";
%>
<head>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" name="viewport">
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>static/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/iCheck/square/blue.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/morris/morris.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/datepicker/datepicker3.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/datatables/dataTables.bootstrap.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/treeTable/jquery.treetable.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/treeTable/jquery.treetable.theme.default.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/select2/select2.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/colorpicker/bootstrap-colorpicker.min.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/bootstrap-markdown/css/bootstrap-markdown.min.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/adminLTE/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="<%=basePath%>static/css/style.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/ionslider/ion.rangeSlider.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/ionslider/ion.rangeSlider.skinNice.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/bootstrap-slider/slider.css">
    <link rel="stylesheet" href="<%=basePath%>static/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.css">

</head>

<body class="hold-transition skin-purple sidebar-mini">


<div class="wrapper">

    <!-- 页面头部 -->
    <header class="main-header">


        <!-- Logo -->
        <a href="skip/skip.jsp" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>音乐</b></span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>音乐</b>学习系统</span>
        </a>


        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>

            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <!-- User Account: style can be found in dropdown.less -->
                    <li class="dropdown user user-menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <span class="hidden-xs">登录</span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="loginPosition" class="btn btn-default btn-flat">登录</a>
                                </div>
                                <div class="pull-right">
                                    <a href="registerPosition" class="btn btn-default btn-flat">注册</a>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <!-- 页面头部 /-->

    <!-- 导航侧栏 -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- Sidebar user panel -->
            <ul class="sidebar-menu">
                <li class="header">菜单</li>

                <!-- 菜单 -->
                <li class="treeview">
                    <a href="#">
                        <i class="fa fa-folder"></i> <span>用户</span>
                        <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                    </a>
                    <ul class="treeview-menu">

                        <li id="admin-login">
                            <a href="loginPosition">
                                <i class="fa fa-circle-o"></i> 登录
                            </a>
                        </li>

                        <li id="admin-register">
                            <a href="registerPosition">
                                <i class="fa fa-circle-o"></i> 注册
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>
    <!-- 导航侧栏 /-->

    <!-- 内容区域 -->
    <div class="content-wrapper">

        <!-- 内容头部 -->
        <section class="content-header">
            <h1>
                <small>首页</small>
            </h1>
        </section>
        <!-- 内容头部 /-->

        <!-- 正文区域 -->
        <section class="content">
            <div class="row">
                <c:forEach items="${news}" var="news" varStatus="status">

                    <div class="col-md-12">
                        <!-- Box Comment -->
                        <div class="box box-widget collapsed-box">
                            <div class="box-header with-border">
                                <div class="user-block">
                                    <span class="username"><a>${news.newTitle}</a></span>
                                    <span class="description">发布时间:${news.upDate}</span>
                                </div>
                                <!-- /.user-block -->
                                <div class="box-tools">
                                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i
                                            class="fa fa-plus">点击展开</i>
                                    </button>
                                    <button type="button" class="btn btn-box-tool" data-widget="remove"><i
                                            class="fa fa-times"></i></button>
                                </div>
                                <!-- /.box-tools -->
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <!-- post text -->
                                <p>${news.newContext}</p>

                                <!-- Attachment -->
                                <div class="clearfix"  id="pic${status.count}">

                                    <script>
                                        $(function () {
                                            //1.存储的图片字符串分割
                                            let pic = "${news.newImgUrl}"
                                            pic = pic.split("&*&")
                                            if(pic != ""){
                                                $("#pic${status.count}").append("<hr size='100px' />");
                                                for (let i = 0; i < pic.length; i++) {
                                                    $("#pic${status.count}").append("<img class='attachment-img' " +
                                                        "style='margin-left:5px;width:100px' " +
                                                        "src='<%=basePath%>" + pic[i] + "' />")
                                                }
                                            }
                                            else{
                                                $("#pic${status.count}").append("<div style='margin:100px' />")
                                            }

                                        })
                                    </script>

                                </div>
                                <!-- /.attachment-block -->
                            </div>
                            <!-- /.box-footer -->
                        </div>
                        <!-- /.box -->
                    </div>
                    <!-- /.col -->

                </c:forEach>
            </div>
            <!-- /.row -->


        </section>
        <!-- 正文区域 /-->

    </div>
    <!-- 内容区域 /-->

    <!-- 底部导航 -->
    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            <b>Version</b> 1.0.0
        </div>
        <strong>Copyright &copy; 2020-2021 <a href="https://www.ecjtuit.edu.cn">华东交通大学理工学院</a></strong>
    </footer>
    <!-- 底部导航 /-->

</div>


<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>static/plugins/jQueryUI/jquery-ui.min.js"></script>
<script>
    $.widget.bridge('uibutton', $.ui.button);
</script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/plugins/raphael/raphael-min.js"></script>
<script src="<%=basePath%>static/plugins/morris/morris.min.js"></script>
<script src="<%=basePath%>static/plugins/sparkline/jquery.sparkline.min.js"></script>
<script src="<%=basePath%>static/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="<%=basePath%>static/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<script src="<%=basePath%>static/plugins/knob/jquery.knob.js"></script>
<script src="<%=basePath%>static/plugins/daterangepicker/moment.min.js"></script>
<script src="<%=basePath%>static/plugins/daterangepicker/daterangepicker.js"></script>
<script src="<%=basePath%>static/plugins/daterangepicker/daterangepicker.zh-CN.js"></script>
<script src="<%=basePath%>static/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="<%=basePath%>static/plugins/datepicker/locales/bootstrap-datepicker.zh-CN.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<script src="<%=basePath%>static/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<script src="<%=basePath%>static/plugins/fastclick/fastclick.js"></script>
<script src="<%=basePath%>static/plugins/iCheck/icheck.min.js"></script>
<script src="<%=basePath%>static/plugins/adminLTE/js/app.min.js"></script>
<script src="<%=basePath%>static/plugins/treeTable/jquery.treetable.js"></script>
<script src="<%=basePath%>static/plugins/select2/select2.full.min.js"></script>
<script src="<%=basePath%>static/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-wysihtml5/bootstrap-wysihtml5.zh-CN.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-markdown/js/bootstrap-markdown.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-markdown/locale/bootstrap-markdown.zh.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-markdown/js/markdown.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-markdown/js/to-markdown.js"></script>
<script src="<%=basePath%>static/plugins/ckeditor/ckeditor.js"></script>
<script src="<%=basePath%>static/plugins/input-mask/jquery.inputmask.js"></script>
<script src="<%=basePath%>static/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="<%=basePath%>static/plugins/input-mask/jquery.inputmask.extensions.js"></script>
<script src="<%=basePath%>static/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="<%=basePath%>static/plugins/datatables/dataTables.bootstrap.min.js"></script>
<script src="<%=basePath%>static/plugins/chartjs/Chart.min.js"></script>
<script src="<%=basePath%>static/plugins/flot/jquery.flot.min.js"></script>
<script src="<%=basePath%>static/plugins/flot/jquery.flot.resize.min.js"></script>
<script src="<%=basePath%>static/plugins/flot/jquery.flot.pie.min.js"></script>
<script src="<%=basePath%>static/plugins/flot/jquery.flot.categories.min.js"></script>
<script src="<%=basePath%>static/plugins/ionslider/ion.rangeSlider.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-slider/bootstrap-slider.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"></script>

<script>
    $(document).ready(function () {
        // 选择框
        $(".select2").select2();

        // WYSIHTML5编辑器
        $(".textarea").wysihtml5({
            locale: 'zh-CN'
        });
    });


    // 设置激活菜单
    function setSidebarActive(tagUri) {
        var liObj = $("#" + tagUri);
        if (liObj.length > 0) {
            liObj.parent().parent().addClass("active");
            liObj.addClass("active");
        }
    }


    $(document).ready(function () {
        // 激活导航位置
        setSidebarActive("admin-index");
    });
</script>

<style>
    /*内嵌水平线*/
    hr.style-one {
        width: 80%;
        margin: 0 auto;
        border: 0;
        height: 0;
        border-top: 1px solid rgba(0, 0, 0, 0.1);
        border-bottom: 1px solid rgba(255, 255, 255, 0.3);
    }
</style>
</body>

</html>
<!---->