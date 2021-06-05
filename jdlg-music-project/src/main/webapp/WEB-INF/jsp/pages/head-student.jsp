<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Header Navbar: style can be found in header.less -->
<%@include file="../pages/web-url.jsp" %>

<%
    String unfinished = "";
    Integer flag = 0;
    Set<String> unDoCourse = (Set<String>) session.getAttribute("unDoCourse");
    if (session.getAttribute("sId") != null) {
        //unfinished = String.valueOf((Integer)session.getAttribute("unfinished"));
        if (unDoCourse != null) {
            flag = unDoCourse.size();
        }
    }
    if (flag != 0) {
        unfinished = String.valueOf(flag);
    }
    String userName = "";
    Object obj = session.getAttribute("sName");
    if (obj != null) {
        userName = (String) obj;
    }

%>
<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>

<script>
    function x() {
        confirm({
            title: '确认退出登录',
            content: '',
            doneText: '确认',
            cancelText: '取消'
        }).then(() => {
            //换个账号
            //console.log('已确认')
            $(location).attr('href', 'loginOut')
        }).catch(() => {
            //退出
            //console.log('已取消')
            //$(location).attr('href','loginOut')
        })
    }

    // $(function () {
    //     $('#dropMenu').empty()
    //     $('#dropMenu').append("<li class='header'>\n" +
    //         "</li>\n" +
    //         "<li>\n" +
    //         "    <ul class='menu'>\n" +
    //         "        <li>\n" +
    //         "            <a href='showExamine'>\n" +
    //         "                <i class='fa fa-edit text-aqua'></i>\n" +
    //         "            </a>\n" +
    //         "        </li>\n" +
    //         "        <li>\n" +
    //         "            <a href='showExamine'>\n" +
    //         "                <i class='fa fa-edit text-aqua'></i>\n" +
    //         "            </a>\n" +
    //         "        </li>\n" +
    //         "    </ul>\n" +
    //         "</li>")
    // })
</script>

<nav class="navbar navbar-static-top">
    <!-- Sidebar toggle button-->
    <a href="" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
    </a>

    <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
            <!-- Notifications: style can be found in dropdown.less -->
            <li class="dropdown notifications-menu">
                <a class="dropdown-toggle" data-toggle="dropdown">
                    <i class="fa fa-bell-o"></i>
                    <span class="label label-warning"><%=unfinished%></span>
                </a>
                <ul class="dropdown-menu" id="dropMenu">
                    <li class="header">
                        <%
                            if (unfinished == "") {
                                out.print("居然没有作业！");
                            } else
                                out.print("你有" + unfinished + "个新消息");
                        %>
                    </li>
                    <li>
                        <!-- inner menu: contains the actual data -->
                        <ul class="menu">
                            <%
                                if (unDoCourse != null) {
                                    for (String s : unDoCourse) {
                            %>
                            <li>
                                <a href="showExamine">
                                    <i class="fa fa-edit text-aqua"></i>课程：<%=s%>有作业未完成
                                </a>
                            </li>
                            <%
                                }
                            } else {
                            %>
                            <li>
                                <a href="showExamine">
                                    <i class="fa fa-edit text-aqua"></i>暂无新消息
                                </a>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </li>
                </ul>
            </li>
            <!-- User Account: style can be found in dropdown.less -->
            <li class="dropdown user user-menu">
                <a onclick="x()" class="dropdown-toggle" data-toggle="dropdown">
                    <img src="<%=basePath%>static/img/avatar5.png" class="user-image" alt="User Image">
                    <span class="hidden-xs"><%=userName%></span>
                </a>
                <%--                <ul class="dropdown-menu">--%>
                <%--                    <!-- Menu Footer-->--%>
                <%--                    <li class="user-footer">--%>
                <%--                        <div class="pull-left">--%>
                <%--                            <a href="<%=basePath%>loginPosition" class="btn btn-default btn-flat">换个账号</a>--%>
                <%--                        </div>--%>
                <%--                        <div class="pull-right"><a href="loginOut" class="btn btn-default btn-flat">退出</a>--%>
                <%--                        </div>--%>
                <%--                    </li>--%>
                <%--                </ul>--%>
            </li>
        </ul>
    </div>
</nav>
