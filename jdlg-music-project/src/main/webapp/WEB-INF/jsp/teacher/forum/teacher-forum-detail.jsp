<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>
<html>
<head>

    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>static/plugins/base64/base64.js"></script>

    <script>
        $(function () {
            ajaxShowForumDetail()
            //Tab键排版
            $("textarea").on(
                'keydown',
                function (e) {
                    if (e.keyCode == 9) {
                        e.preventDefault();
                        //var indent = '       ';
                        var indent = '       ';
                        var start = this.selectionStart;
                        var end = this.selectionEnd;
                        var selected = window.getSelection().toString();
                        selected = indent + selected.replace(/\n/g, '\n' + indent);
                        this.value = this.value.substring(0, start) + selected
                            + this.value.substring(end);
                        this.setSelectionRange(start + indent.length, start
                            + selected.length);
                    }
                }
            )
        })

        var pageSize = 10;

        var commentCount = ${commentCount};
        var totalPages = 0;
        if (commentCount % 10 !== 0) {
             totalPages = parseInt(commentCount / pageSize) + 1
        }else
            totalPages = parseInt(commentCount / pageSize)

        var indexBig = 0;
        var nowPage = 1;

        function ajaxShowForumDetail() {
            var cId =
            ${param.cId}
            var queId =
            ${param.queId}
            if (cId != null && queId != null) {
                $.ajax({
                    url: 'questionDetail',
                    data: {
                        cId: cId,
                        queId: queId,
                        indexAnswer: indexBig,
                        answerPageSize: pageSize
                    },
                    dataType: 'json',
                    type: 'post',
                    success: function (resp) {
                        //console.log(resp)
                        $('#context').empty()
                        $('#answer').empty()
                        $.each(resp, function (i, resBig) {
                            $('#context').append(" <span style='font-size: 23px;color: #00091a'>" + resBig.context + "</span>\n" +
                                "                                <br/>\n" +
                                "                                <span style=\"font-size: 10px;color: #8a8a8a\"><p class=\"text-right\">--" + resBig.name + " 发布时间：" + resBig.upDate + "</p></span><hr/><br/><br/>")
                            $.each(resBig.forumAnswer, function (i, res) {
                                $('#answer').append("<h5 style='color: #0a6fbd;font-family: 华文行楷'>" + res.name + ":</h5><br/>" + res.answer + "<hr/></br>")
                            })
                        })
                        $('#publishedPages').empty()
                        $('#publishedPages').append("<li id='totalPages'><a>共" + totalPages + "页</a></li>\n" +
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
                                indexBig = 0;
                                ajaxShowForumDetail()
                            }
                        })
                        $('#downPage').on('click', function () {
                            if (nowPage < totalPages) {
                                nowPage = nowPage + 1;
                                indexBig += pageSize;
                                ajaxShowForumDetail()
                            } else
                                AstNotif.notify('已是最后一页！');
                        })
                        $('#upPage').on('click', function () {
                            if (nowPage > 1) {
                                nowPage = nowPage - 1;
                                indexBig -= pageSize;
                                ajaxShowForumDetail()
                            } else
                                AstNotif.notify('已是第一页！')
                        })
                        $('#lastPage').on('click', function () {
                            if (nowPage == totalPages) {
                                AstNotif.notify('已是最后一页')
                            } else {
                                nowPage = totalPages
                                indexBig = (totalPages - 1) * pageSize;//11-10 12-10 22-20 32-30
                                ajaxShowForumDetail()
                            }
                        })
                    }
                })
            } else {
                alert('系统出错！请退回页面重试')
            }
            <%--console.log("----------")--%>
            <%--console.log(${param.cId})--%>
            <%--console.log("总页数："+totalPages)--%>
            <%--console.log("----------")--%>
        }

        function ajaxSubmitComment() {
            var textArea = $('textarea').val()
            if (textArea !== '') {
                $.ajax({
                    url: 'submitComment',
                    type: 'post',
                    data: {
                        queId:${param.queId},
                        name: '${sessionScope.tName}',
                        answer: textArea
                    },
                    dataType: 'text',
                    success: function (resp) {
                        alert(resp + "两秒后跳转..")
                        setTimeout(function () {
                            //方法体
                            $(location).attr('href', '')
                        }, 2000)
                    }
                })
            } else
                alert('输入讨论内容！')
        }
    </script>
</head>
<body>
<div class="content-wrapper">
    <!-- 内容头部 -->
    <section class="content-header">
        <h1>
            ${sessionScope.tName}
            <small>(教师)</small>
        </h1>
    </section>

    <section class="content">
        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#activity" data-toggle="tab">教师论坛</a></li>
            </ul>

            <div class="tab-content">
                <div class="active tab-pane" id="activity">
                    <!-- Post -->
                    <div id="thisContent">
                        <div class="post">

                            <div>
                                <p id="context">
                                    <%--                                <span></span>--%>
                                    <%--                                <br/>--%>
                                    <%--                                <span style="font-size: 10px;color: #8a8a8a"><p class="text-right">发布时间：</p></span>--%>
                                </p>
                                <div align="center">
                                    <button class="btn btn-success" data-toggle='modal' data-target='#myModal'><h4>
                                        参与讨论</h4></button>
                                </div>
                            </div>
                            <p id="answer">
                            </p>
                            <div class="row" style="padding: 15px">
                                <ul class="pagination pagination-sm inline" id="publishedPages">

                                </ul>
                            </div>
                        </div>
                        <!-- 模态框（Modal） -->
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                             aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <div align="center">
                                            <h4>参与讨论</h4>
                                        </div>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                    </div>
                                    <section class="content">
                                        <textarea class="textarea" placeholder="输入..."
                                                  style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"
                                                  name="textArea"></textarea>
                                        <hr/>
                                        <div class="text-right">
                                            <button class="btn btn-default" onclick="ajaxSubmitComment()">提交</button>
                                        </div>
                                    </section>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
</div>
</body>
</html>
