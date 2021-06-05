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

            //Tab键排版
            $("textarea").on(
                'keydown',
                function (e) {
                    if (e.keyCode == 9) {
                        e.preventDefault();
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
                    ajaxShowForumTitle('showQueIdByCid')
                }
            })
        }
        var indexBig = 1;
        var pageSizeBig = 5;
        var totalPages = 0;
        var nowPage = 1;

        function ajaxShowForumTitle(strFlag) {
            var courseId = $('#selected').val()
            //console.log(courseId)
            var findStr = $("input[name='doSearch']").val()
            //console.log(strFlag)
            var response
            $.ajax({
                url: strFlag,
                //url: 'showQueIdByCid',
                data: {
                    cId: courseId,
                    find:findStr,
                    index: indexBig,
                    pageSize: pageSizeBig
                },
                dataType: 'json',
                type: 'post',
                success: function (responseBig) {
                    for (var k in responseBig) {
                        totalPages = k
                        response = responseBig[k]
                    }
                    $('#thisContent').empty()
                    $.each(response, function (i, res) {
                        $.ajax({
                            url: 'showQuestion',
                            type: 'post',
                            dataType: 'json',
                            data: {
                                cId: courseId,
                                qId: res,
                                indexAnswer: 0,
                                answerPageSize: 0
                            },
                            success: function (resp) {
                                $.each(resp, function (i, res) {
                                    $('#thisContent').append("<div>\n" +
                                        "                            <div>\n" +
                                        "                                <span>\n" +
                                        "                                <a style=\"font-size: 20px;\" href=\"showQuestionDetail?cId=" + res.courseId + "&queId=" + res.queId + "\">\n" +
                                        "                                 " + res.context + "   \n" +
                                        "                                </a>\n" +
                                        "                                </span>\n" +
                                        "                                <br/>\n" +
                                        "                            </div>\n" +
                                        "                            <p>\n")
                                    if (res.forumAnswer.length !== 0) {
                                        $.each(res.forumAnswer, function (j, answer) {
                                            $('#thisContent').append(
                                                "<span style='font-size: 10px'>" + answer.name + "：" + answer.answer + "......  </span>\n" +
                                                "<span style=\"font-size: 10px;color: #8a8a8a\"><p class='text-right'><br/>" + res.name + "：" + "发布时间：" + res.upDate + "</p></span>\n" +
                                                "</p>\n" +
                                                "</div>")
                                        })
                                    } else {
                                        $('#thisContent').append(
                                            "   <span style='font-size: 10px'>暂无讨论</span>\n" +
                                            "                                <span style=\"font-size: 10px;color: #8a8a8a\"><p class='text-right'><br/>" + res.name + "：" + "发布时间：" + res.upDate + "</p></span>\n" +
                                            "                            </p>\n" +
                                            "                        </div>")
                                    }
                                    $('#thisContent').append("<hr/>")
                                })
                            }
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
                            indexBig = 1;
                            ajaxShowForumTitle(strFlag)
                        }
                    })
                    $('#downPage').on('click', function () {
                        if (nowPage < totalPages) {
                            nowPage = nowPage + 1;
                            indexBig++;
                            ajaxShowForumTitle(strFlag)
                        } else
                            AstNotif.notify('已是最后一页！');
                    })
                    $('#upPage').on('click', function () {
                        if (nowPage > 1) {
                            nowPage = nowPage - 1;
                            indexBig--;
                            ajaxShowForumTitle(strFlag)
                        } else
                            AstNotif.notify('已是第一页！')
                    })
                    $('#lastPage').on('click', function () {
                        if (nowPage == totalPages) {
                            AstNotif.notify('已是最后一页')
                        } else {
                            nowPage = totalPages
                            indexBig = totalPages;
                            ajaxShowForumTitle(strFlag)
                        }
                    })

                }
            })
        }

        function ajaxSubmitQuestion() {
            var textArea = $('textarea').val()
            var cId = $('#selected').val()
            if(textArea !== ''){
                $.ajax({
                    url:'submitQuestion',
                    type:'post',
                    data:{
                        courseId:cId,
                        name:'${sessionScope.sName}',
                        context:textArea
                    },
                    dataType:'text',
                    success:function (resp) {
                        alert(resp+"两秒后跳转..")
                        setTimeout(function () {
                            //方法体
                            $(location).attr('href', '')
                        },2000)
                    }
                })
            }else
                alert('输入提问内容！')
        }
    </script>
    <style>
        a:hover {
            color: #c800ff
        }
    </style>
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
            <ul class="nav nav-tabs">
                <li class="active"><a href="#activity" data-toggle="tab">教师论坛</a></li>
            </ul>

            <div class="tab-content">
                <div class="active tab-pane" id="activity">
                    <div class="form-group">
                        <label style="color: #0d6aad"><h4>选择课程</h4></label>
                        <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                        <select class="form-control" style="width:300px;height:35px;font-size:16px;" id="selected"
                                onchange="ajaxShowForumTitle('showQueIdByCid')">
                        </select>
                        <br>
                        <div class="row">
                            <form class="navbar-form navbar-left">
                                <div class="form-group">
                                    <input type="text" class="form-control" placeholder="标题搜索" name="doSearch">
                                </div>
                                <button type="button" class="btn btn-default" onclick="ajaxShowForumTitle('findQueIdByCid')">搜索一下</button>
                            </form>
                        </div>
                        <div class="row" style="padding: 15px">
                            <div >
                                <button class="btn btn-facebook" data-toggle='modal' data-target='#myModal'><h5>
                                    我要提问</h5></button>
                            </div>
                            <br/>
                            <!-- 模态框（Modal） -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                                 aria-labelledby="myModalLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <div align="center">
                                                <h4>提问</h4>
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
                                                <button class="btn btn-default" onclick="ajaxSubmitQuestion()">提交
                                                </button>
                                            </div>
                                        </section>
                                    </div><!-- /.modal-content -->
                                </div><!-- /.modal -->
                            </div>
                            <ul class="pagination pagination-sm inline" id="publishedPages">

                            </ul>
                        </div>
                    </div>
                    <hr/>
                    <!-- Post -->
                    <div id="thisContent">
                        <div class="post">
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

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
</div>
</body>
</html>
