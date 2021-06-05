<%@include file="../../pages/web-url.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>

<script>

    //判断新闻类型决定导航active
    window.onload = function(){
        let mark = ${mark}
        if( mark == 2 ){
            document.getElementById("nav1").className="active"
        }else if( mark == 1){
            document.getElementById("nav2").className="active"
        }else if( mark == 0){
            document.getElementById("nav3").className="active"
        }

        /*分页判断是否为最后一页并跳页*/
        $('#downPage').click(function () {
            let nowPage = ${nowPage};
            let totalPages = ${totalPage}

            if (nowPage < totalPages) {
                window.location.href = "viewNews?nowPage=${nowPage}&updatePage=1&mark=${mark}"
            } else
                AstNotif.notify('已是最后一页！');

        })

        /*判断是否为第一页并跳页*/
        $('#upPage').click(function () {
            let nowPage = ${nowPage};
            let totalPages = ${totalPage}

            if (nowPage > 1) {
                window.location.href = "viewNews?nowPage=${nowPage}&updatePage=-1&mark=${mark}"
            } else
                AstNotif.notify('已是第一页！');
        })

    }







</script>

<div class="content-wrapper">
    <!-- 内容头部 -->
    <section class="content-header">
        <h1>
            ${sessionScope.sName}
            <small>(学生)</small>
        </h1>
    </section>

    <section class="content">
        <div class="nav-tabs-custom">
            <div class="tab-content">
                <div class="active tab-pane" id="activity">
                    <div style="float:right;font-size:25px ">*表示推荐新闻</div>
                    <label style="color: #0d6aad;"><h4>新闻列表</h4></label>
                    <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                    <br>


                    <div class="row" >
                        <%--分类查看新闻选项--%>
                        <div class="col-xs-6">
                            <c:choose>
                                <%--查询新闻后将此处改为返回按钮--%>
                                <c:when test="${mark == 3}">
                                    <a  href="viewNews?nowPage=1&updatePage=0&mark=2" class="btn btn-default" >返回</a>
                                </c:when>
                                <c:otherwise>
                                    <ul class="nav nav-tabs">
                                        <li role="presentation" id="nav1"><a href="viewNews?nowPage=1&updatePage=0&mark=2">所有</a></li>
                                        <li role="presentation" id="nav2"><a href="viewNews?nowPage=1&updatePage=0&mark=1">推荐</a></li>
                                        <li role="presentation" id="nav3"><a href="viewNews?nowPage=1&updatePage=0&mark=0">其他</a></li>
                                    </ul>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <%--标题搜索功能--%>
                        <div class="col-xs-offset-6">
                            <form action="selectNew" method="get" class="navbar-form navbar-left">
                                <div class="form-group" >
                                    <input type="text"  class="form-control" placeholder="标题搜索" name="title" id="title">
                                </div>
                                <button type="submit"  class="btn btn-default" >搜索一下</button>
                            </form>
                        </div>
                    </div>
                </div>

                    <%--新闻展示--%>
                    <c:forEach items="${news}" var="news" varStatus="status">
                        <div class="panel panel-default">
                            <div class="panel-body" style="">
                                <%--展示标题--%>
                                    <%--对标记新闻进行特别注释--%>
                                    <div style="float: left;margin-right: 10px">&nbsp;<c:if test="${news.newMark == 1}">*</c:if></div>
                                <a href="newsDetail?newTitle=${news.newTitle}" >${news.newTitle} </a>

                                <%--展示发布时间--%>
                                <span style="font-size: 10px;
                                color:#8a8a8a;
                                float:right;
                                position: relative;
                                right: 10px;top : 10px;">发布时间:${news.upDate}</span>

                            </div>
                        </div>
                    </c:forEach>
                    <%--分页--%>
                <c:if test="${mark != 3}">  <%--若搜索新闻则不显示--%>
                    <ul class="pagination pagination-sm inline" id="publishedPages">
                        <li id='totalPages'><a>共${totalPage}页</a></li>
                        <li><a href="viewNews?nowPage=1&updatePage=0&mark=${mark}">首页</a></li>
                        <li><a>第</a></li>
                        <li><a id="upPage" >&laquo;</a></li>     <%--左箭头--%>
                        <li><a> ${nowPage} </a></li>
                        <li><a id="downPage" >&raquo;</a></li>               <%--右箭头--%>
                        <li><a>页</a></li>
                        <li><a href="viewNews?nowPage=${totalPage}&updatePage=0&mark=${mark}">尾页</a></li>
                    </ul>
                </c:if>


                    <hr/>
                    <!-- Post -->
                    <div id="thisContent">
                        <%--<div class="post">
                            <div>
                                <span class="username">
                                <a style="font-size: 20px;" href="">

                                </a>
                                </span>
                                <br/>
                                <span class="description col-sm-12" style="font-size: 10px;color: #8a8a8a">发布时间：</span>
                            </div>
                            <p>

                            </p>
                        </div>--%>
                    </div>
                </div>
            </div>
    </section>
</div>


