<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 导航侧栏 -->
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="header">菜单</li>

            <li id="admin-index"><a href="indexTeacher"><i class="fa fa-dashboard"></i> <span>首页</span></a></li>
            <!-- 菜单 -->
            <%--删除新闻 修改新闻 添加新闻 推荐新闻 查找新闻--%>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-folder"></i> <span>新闻管理</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li>
                        <a href="viewNews?nowPage=1&updatePage=0&mark=2">
                            <i class="fa fa-circle-o"></i> 新闻列表
                        </a>
                    </li>
                    <li>
                        <a href="showAddNews">
                            <i class="fa fa-circle-o"></i> 添加新闻
                        </a>
                    </li>
                </ul>
            </li>
            <%--新闻管理--%>
            <%--学员管理--%>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-folder"></i> <span>学生管理</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li>
                        <a href="studentManagePermitIndex">
                            <i class="fa fa-circle-o"></i> 管理员
                        </a>
                    </li>
                </ul>
            </li>
            <%--学员管理--%>
            <%--课程管理--%>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-folder"></i> <span>课程管理</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <%--添加课程 删除课程 修改课程 搜索课程 推荐课程--%>
                <ul class="treeview-menu">
                    <li>
                        <a href="indexCourse">
                            <i class="fa fa-circle-o"></i> 课程主页
                        </a>
                    </li>
<%--                    <li>--%>
<%--                        <a href="addCourse">--%>
<%--                            <i class="fa fa-circle-o"></i> 添加课程--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                    <li>--%>
<%--                        <a href="">--%>
<%--                            <i class="fa fa-circle-o"></i> 删除课程--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                    <li>--%>
<%--                        <a href="">--%>
<%--                            <i class="fa fa-circle-o"></i> 修改课程--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                    <li>--%>
<%--                        <a href="">--%>
<%--                            <i class="fa fa-circle-o"></i> 推荐课程--%>
<%--                        </a>--%>
<%--                    </li>--%>
                </ul>
            </li>
            <%--课程管理--%>
            <%--论坛问答--%>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-folder"></i> <span>论坛问答</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li>
                        <a href="indexForum">
                            <i class="fa fa-circle-o"></i> 进入论坛
                        </a>
                    </li>
                </ul>
            </li>
            <%--论坛问答--%>
            <%--学生自学多媒体--%>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-folder"></i> <span>学生自学多媒体</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <%--添加课程 删除课程 修改课程 搜索课程 推荐课程--%>
                <ul class="treeview-menu">
                    <li>
                        <a href="forwardToMultimedia">
                            <i class="fa fa-circle-o"></i> 音乐基础理论知识
                        </a>
                    </li>
                    <li>
                        <a href="viewListen">
                            <i class="fa fa-circle-o"></i> 音乐鉴赏
                        </a>
                    </li>
                </ul>
            </li>
            <%--学生自学多媒体--%>
            <%--学生考核--%>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-folder"></i> <span>学生考核</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li>
                        <a href="previousWork">
                            <i class="fa fa-circle-o"></i> 往期作业
                        </a>
                    </li>
                    <li>
                        <a href="addWork">
                            <i class="fa fa-circle-o"></i> 新增作业
                        </a>
                    </li>
                </ul>
            </li>
            <%--学生考核--%>
            <%--全局设置--%>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-folder"></i> <span>全局设置</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li>
                        <a href="webSettingPermitIndex">
                            <i class="fa fa-circle-o"></i> 管理员
                        </a>
                    </li>
                </ul>
            </li>
            <%--全局设置--%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>