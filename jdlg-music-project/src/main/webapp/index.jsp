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

<script>
        window.location.href = "index"
</script>

<div class="wrapper">

<%--    <!-- 页面头部 -->--%>
<%--    <header class="main-header">--%>


<%--        <!-- Logo -->--%>
<%--        <a href="skip/skip.jsp" class="logo">--%>
<%--            <!-- mini logo for sidebar mini 50x50 pixels -->--%>
<%--            <span class="logo-mini"><b>音乐系统</b></span>--%>
<%--            <!-- logo for regular state and mobile devices -->--%>
<%--            <span class="logo-lg"><b>音乐</b>系统</span>--%>
<%--        </a>--%>


<%--        <!-- Header Navbar: style can be found in header.less -->--%>
<%--        <nav class="navbar navbar-static-top">--%>
<%--            <!-- Sidebar toggle button-->--%>
<%--            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">--%>
<%--                <span class="sr-only">Toggle navigation</span>--%>
<%--            </a>--%>

<%--            <div class="navbar-custom-menu">--%>
<%--                <ul class="nav navbar-nav">--%>
<%--                    <!-- Messages: style can be found in dropdown.less-->--%>
<%--                    <li class="dropdown messages-menu">--%>
<%--                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">--%>
<%--                            <i class="fa fa-envelope-o"></i>--%>
<%--                            <span class="label label-success">4</span>--%>
<%--                        </a>--%>
<%--                        <ul class="dropdown-menu">--%>
<%--                            <li class="header">你有4个邮件</li>--%>
<%--                            <li>--%>
<%--                                <!-- inner menu: contains the actual data -->--%>
<%--                                <ul class="menu">--%>
<%--                                    <li>--%>
<%--                                        <!-- start message -->--%>
<%--                                        <a href="#">--%>
<%--                                            <div class="pull-left">--%>
<%--                                                <img src="<%=basePath%>static/img/user2-160x160.jpg" class="img-circle"--%>
<%--                                                     alt="User Image">--%>
<%--                                            </div>--%>
<%--                                            <h4>--%>
<%--                                                系统消息--%>
<%--                                                <small><i class="fa fa-clock-o"></i> 5 分钟前</small>--%>
<%--                                            </h4>--%>
<%--                                            <p>欢迎</p>--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <!-- end message -->--%>
<%--                                    <li>--%>
<%--                                        <a href="#">--%>
<%--                                            <div class="pull-left">--%>
<%--                                                <img src="<%=basePath%>static/img/user3-128x128.jpg" class="img-circle"--%>
<%--                                                     alt="User Image">--%>
<%--                                            </div>--%>
<%--                                            <h4>--%>
<%--                                                团队消息--%>
<%--                                                <small><i class="fa fa-clock-o"></i> 2 小时前</small>--%>
<%--                                            </h4>--%>
<%--                                            <p>你有新的任务了</p>--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <li>--%>
<%--                                        <a href="#">--%>
<%--                                            <div class="pull-left">--%>
<%--                                                <img src="<%=basePath%>static/img/user4-128x128.jpg" class="img-circle"--%>
<%--                                                     alt="User Image">--%>
<%--                                            </div>--%>
<%--                                            <h4>--%>
<%--                                                Developers--%>
<%--                                                <small><i class="fa fa-clock-o"></i> Today</small>--%>
<%--                                            </h4>--%>
<%--                                            <p>Why not buy a new awesome theme?</p>--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <li>--%>
<%--                                        <a href="#">--%>
<%--                                            <div class="pull-left">--%>
<%--                                                <img src="<%=basePath%>static/img/user3-128x128.jpg" class="img-circle"--%>
<%--                                                     alt="User Image">--%>
<%--                                            </div>--%>
<%--                                            <h4>--%>
<%--                                                Sales Department--%>
<%--                                                <small><i class="fa fa-clock-o"></i> Yesterday</small>--%>
<%--                                            </h4>--%>
<%--                                            <p>Why not buy a new awesome theme?</p>--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <li>--%>
<%--                                        <a href="#">--%>
<%--                                            <div class="pull-left">--%>
<%--                                                <img src="<%=basePath%>static/img/user4-128x128.jpg" class="img-circle"--%>
<%--                                                     alt="User Image">--%>
<%--                                            </div>--%>
<%--                                            <h4>--%>
<%--                                                Reviewers--%>
<%--                                                <small><i class="fa fa-clock-o"></i> 2 days</small>--%>
<%--                                            </h4>--%>
<%--                                            <p>Why not buy a new awesome theme?</p>--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                </ul>--%>
<%--                            </li>--%>
<%--                            <li class="footer"><a href="#">See All Messages</a></li>--%>
<%--                        </ul>--%>
<%--                    </li>--%>
<%--                    <!-- Notifications: style can be found in dropdown.less -->--%>
<%--                    <li class="dropdown notifications-menu">--%>
<%--                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">--%>
<%--                            <i class="fa fa-bell-o"></i>--%>
<%--                            <span class="label label-warning">10</span>--%>
<%--                        </a>--%>
<%--                        <ul class="dropdown-menu">--%>
<%--                            <li class="header">你有10个新消息</li>--%>
<%--                            <li>--%>
<%--                                <!-- inner menu: contains the actual data -->--%>
<%--                                <ul class="menu">--%>
<%--                                    <li>--%>
<%--                                        <a href="#">--%>
<%--                                            <i class="fa fa-users text-aqua"></i> 5 new members joined today--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <li>--%>
<%--                                        <a href="#">--%>
<%--                                            <i class="fa fa-warning text-yellow"></i> Very long description here that--%>
<%--                                            may not--%>
<%--                                            fit into the page and may cause design problems--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <li>--%>
<%--                                        <a href="#">--%>
<%--                                            <i class="fa fa-users text-red"></i> 5 new members joined--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <li>--%>
<%--                                        <a href="#">--%>
<%--                                            <i class="fa fa-shopping-cart text-green"></i> 25 sales made--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <li>--%>
<%--                                        <a href="#">--%>
<%--                                            <i class="fa fa-user text-red"></i> You changed your username--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                </ul>--%>
<%--                            </li>--%>
<%--                            <li class="footer"><a href="#">View all</a></li>--%>
<%--                        </ul>--%>
<%--                    </li>--%>
<%--                    <!-- Tasks: style can be found in dropdown.less -->--%>
<%--                    <li class="dropdown tasks-menu">--%>
<%--                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">--%>
<%--                            <i class="fa fa-flag-o"></i>--%>
<%--                            <span class="label label-danger">9</span>--%>
<%--                        </a>--%>
<%--                        <ul class="dropdown-menu">--%>
<%--                            <li class="header">你有9个新任务</li>--%>
<%--                            <li>--%>
<%--                                <!-- inner menu: contains the actual data -->--%>
<%--                                <ul class="menu">--%>
<%--                                    <li>--%>
<%--                                        <!-- Task item -->--%>
<%--                                        <a href="#">--%>
<%--                                            <h3>--%>
<%--                                                Design some buttons--%>
<%--                                                <small class="pull-right">20%</small>--%>
<%--                                            </h3>--%>
<%--                                            <div class="progress xs">--%>
<%--                                                <div class="progress-bar progress-bar-aqua" style="width: 20%"--%>
<%--                                                     role="progressbar" aria-valuenow="20" aria-valuemin="0"--%>
<%--                                                     aria-valuemax="100">--%>
<%--                                                    <span class="sr-only">20% Complete</span>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <!-- end task item -->--%>
<%--                                    <li>--%>
<%--                                        <!-- Task item -->--%>
<%--                                        <a href="#">--%>
<%--                                            <h3>--%>
<%--                                                Create a nice theme--%>
<%--                                                <small class="pull-right">40%</small>--%>
<%--                                            </h3>--%>
<%--                                            <div class="progress xs">--%>
<%--                                                <div class="progress-bar progress-bar-green" style="width: 40%"--%>
<%--                                                     role="progressbar" aria-valuenow="20" aria-valuemin="0"--%>
<%--                                                     aria-valuemax="100">--%>
<%--                                                    <span class="sr-only">40% Complete</span>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <!-- end task item -->--%>
<%--                                    <li>--%>
<%--                                        <!-- Task item -->--%>
<%--                                        <a href="#">--%>
<%--                                            <h3>--%>
<%--                                                Some task I need to do--%>
<%--                                                <small class="pull-right">60%</small>--%>
<%--                                            </h3>--%>
<%--                                            <div class="progress xs">--%>
<%--                                                <div class="progress-bar progress-bar-red" style="width: 60%"--%>
<%--                                                     role="progressbar" aria-valuenow="20" aria-valuemin="0"--%>
<%--                                                     aria-valuemax="100">--%>
<%--                                                    <span class="sr-only">60% Complete</span>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <!-- end task item -->--%>
<%--                                    <li>--%>
<%--                                        <!-- Task item -->--%>
<%--                                        <a href="#">--%>
<%--                                            <h3>--%>
<%--                                                Make beautiful transitions--%>
<%--                                                <small class="pull-right">80%</small>--%>
<%--                                            </h3>--%>
<%--                                            <div class="progress xs">--%>
<%--                                                <div class="progress-bar progress-bar-yellow" style="width: 80%"--%>
<%--                                                     role="progressbar" aria-valuenow="20" aria-valuemin="0"--%>
<%--                                                     aria-valuemax="100">--%>
<%--                                                    <span class="sr-only">80% Complete</span>--%>
<%--                                                </div>--%>
<%--                                            </div>--%>
<%--                                        </a>--%>
<%--                                    </li>--%>
<%--                                    <!-- end task item -->--%>
<%--                                </ul>--%>
<%--                            </li>--%>
<%--                            <li class="footer">--%>
<%--                                <a href="#">View all tasks</a>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </li>--%>
<%--                    <!-- User Account: style can be found in dropdown.less -->--%>
<%--                    <li class="dropdown user user-menu">--%>
<%--                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">--%>
<%--                            <span class="hidden-xs">登录</span>--%>
<%--                        </a>--%>
<%--                        <ul class="dropdown-menu">--%>
<%--                            <!-- Menu Footer-->--%>
<%--                            <li class="user-footer">--%>
<%--                                <div class="pull-left">--%>
<%--                                    <a href="loginPosition" class="btn btn-default btn-flat">登录</a>--%>
<%--                                </div>--%>
<%--                                <div class="pull-right">--%>
<%--                                    <a href="registerPosition" class="btn btn-default btn-flat">注册</a>--%>
<%--                                </div>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
<%--                    </li>--%>
<%--                </ul>--%>
<%--            </div>--%>
<%--        </nav>--%>
<%--    </header>--%>
<%--    <!-- 页面头部 /-->--%>

<%--    <!-- 导航侧栏 -->--%>
<%--    <aside class="main-sidebar">--%>
<%--        <!-- sidebar: style can be found in sidebar.less -->--%>
<%--        <section class="sidebar">--%>
<%--            <!-- Sidebar user panel -->--%>
<%--            <ul class="sidebar-menu">--%>
<%--                <li class="header">菜单</li>--%>

<%--                <li id="admin-index"><a href=""><i class="fa fa-dashboard"></i> <span>首页</span></a></li>--%>
<%--                <!-- 菜单 -->--%>
<%--                <li class="treeview">--%>
<%--                    <a href="#">--%>
<%--                        <i class="fa fa-folder"></i> <span>用户</span>--%>
<%--                        <span class="pull-right-container">--%>
<%--                        <i class="fa fa-angle-left pull-right"></i>--%>
<%--                    </span>--%>
<%--                    </a>--%>
<%--                    <ul class="treeview-menu">--%>

<%--                        <li id="admin-login">--%>
<%--                            <a href="loginPosition">--%>
<%--                                <i class="fa fa-circle-o"></i> 登录--%>
<%--                            </a>--%>
<%--                        </li>--%>

<%--                        <li id="admin-register">--%>
<%--                            <a href="registerPosition">--%>
<%--                                <i class="fa fa-circle-o"></i> 注册--%>
<%--                            </a>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
<%--                </li>--%>
<%--                <li class="treeview">--%>
<%--                    <a href="#">--%>
<%--                        <i class="fa fa-folder"></i> <span>新闻</span>--%>
<%--                        <span class="pull-right-container">--%>
<%--                        <i class="fa fa-angle-left pull-right"></i>--%>
<%--                    </span>--%>
<%--                    </a>--%>
<%--                </li>--%>
<%--            </ul>--%>
<%--        </section>--%>
<%--        <!-- /.sidebar -->--%>
<%--    </aside>--%>
<%--    <!-- 导航侧栏 /-->--%>

<%--    <!-- 内容区域 -->--%>
<%--    <div class="content-wrapper">--%>

<%--        <!-- 内容头部 -->--%>
<%--        <section class="content-header">--%>
<%--            <h1>--%>
<%--                <small>首页</small>--%>
<%--            </h1>--%>
<%--            <ol class="breadcrumb">--%>
<%--                <li><a href="skip/skip.jsp"><i class="fa fa-dashboard"></i> 首页</a></li>--%>
<%--            </ol>--%>
<%--        </section>--%>
<%--        <!-- 内容头部 /-->--%>

<%--        <!-- 正文区域 -->--%>
<%--        <section class="content">--%>

<%--            <div class="row">--%>
<%--                <div class="col-md-6">--%>
<%--                    <!-- Box Comment -->--%>
<%--                    <div class="box box-widget">--%>
<%--                        <div class="box-header with-border">--%>
<%--                            <div class="user-block">--%>
<%--                                <img class="img-circle" src="<%=basePath%>static/img/user1-128x128.jpg"--%>
<%--                                     alt="User Image">--%>
<%--                                <span class="username"><a href="#">Jonathan Burke Jr.</a></span>--%>
<%--                                <span class="description">Shared publicly - 7:30 PM Today</span>--%>
<%--                            </div>--%>
<%--                            <!-- /.user-block -->--%>
<%--                            <div class="box-tools">--%>
<%--                                <button type="button" class="btn btn-box-tool" data-toggle="tooltip"--%>
<%--                                        title="Mark as read">--%>
<%--                                    <i class="fa fa-circle-o"></i></button>--%>
<%--                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i--%>
<%--                                        class="fa fa-minus"></i>--%>
<%--                                </button>--%>
<%--                                <button type="button" class="btn btn-box-tool" data-widget="remove"><i--%>
<%--                                        class="fa fa-times"></i></button>--%>
<%--                            </div>--%>
<%--                            <!-- /.box-tools -->--%>
<%--                        </div>--%>
<%--                        <!-- /.box-header -->--%>
<%--                        <div class="box-body">--%>
<%--                            <!-- post text -->--%>
<%--                            <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia,--%>
<%--                                there live the blind texts. Separated they live in Bookmarksgrove right at</p>--%>

<%--                            <p>the coast of the Semantics, a large language ocean. A small river named Duden flows by--%>
<%--                                their place and supplies it with the necessary regelialia. It is a paradisematic--%>
<%--                                country, in which roasted parts of sentences fly into your mouth.</p>--%>

<%--                            <!-- Attachment -->--%>
<%--                            <div class="attachment-block clearfix">--%>
<%--                                <img class="attachment-img" src="<%=basePath%>static/img/photo1.png"--%>
<%--                                     alt="Attachment Image">--%>

<%--                                <div class="attachment-pushed">--%>
<%--                                    <h4 class="attachment-heading"><a href="http://www.lipsum.com/">Lorem ipsum text--%>
<%--                                        generator</a></h4>--%>

<%--                                    <div class="attachment-text">--%>
<%--                                        Description about the attachment can be placed here. Lorem Ipsum is simply dummy--%>
<%--                                        text of the printing and typesetting industry... <a href="#">more</a>--%>
<%--                                    </div>--%>
<%--                                    <!-- /.attachment-text -->--%>
<%--                                </div>--%>
<%--                                <!-- /.attachment-pushed -->--%>
<%--                            </div>--%>
<%--                            <!-- /.attachment-block -->--%>

<%--                            <!-- Social sharing buttons -->--%>
<%--                            <button type="button" class="btn btn-default btn-xs"><i class="fa fa-share"></i> Share--%>
<%--                            </button>--%>
<%--                            <button type="button" class="btn btn-default btn-xs"><i class="fa fa-thumbs-o-up"></i> Like--%>
<%--                            </button>--%>
<%--                            <span class="pull-right text-muted">45 likes - 2 comments</span>--%>
<%--                        </div>--%>
<%--                        <!-- /.box-body -->--%>
<%--                        <div class="box-footer box-comments">--%>
<%--                            <div class="box-comment">--%>
<%--                                <!-- User image -->--%>
<%--                                <img class="img-circle img-sm" src="<%=basePath%>static/img/user3-128x128.jpg"--%>
<%--                                     alt="User Image">--%>

<%--                                <div class="comment-text">--%>
<%--                                <span class="username">--%>
<%--                        Maria Gonzales--%>
<%--                        <span class="text-muted pull-right">8:03 PM Today</span>--%>
<%--                                </span>--%>
<%--                                    <!-- /.username -->--%>
<%--                                    It is a long established fact that a reader will be distracted by the readable--%>
<%--                                    content of a page when looking at its layout.--%>
<%--                                </div>--%>
<%--                                <!-- /.comment-text -->--%>
<%--                            </div>--%>
<%--                            <!-- /.box-comment -->--%>
<%--                            <div class="box-comment">--%>
<%--                                <!-- User image -->--%>
<%--                                <img class="img-circle img-sm" src="<%=basePath%>static/img/user5-128x128.jpg"--%>
<%--                                     alt="User Image">--%>

<%--                                <div class="comment-text">--%>
<%--                                <span class="username">--%>
<%--                        Nora Havisham--%>
<%--                        <span class="text-muted pull-right">8:03 PM Today</span>--%>
<%--                                </span>--%>
<%--                                    <!-- /.username -->--%>
<%--                                    The point of using Lorem Ipsum is that it has a more-or-less normal distribution of--%>
<%--                                    letters, as opposed to using 'Content here, content here', making it look like--%>
<%--                                    readable English.--%>
<%--                                </div>--%>
<%--                                <!-- /.comment-text -->--%>
<%--                            </div>--%>
<%--                            <!-- /.box-comment -->--%>
<%--                        </div>--%>
<%--                        <!-- /.box-footer -->--%>
<%--                        <div class="box-footer">--%>
<%--                            <form action="#" method="post">--%>
<%--                                <img class="img-responsive img-circle img-sm"--%>
<%--                                     src="<%=basePath%>static/img/user4-128x128.jpg" alt="Alt Text">--%>
<%--                                <!-- .img-push is used to add margin to elements next to floating images -->--%>
<%--                                <div class="img-push">--%>
<%--                                    <input type="text" class="form-control input-sm"--%>
<%--                                           placeholder="Press enter to post comment">--%>
<%--                                </div>--%>
<%--                            </form>--%>
<%--                        </div>--%>
<%--                        <!-- /.box-footer -->--%>
<%--                    </div>--%>
<%--                    <!-- /.box -->--%>
<%--                </div>--%>
<%--                <!-- /.col -->--%>
<%--            </div>--%>
<%--            <!-- /.row -->--%>


<%--        </section>--%>
<%--        <!-- 正文区域 /-->--%>

<%--    </div>--%>
<%--    <!-- 内容区域 /-->--%>

<%--    <!-- 底部导航 -->--%>
<%--    <footer class="main-footer">--%>
<%--        <div class="pull-right hidden-xs">--%>
<%--            <b>Version</b> 1.0.8--%>
<%--        </div>--%>
<%--        <strong>Copyright &copy; 2014-2017 <a href="http://www.itcast.cn">研究院研发部</a>.</strong> All rights reserved.--%>
<%--    </footer>--%>
<%--    <!-- 底部导航 /-->--%>

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
</body>

</html>
<!---->