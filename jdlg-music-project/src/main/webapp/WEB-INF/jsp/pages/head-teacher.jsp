<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            $(location).attr('href','loginOut')
        }).catch(() => {
            //退出
            //console.log('已取消')
            //$(location).attr('href','loginOut')
        })
    }
</script>
<nav class="navbar navbar-static-top">
    <!-- Sidebar toggle button-->
    <a href="" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
    </a>
    <div class="navbar-custom-menu">
        <ul class="nav navbar-nav" id="myMenu">
            <li class="dropdown user user-menu">
                <a onclick="x()" class="dropdown-toggle" data-toggle="dropdown">
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