<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="header">菜单</li>

            <li id="admin-index"><a href="indexStudent"><i class="fa fa-dashboard"></i> <span>首页</span></a></li>
            <!-- 菜单 -->
<%--            <li class="treeview">--%>
<%--                <a href="#">--%>
<%--                    <i class="fa fa-folder"></i> <span>用户</span>--%>
<%--                    <span class="pull-right-container">--%>
<%--                        <i class="fa fa-angle-left pull-right"></i>--%>
<%--                    </span>--%>
<%--                </a>--%>
<%--                <ul class="treeview-menu">--%>
<%--                    <li>--%>
<%--                        <a href="">--%>
<%--                            <i class="fa fa-circle-o"></i> 个人中心--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                </ul>--%>
<%--            </li>--%>
            <%--学习 提问 课程 考核 --%>
            <%--新闻--%>
            <li class="treeview">
                <a href="viewNews?nowPage=1&updatePage=0&mark=2">
                    <i class="fa fa-folder"></i> <span>网站新闻</span>
                </a>
            </li>
            <%--新闻--%>

            <%--学习--%>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-folder"></i> <span>多媒体学习</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li>
                        <a href="learnBasicKnow">
                            <i class="fa fa-circle-o"></i> 音乐基础理论知识
                        </a>
                    </li>
                    <li>
                        <a href="viewListenStu">
                            <i class="fa fa-circle-o"></i> 音乐鉴赏
                        </a>
                    </li>
                </ul>
            </li>
            <%--学习--%>

            <%--提问--%>
            <li class="treeview">
                <a href="indexForum">
                    <i class="fa fa-folder"></i> <span>论坛问答</span>
                </a>
            </li>
            <%--提问--%>

            <%--课程--%>
            <li class="treeview">
                <a href="indexCourse">
                    <i class="fa fa-folder"></i> <span>我的课程</span>
                </a>
            </li>
            <%--课程--%>

            <%--考核--%>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-folder"></i> <span>我的考核</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li>
                        <a href="showExamine">
                            <i class="fa fa-circle-o"></i> 新作业
                        </a>
                    </li>
                    <li>
                        <a href="showPrevious">
                            <i class="fa fa-circle-o"></i> 往期
                        </a>
                    </li>

                </ul>
            </li>
            <%--考核--%>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>