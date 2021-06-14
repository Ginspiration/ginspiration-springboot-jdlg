<!--整个文件是放在WEB-INF的jsp目录下的，如果应用文件路径不对，可以手动修改-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!--这是basePath包含文件，获取网站的url-->
<%@include file="../../pages/web-url.jsp" %>
<!--这是<basePath包含文件，获取网站的url-->

<html>
<head>
    <!--由于是用jsp:include page=""动态包含，所以每个新建的jsp文件都要加入自己的引用文件jQuery，bootstrap等-->
    <script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script>
        //js文件上传对象
        var file = new FormData();
        $(function () {
            ajaxShowCourses()

            showAppreciateDelete()
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
                url: "addWork/showCourses",
                type: "post",
                async: false,
                success: function (rep) {
                    $.each(rep, function (i, res) {
                        $("#selected").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                        $("#selected2").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                        $("#selected3").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                    })
                    ajaxShowAppreciate()
                }
            })

        }

        var upFiles = new FormData();

        function ajaxAddAppreciate() {
            if (checkAdd()) {

                var context = $("textarea[name='context']").val();
                var title = $("input[name='title']").val();
                var cId = $("#selected").val();
                upFiles.append("title", title.trim());
                upFiles.append("context", context);
                upFiles.append("courseId", cId);
                var selectImg = $('#image_')[0]
                var selectMusic = $('#music_')[0]
                var selectVideo = $('#video_')[0]
                for (let i = 0; i < selectImg.files.length; i++) {
                    upFiles.append('files', selectImg.files[i])
                }
                for (let i = 0; i < selectMusic.files.length; i++) {
                    upFiles.append('files', selectMusic.files[i])
                }
                for (let i = 0; i < selectVideo.files.length; i++) {
                    upFiles.append('files', selectVideo.files[i])
                }
                //console.log(upFiles)
                // for(var pair of upFiles.entries()) {
                //     console.log(pair[0]+ ', '+ pair[1]);
                // }
                var imageFiles = $('#image_').val()
                var musicFiles = $('#music_').val()
                var videoFiles = $('#video_').val()
                console.log("文件：" + imageFiles)
                var confirmImg = '*已选择图片*';
                var confirmMusic = '*已选择音乐*';
                var confirmVideo = '*已选择视频*';
                if (imageFiles === '')
                    confirmImg = "(未选择图片)";
                if (musicFiles === '')
                    confirmMusic = '(未选择音乐)';
                if (videoFiles === '')
                    confirmVideo = '(未选择视频)';
                confirm({
                    title: '提交',
                    content: "-----上传文件-----" + '<br/>' + confirmImg + '<br/>' + confirmMusic + '<br/>' + confirmVideo,
                    doneText: '确认',
                    cancelText: '取消'
                }).then(() => {
                    //换个账号
                    //console.log('已确认')
                    //alert("正在校验文件，请稍等...")
                    //弹出提示框
                    toast({time: 2000, content: '正在校验文件，请稍后...'})
                    $.ajax({
                        url: 'addViewListen',
                        type: 'post',
                        dataType: 'text',
                        data: upFiles,
                        cache: false,
                        //async: false,
                        //不处理数据
                        processData: false,
                        //不设置内容类型
                        contentType: false,
                        success: function (resp) {
                            if (resp !== '添加成功') {
                                upFiles.delete('title')
                                upFiles.delete('context')
                                upFiles.delete('cId')
                                upFiles.delete("files")
                                alert(resp)
                            } else {
                                alert("添加成功，2秒后跳转")
                                setTimeout(function () {
                                    //方法体
                                    $(location).attr('href', '<%=basePath%>doTeacher/viewListen')
                                }, 2000)
                            }
                        }
                    })
                }).catch(() => {
                    //退出
                    //console.log('已取消')
                    for (var pair of upFiles.entries()) {
                        console.log(pair[0] + ', ' + pair[1]);
                    }
                    upFiles.delete('title')
                    upFiles.delete('context')
                    upFiles.delete('cId')
                    upFiles.delete("files")
                })
                //upFiles = new FormData();
            }
        }

        function checkAdd() {
            var title = $("input[name='title']").val();
            if (title.trim() == '') {
                AstNotif.notify('请输入标题！');
                return false
            } else if ($("textarea[name='context']").val().trim() == '') {
                AstNotif.notify('请输入内容！');
                return false
            } else if (title.length >= 255) {
                AstNotif.notify('标题过长！');
                return false
            } else
                return true
        }

        function checkFiles(type) {
            var thisFiles = $('#' + type)
            //遍历所有文件
            for (var i = 0; i < thisFiles[0].files.length; i++) {
                //最后出现'.'处的索引
                var index = thisFiles[0].files[i].name.lastIndexOf(".");
                //往后截取
                var fileName = thisFiles[0].files[i].name.substring(index + 1);
                //console.log(fileName)
                //console.log(type)
                if (type == 'image_') {
                    if (fileName !== 'png' && fileName !== 'jpg' && fileName !== 'jpeg') {
                        alert("文件类型错误，请重试.")
                        $('#image_').val(null)
                        return;
                    }
                } else if (type == 'music_') {
                    if (fileName !== 'mp3') {
                        alert("文件类型错误，请重试.")
                        $('#music_').val(null)
                        return;
                    }
                } else if (type == 'video_') {
                    if (fileName !== 'mp4' && fileName !== 'avi' && fileName !== 'wmv' && fileName !== 'flv') {
                        alert("文件类型错误，请重试.")
                        $('#video_').val(null)
                        return;
                    }
                }
            }
        }

        var totalPages;
        var nowPage = 1;
        var pageFlag = 0;

        function ajaxShowAppreciate(index) {
            var cId = $('#selected2').val()
            if (index == null) {
                index = nowPage;
            }
            $.ajax({
                url: 'showViewListen',
                type: 'get',
                dataType: 'json',
                //async:false,
                timeout: 30000,
                data: {
                    cId: cId,
                    index: index
                },
                success: function (resp) {
                    $('#thisContent').empty()
                    $.each(resp, function (i, res) {
                        if (res.id === -1) {
                            totalPages = res.courseId
                        } else {
                            $('#thisContent').append("<div class='post'>\n" +
                                "                        <div>\n" +
                                "                            <span class='username'><a style='font-size: 30px;color: #0c0c0c' >" + res.title + "</a></span>\n" +
                                "                            <br/><br/>\n" +
                                "                            <span class='description' style='font-size: 10px;color: #8a8a8a' >发布时间：" + res.upTime + "</span>\n" +
                                "                        </div>\n" +
                                "                        <hr/>\n" +
                                "                        <p>\n" +
                                "                        " + res.context + "</p>\n" +
                                "                        <div class='row margin-bottom'>\n" +
                                "                            <div class='content'>\n" +

                                "                                <div style='width: 800px;'>\n" +
                                "                                <h4>音乐</h4><br/><div id='music" + i + "'>暂无</div></div><hr/>\n" +

                                "                                <div style='width: 800px;'>\n" +
                                "                                <h4>视频</h4><br/>" +
                                "                                   <div id='video" + i + "'>暂无</div>" +
                                "                                   <div id='showVideo" + i + "'></div>" +
                                "                                   </div><hr/>\n" +

                                "                                <div style='width: 800px;'>\n" +
                                "                                <h4>图片资料</h4><br/><div id='image" + i + "'>暂无</div></div>\n" +

                                "                            </div>\n" +
                                "                        </div>\n" +
                                "                    </div>")
                            if (res.musicNumber !== 0) {
                                $('#music' + i).empty()
                                for (let j = 0; j < res.musicNumber; j++) {
                                    $('#music' + i).append("<audio style='padding: 2px' src='showViewListen?pageFlag="+pageFlag+"&mediaFlag=music&contextId=" + res.id + "&musicId=" + j + "' controls='controls'></audio>")
                                }
                            }
                            if (res.videoNumber !== 0) {
                                $('#video' + i).empty()
                                for (let j = 0; j < res.videoNumber; j++) {
                                    $('#video' + i).append("<a class='btn btn-success' href='showViewListen?pageFlag="+pageFlag+"&mediaFlag=video&contextId=" + res.id + "&videoId=" + j + "'>点此下载视频-" + (j + 1) + "</a>&nbsp;&nbsp;");
                                    //$('#video' + i).append("<a class='btn btn-success' onclick='handlerVideo("+i+","+res.id+","+j+")'>点此播放视频-" + (j + 1) + "</a>&nbsp;&nbsp;");
                                    //$('#video' + i).append("<video style='width: 450px' src='showViewListen?mediaFlag=video&contextId=" + res.id + "&videoId=" + j + "' controls='controls'></video>")
                                }
                            }
                            if (res.imgNumber !== 0) {
                                $('#image' + i).empty()
                                for (let j = 0; j < res.imgNumber; j++) {
                                    $('#image' + i).append("<a onclick=\"window.open('showViewListen?pageFlag="+pageFlag+"&mediaFlag=image&contextId=" + res.id + "&imgId=" + j + "')\">" +
                                        "<img style='width:%30;padding: 2px' src='showViewListen?pageFlag="+pageFlag+"&mediaFlag=image&contextId=" + res.id + "&imgId=" + j + "' height='200'>\n" +
                                        "                </a>")
                                }
                            }
                            pageFlag++;
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
                        if (nowPage === 1) {
                            AstNotif.notify('已是第一页！')
                        } else {
                            nowPage = 1;
                            ajaxShowAppreciate(1)
                        }
                    })
                    $('#downPage').on('click', function () {
                        if (nowPage < totalPages) {
                            nowPage = nowPage + 1;
                            ajaxShowAppreciate(nowPage)
                        } else
                            AstNotif.notify('已是最后一页！');
                    })
                    $('#upPage').on('click', function () {
                        if (nowPage > 1) {
                            nowPage = nowPage - 1;
                            ajaxShowAppreciate(nowPage)
                        } else
                            AstNotif.notify('已是第一页！')
                    })
                    $('#lastPage').on('click', function () {
                        if (nowPage === totalPages) {
                            AstNotif.notify('已是最后一页')
                        } else {
                            nowPage = totalPages
                            //console.log(totalPages)
                            ajaxShowAppreciate(totalPages)
                        }
                    })
                },
                // error : function(xhr,textStatus){
                //     console.log('error:'+textStatus);
                //     ajaxShowAppreciate(index)
                // }
            })
        }

        // function handlerVideo(i,id,j) {
        //     $('#showVideo'+i).empty()
        //     $('#showVideo' + i).append("<br/><video style='width: 450px' src='showViewListen?mediaFlag=video&contextId=" + id + "&videoId=" + j + "' controls='controls'></video>")
        // }

        function ajaxSearchrAppreciate() {
            var count = 0;
            var cId = $('#selected').val()
            var index = $("input[name='doSearch']").val()
            $.ajax({
                url: 'searchViewListen',
                type: 'get',
                dataType: 'json',
                data: {
                    cId: cId,
                    index: index
                },
                success: function (resp) {
                    $('#publishedPages').empty()
                    $('#publishedPages').append("<li><h4>搜索结果</h4></li>")
                    $('#thisContent').empty()
                    $.each(resp, function (i, res) {
                        count++;
                        $('#thisContent').append("<div class='post'>\n" +
                            "                        <div>\n" +
                            "                            <span class='username'><a style='font-size: 30px;color: #0c0c0c' >" + res.title + "</a></span>\n" +
                            "                            <br/><br/>\n" +
                            "                            <span class='description' style='font-size: 10px;color: #8a8a8a' >发布时间：" + res.upTime + "</span>\n" +
                            "                        </div>\n" +
                            "                        <hr/>\n" +
                            "                        <p>\n" +
                            "                        " + res.context + "</p>\n" +
                            "                        <div class='row margin-bottom'>\n" +
                            "                            <div class='content'>\n" +

                            "                                <div style='width: 800px;'>\n" +
                            "                                <h4>音乐</h4><br/><div id='music" + i + "'>暂无</div></div><hr/>\n" +

                            "                                <div style='width: 800px;'>\n" +
                            "                                <h4>视频</h4><br/><div id='video" + i + "'>暂无</div></div><hr/>\n" +

                            "                                <div style='width: 800px;'>\n" +
                            "                                <h4>图片资料</h4><br/><div id='image" + i + "'>暂无</div></div>\n" +

                            "                            </div>\n" +
                            "                        </div>\n" +
                            "                    </div>")
                        if (res.musicNumber !== 0) {
                            $('#music' + i).empty()
                            for (let j = 0; j < res.musicNumber; j++) {
                                $('#music' + i).append("<audio style='padding: 2px' src='searchViewListen?mediaFlag=music&contextId=" + res.id + "&musicId=" + j + "' controls='controls'></audio>")
                            }
                        }
                        if (res.videoNumber !== 0) {
                            $('#video' + i).empty()
                            for (let j = 0; j < res.videoNumber; j++) {
                                $('#video' + i).append("<a class='btn btn-success' href='showViewListen?mediaFlag=video&contextId=" + res.id + "&videoId=" + j + "'>点此下载视频" + (j + 1) + "</a>&nbsp;&nbsp;");
                                //$('#video' + i).append("<video style='padding: 2px' src='searchViewListen?mediaFlag=video&contextId=" + res.id + "&videoId=" + j + "' controls='controls' width='40%' height='21%'></video>")
                            }
                        }
                        if (res.imgNumber !== 0) {
                            $('#image' + i).empty()
                            for (let j = 0; j < res.imgNumber; j++) {
                                $('#image' + i).append("<a onclick=\"window.open('searchViewListen?mediaFlag=image&contextId=" + res.id + "&imgId=" + j + "')\">" +
                                    "<img style='width:%30;padding: 2px' src='searchViewListen?mediaFlag=image&contextId=" + res.id + "&imgId=" + j + "' height='200'>\n" +
                                    "                </a>")
                            }
                        }

                    })
                    $('#thisContent').append("<hr/>共" + count + "条结果");
                }
            })
        }

        function showAppreciateDelete() {
            var cId = $('#selected3').val()
            $.ajax({
                url: 'showAppreciateDelete',
                type: 'post',
                dataType: 'json',
                data: {
                    cId: cId
                },
                success: function (resp) {
                    $('#PreWorks1').children().remove()
                    $.each(resp, function (i, res) {
                        $("#PreWorks1").append("<li id='title" + i + "'>\n" +
                            "                        <span class='text'><button class='btn-success'>" + res.title + "</button></span>\n" +
                            "                        <span class='text'>" + res.context + "</span>\n" +
                            "                        <span class='text' style='font-size: 10px'>" + res.upTime + "</span>\n" +
                            "                        <div class='tools'>\n" +
                            "                            <button class='btn-danger' id='appDelete" + i + "'>删除</button>\n" +
                            "                        </div>\n" +
                            "                    </li>")
                        $('#appDelete' + i).on('click', function () {
                            deleteAppreciate(res.title, cId, i)
                        })
                    })
                }
            })
        }

        function deleteAppreciate(title, cId2, i) {
            //console.log(title + cId2 + i)
            $.ajax({
                url: 'doAppreciateDelete',
                type: 'post',
                dataType: 'text',
                data: {
                    index: title,
                    cId: cId2
                },
                success: function (resp) {
                    if (resp === '删除成功') {
                        alert(resp);
                        $('#title' + i).remove()
                    } else
                        alert(resp)
                }
            })
        }
    </script>
</head>
<body>
<!--这里是主体内容窗口-->
<div class="content-wrapper">
    <!--内容头部显示用户名称-->
    <section class="content-header">
        <div>
            <p>鉴赏</p>
        </div>
        <h1>
            ${sessionScope.tName}
            <small>(教师)</small>
        </h1>
    </section>
    <!--内容头部显示用户名称-->

    <!--这里是内容主体居中显示，放在section里面-->
    <section class="content">
        <!-- 这里可以添加div内容，content表示居中，其他div可以自己添加-->
        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#activity" data-toggle="tab">已发布内容</a></li>
                <li><a href="#add" data-toggle="tab">新增</a></li>
                <li><a href="#delete" data-toggle="tab">删除</a></li>
            </ul>

            <div class="tab-content">
                <div class="active tab-pane" id="activity">
                    <%---------------------------显示内容--------------------------------%>
                    <div class="form-group">
                        <label style="color: #0d6aad"><h4>选择课程</h4></label>
                        <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                        <select class="form-control" style="width:300px;height:35px;font-size:16px;" id="selected2"
                                onchange="ajaxShowAppreciate()">
                        </select>
                        <br>
                        <div class="row">
                            <form class="navbar-form navbar-left">
                                <div class="form-group">
                                    <input type="text" class="form-control" placeholder="标题搜索" name="doSearch">
                                </div>
                                <button type="button" class="btn btn-default" onclick="ajaxSearchrAppreciate()">搜索一下
                                </button>
                            </form>
                        </div>
                        <div class="row" style="padding: 15px">
                            <ul class="pagination pagination-sm inline" id="publishedPages">
                            </ul>
                        </div>
                    </div>
                    <hr/>
                    <br>
                    <!-- Post -->
                    <div id="thisContent">

                    </div>
                </div>


                <%--------------------------添加内容-------------------------------------------------%>
                <div class="tab-pane" id="add">
                    <div class="form-group">
                        <label style="color: #0d6aad"><h4>选择课程</h4></label>
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
                        <div class="box-body pad">
                            <textarea class="textarea" placeholder="这里输入"
                                      style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"
                                      name="context"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="image_" style="font-size: 20px;color: #0065fd">单文件不能超过100M</label><br/>
                        <label for="image_">图片上传</label>
                        <input type="file" id="image_" onchange="checkFiles('image_')" multiple="multiple" name="files">

                        <p class="help-block">支持jpg/jpeg/png</p>
                    </div>
                    <hr/>
                    <div class="form-group">
                        <label for="music_">音乐上传</label>
                        <input type="file" id="music_" onchange="checkFiles('music_')" multiple="multiple" name="files">
                        <p class="help-block">支持MP3</p>
                    </div>
                    <hr/>
                    <div class="form-group">
                        <label for="video_">视频上传</label>
                        <input type="file" id="video_" onchange="checkFiles('video_')" multiple="multiple" name="files">
                        <p class="help-block">支持MP4/avi/wmv/flv</p>
                    </div>
                    <hr/>
                    <div align="center">
                        <button class="btn btn-success" type="button" id="sub" onclick="ajaxAddAppreciate()">提交</button>
                    </div>
                </div>

                <%------------------------------删除----------------------------------------%>
                <div class="tab-pane" id="delete">
                    <div class="form-group">
                        <label style="color: #0d6aad"><h4>选择课程</h4></label>
                        <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                        <select class="form-control" style="width:300px;height:35px;font-size:16px;" id="selected3"
                                onchange="showAppreciateDelete()">
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
        <!-- 这里可以添加div内容，content表示居中，其他div可以自己添加-->
    </section>
    <!--这里是内容主体居中显示，放在section里面-->
</div>
<!--这里是主体内容窗口-->
</body>
</html>

