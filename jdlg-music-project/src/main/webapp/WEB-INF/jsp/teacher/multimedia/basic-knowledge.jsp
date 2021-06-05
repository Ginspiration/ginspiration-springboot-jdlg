<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../pages/web-url.jsp" %>
<html>
<head>

    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>static/plugins/base64/base64.js"></script>

    <script>
        //js文件上传对象
        var file = new FormData();
        $(function () {
            ajaxShowCourses()
            ajaxShowKnowledge()
            showDelete()
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


        function uploadFile() {
            //遍历所有文件
            for (var i = 0; i < $('#fileInput')[0].files.length; i++) {
                //最后出现'.'处的索引
                var index = $('#fileInput')[0].files[i].name.lastIndexOf(".");
                //往后截取
                //console.log($('#fileInput')[0].files[i].name.substring(index + 1));
                var fileName = $('#fileInput')[0].files[i].name.substring(index + 1);
                //console.log(fileName)
                if (fileName !== 'jpg' && fileName !== 'jpeg' && fileName !== 'png') {
                    alert("文件类型错误，重新上传.")
                    return;
                } else
                    file.append("files", $('#fileInput')[0].files[i])
            }
        }

        function check() {
            var title = $("input[name='title']").val();
            if ($('#fileInput').val() == '') {
                AstNotif.notify('请选择图片！');
                return false
            } else if (title == '') {
                AstNotif.notify('请输入标题！');
                return false
            } else if ($("textarea[name='context']").val() == '') {
                AstNotif.notify('请输入内容！');
                return false
            } else if (title.length >= 255) {
                AstNotif.notify('标题过长！');
                return false
            } else
                return true
        }

        function ajaxSubmitKnowledge() {
            if (check()) {
                //ajax进行特殊处理
                $.ajax({
                    url: 'uploadPhotoFile',
                    type: 'post',
                    data: file,
                    cache: false,
                    async: false,
                    //不处理数据
                    processData: false,
                    //不设置内容类型
                    contentType: false,
                    success: function (rep) {
                    }
                })
                var Title = $("input[name='title']").val();
                var Context = $("textarea[name='context']").val();
                var cId = $("#selected").val();
                //提交内容
                $.ajax({
                    url: 'addKnowledge',
                    type: 'post',
                    dataType: 'text',
                    data: {
                        title: Title,
                        context: Context,
                        cId: cId
                    },
                    success: function (rep) {
                        if (rep == '该标题已被添加，请换个标题。') {
                            $("input[name='title']").val('')
                            alert(rep)
                            return
                        } else {
                            alert(rep + "2秒后自动跳转")
                            setTimeout(function () {
                                $(location).attr('href', '<%=basePath%>doTeacher/forwardToMultimedia')
                            }, 2000)
                        }
                    }
                })
            }
        }

        function ajaxShowCourses() {
            $.ajax({
                url: "addWork/showCourses",
                type: "post",
                async: false,
                success: function (rep) {
                    $.each(rep, function (i, res) {
                        $("#selected").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                        $("#selected2").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                        $("#selected3").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                    })
                }
            })

        }

        var nowPage = 1;
        var totalPages = 0;

        function ajaxShowKnowledge(index) {
            var cId = $('#selected2').val()
            if (index == null) {
                index = 1;
            }
            $.ajax({
                url: 'showKnowledge',
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
                                $('#imgs' + i).append("<a onclick=\"window.open('showKnowledge?knowId=" + res.id + "&img=" + j + "&cId2=" + cId + "')\">" +
                                    "<img style='width:%30;padding: 2px' src='showKnowledge?knowId=" + res.id + "&img=" + j + "&cId2=" + cId + "' height='200'>\n" +
                                    "                </a>")
                            }
                        }
                    })


                }
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
        }

        function showDelete() {
            var selectedCId = $('#selected3').val()
            $.ajax({
                url: 'showDeleteKnow',
                type: 'post',
                dataType: 'json',
                data: {
                    cId: selectedCId
                },
                success: function (resp) {
                    $('#PreWorks1').children().remove()
                    $.each(resp, function (i, res) {
                        $("#PreWorks1").append("<li id='title" + i + "'>\n" +
                            "                        <span class='text'><button class='btn-success'>" + res.title + "</button></span>\n" +
                            "                        <span class='text'>" + res.context + "</span>\n" +
                            "                        <span class='text' style='font-size: 10px'>" + res.upTime + "</span>\n" +
                            "                        <div class='tools'>\n" +
                            "                            <button class='btn-danger' id='KnowDelete" + i + "'>删除</button>\n" +
                            "                        </div>\n" +
                            "                    </li>")
                        $('#KnowDelete' + i).on('click', function () {
                            deleteKnow(res.title, selectedCId, i)
                        })
                    })
                }
            })
        }

        function deleteKnow(title, cId, i) {
            $.ajax({
                url: 'doDeleteKnow',
                type: 'post',
                dataType: 'text',
                data: {
                    title: title,
                    cId: cId
                },
                success: function (resp) {
                    alert(resp)
                    $('#title' + i).remove()
                }
            })
        }

        function KnowSearch() {
            var title = $("input[name='doSearch']").val()
            var cId = $('#selected3').val()
            var totalResults = 0;
            $.ajax({
                url: 'KnowSearch',
                type: 'get',
                dataType: 'json',
                data: {
                    title: title,
                    cId: cId
                },
                success: function (resp) {
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
                            $('#imgsTwo' + i).append("<a onclick=\"window.open('KnowSearch?titleName=" + searchTitle + "&imgCId=" + res.courseId + "&imgId=" + j + "')\">" +
                                "<img style='width:%30;padding: 2px' src='KnowSearch?titleName=" + searchTitle + "&imgCId=" + res.courseId + "&imgId=" + j + "' height='200'>\n" +
                                "                </a>")
                        }

                    })
                    $('#activity').append("<div><hr/>共" + totalResults + "条结果</div>")
                }
            })

            // // 用法：先实例化
            // var base = new Base64();
            // // 加密
            // var xxx = base.encode();
            //console.log(xxx)
            // 解密
            // var xxx2 = base.decode("MjAxMTAwMQ==");
            // console.log(xxx2)
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
                <li class="active"><a href="#activity" data-toggle="tab">已发布内容</a></li>
                <li><a href="#add" data-toggle="tab">新增</a></li>
                <li><a href="#delete" data-toggle="tab">删除</a></li>
            </ul>

            <div class="tab-content">
                <div class="active tab-pane" id="activity">
                    <div class="form-group">
                        <label style="color: #0d6aad"><h4>选择课程</h4></label>
                        <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                        <select class="form-control" style="width:300px;height:35px;font-size:16px;" id="selected2"
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
                <!-- /.post -->
                <div class="tab-pane" id="add">
                    <div class="form-group">
                        <label style="color: #0d6aad"><h4>选择课程</h4></label>
                        <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                        <select class="form-control" style="width:300px;height:35px;font-size:16px;" id="selected">
                        </select>
                    </div>
                    <div class="form-group">
                        <label>标题</label>
                        <input type="text" class="form-control" placeholder="知识点简介（不超过255个字符）" name="title">
                    </div>
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">
                                <label>文章</label>
                                <small>内容</small>
                            </h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body pad">
                            <form>
                    <textarea class="textarea" placeholder="这里输入"
                              style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"
                              name="context" id="area"></textarea>
                            </form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="fileInput">图片上传</label>
                        <input type="file" id="fileInput" onchange="uploadFile()" multiple>

                        <p class="help-block">请选择需要上传的文件,支持jpg/jpeg/png</p>
                    </div>
                    <hr/>
                    <div align="center">
                        <button class="btn btn-success" type="button" onclick="ajaxSubmitKnowledge()">提交</button>
                    </div>
                </div>
                <div class="tab-pane" id="delete">
                    <div class="form-group">
                        <label style="color: #0d6aad"><h4>选择课程</h4></label>
                        <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                        <select class="form-control" style="width:300px;height:35px;font-size:16px;" id="selected3"
                                onclick="showDelete()">
                        </select>
                        <br>
                    </div>
                    <div>
                        <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;标题</h4>
                        <hr/>
                        <div class="box-body">

                            <ul class="todo-list" id="PreWorks1">

                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
</div>
</body>
</html>
