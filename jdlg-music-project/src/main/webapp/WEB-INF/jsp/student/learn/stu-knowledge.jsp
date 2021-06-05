<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>
<html>
<head>

    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>static/plugins/base64/base64.js"></script>

    <script>
        $(function () {
            ajaxShowCourses()
        })
        function ajaxShowCourses() {
            $.ajax({
                url: "showCourse",
                type: "post",
                success: function (rep) {
                    courses = rep
                    $.each(rep, function (i, res) {
                        //alert(res.courseName)
                        $("#selected").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                    })
                    ajaxShowKnowledge()
                }
            })
        }

        var nowPage = 1;
        var totalPages = 0;

        function ajaxShowKnowledge(index) {
            var cId = $('#selected').val()
            if (index == null) {
                index = 1;
            }
            $.ajax({
                url: 'showAllKnow',
                data: {
                    cId: cId,
                    index: index
                },
                dataType: 'json',
                type: 'get',
                async: false,
                success: function (rep) {
                    $('#thisContent').children().remove();
                    $.each(rep, function (i, res) {
                        if (res.courseId === -1) {
                            totalPages = res.id
                        } else {
                            $('#thisContent').append("<div class='post'>\n" +
                                "                        <div>\n" +
                                "                            <span class='username'><a style='font-size: 20px;color: #0c0c0c' >" + res.title + "</a></span>\n" +
                                "                            <br/>\n" +
                                "                            <span class='description' style='font-size: 10px;color: #8a8a8a' >发布时间：" + res.upTime + "</span>\n" +
                                "                        </div>\n" +
                                "                        <hr/>\n" +
                                "                        <p>\n" +
                                "                        " + res.context + "</p>\n" +
                                "                        <div class='row margin-bottom'>\n" +
                                "                            <div class='content'>\n" +
                                "                                <div style='width: 800px;' id='imgs" + i + "'>\n" +
                                "\n" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                        </div>\n" +
                                "                    </div>")
                            for (var j = 0; j < res.imgNumber; j++) {
                                $('#imgs' + i).append("<a onclick=\"window.open('showAllKnow?imgKnowId=" + res.id + "&imgId=" + j + "&imgCid=" + cId + "')\">" +
                                    "<img style='width:%30;padding: 2px' src='showAllKnow?imgKnowId=" + res.id + "&imgId=" + j + "&imgCid=" + cId + "' height='200'>\n" +
                                    "                </a>")
                            }
                        }
                    })


                }
            })
            $('#publishedPages').empty()
            $('#publishedPages').append("<li ><a id='totalPages'>共" + totalPages + "页</a></li>\n" +
                "                        <li><a id='firstPage'>首页</a></li>\n" +
                "                        <li><a>第</a></li>\n" +
                "                        <li><a id='upPage'>&laquo;</a></li>\n" +
                "                        <li><a>" + (nowPage) + "</a></li>\n" +
                "                        <li><a id='downPage'>&raquo;</a></li>\n" +
                "                        <li><a>页</a></li>\n" +
                "                        <li><a id='lastPage'>尾页</a></li>")
            $('#firstPage').on('click', function () {
                if (nowPage == 1) {
                    AstNotif.notify('已是第一页！')
                } else {
                    nowPage = 1;
                    ajaxShowKnowledge(1)
                }
            })
            $('#downPage').on('click', function () {
                if (nowPage < totalPages) {
                    nowPage = nowPage + 1;
                    ajaxShowKnowledge(nowPage)
                } else
                    AstNotif.notify('已是最后一页！');
            })
            $('#upPage').on('click', function () {
                if (nowPage > 1) {
                    nowPage = nowPage - 1;
                    ajaxShowKnowledge(nowPage)
                } else
                    AstNotif.notify('已是第一页！')
            })
            $('#lastPage').on('click', function () {
                if (nowPage == totalPages) {
                    AstNotif.notify('已是最后一页')
                } else {
                    nowPage = totalPages
                    //console.log(totalPages)
                    ajaxShowKnowledge(totalPages)
                }
            })
            $('#results').empty()
        }

        function KnowSearch() {
            //alert("ok")
            var title = $("input[name='doSearch']").val()
            var cId = $('#selected').val()
            var totalResults = 0;
            $.ajax({
                url: 'studentKnowSearch',
                type: 'get',
                dataType: 'json',
                data: {
                    title: title,
                    cId: cId
                },
                success: function (resp) {
                    //console.log(resp)
                    $('#thisContent').empty();
                    $('#publishedPages').empty()

                    $('#publishedPages').append("<li><h3>搜索结果</h3></li>");
                    $.each(resp, function (i, res) {
                        totalResults++;
                        $('#thisContent').append("<div class='post'>\n" +
                            "                        <div>\n" +
                            "                            <span class='username'><a style='font-size: 20px;color: #0c0c0c' >" + res.title + "</a></span>\n" +
                            "                            <br/>\n" +
                            "                            <span class='description' style='font-size: 10px;color: #8a8a8a' >发布时间：" + res.upTime + "</span>\n" +
                            "                        </div>\n" +
                            "                        <hr/>\n" +
                            "                        <p>\n" +
                            "                        " + res.context + "</p>\n" +
                            "                        <div class='row margin-bottom'>\n" +
                            "                            <div class='content'>\n" +
                            "                                <div style='width: 800px;' id='imgsTwo" + i + "'>\n" +
                            "\n" +
                            "                                </div>\n" +
                            "                            </div>\n" +
                            "                        </div>\n" +
                            "                    </div>")
                        // 用法：先实例化
                        var base = new Base64();
                        // 加密
                        var searchTitle = base.encode(res.title);

                        console.log(searchTitle)
                        for (var j = 0; j < res.imgNumber; j++) {
                            $('#imgsTwo' + i).append("<a onclick=\"window.open('studentKnowSearch?titleName=" + searchTitle + "&imgCId=" + res.courseId + "&imgId=" + j + "')\">" +
                                "<img style='width:%30;padding: 2px' src='studentKnowSearch?titleName=" + searchTitle + "&imgCId=" + res.courseId + "&imgId=" + j + "' height='200'>\n" +
                                "                </a>")
                        }

                    })
                    $('#activity').append("<div id='results'><hr/>共" + totalResults + "条结果</div>")
                }
            })
        }
    </script>
</head>
<body>
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
            <div class="content" id="activity">
                <div class="form-group">
                    <label style="color: #0d6aad"><h4>选择课程</h4></label>
                    <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                    <select class="form-control" style="width:300px;height:35px;font-size:16px;" id="selected"
                            onchange="ajaxShowKnowledge()">
                    </select>
                    <br>
                    <div class="row">
                        <form class="navbar-form navbar-left">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="标题搜索" name="doSearch">
                            </div>
                            <button type="button" class="btn btn-default" onclick="KnowSearch()">搜索一下</button>
                        </form>
                    </div>
                    <div class="row" style="padding: 15px">
                        <ul class="pagination pagination-sm inline" id="publishedPages">
                        </ul>
                    </div>
                    <%--                        <div >1:<%=session.getAttribute("totalPages")%></div>--%>
                </div>
                <br>
                <!-- Post -->
                <div id="thisContent">
                    <%--                        <div class="post">--%>
                    <%--                            <div>--%>
                    <%--                                <span class="username"><a style="font-size: 20px;color: #0c0c0c">标题</a></span>--%>
                    <%--                                <br/>--%>
                    <%--                                <span class="description" style="font-size: 10px;color: #8a8a8a">发布时间：</span>--%>
                    <%--                            </div>--%>
                    <%--                            <hr/>--%>
                    <%--                            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
                    <%--                            </p>--%>
                    <%--                            <div class="row margin-bottom">--%>
                    <%--                                <div class="content">--%>
                    <%--                                    <div style="width: 650px;" id="imgs">--%>

                    <%--                                    </div>--%>
                    <%--                                </div>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                </div>
            </div>
        </div>

    </section>
</div>
</body>
</html>
