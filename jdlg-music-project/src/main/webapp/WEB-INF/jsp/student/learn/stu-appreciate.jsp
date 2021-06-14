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
        })

        function ajaxShowCourses() {
            $.ajax({
                url: "showCourse",
                type: "post",
                success: function (rep) {
                    $.each(rep, function (i, res) {
                        //alert(res.courseName)
                        console.log(res.courseId+res.courseName)
                        $("#selectedStu").append("<option value=" + res.courseId + ">" + res.courseName + "</option>")
                    })
                    ajaxShowAppreciate()
                }
            })
        }

        var totalPages;
        var nowPage = 1;
        var pageFlag = 0;

        function ajaxShowAppreciate(index) {
            var cId = $('#selectedStu').val()
            console.log("aaaaaaaaaa"+cId)
            if (index == null) {
                index = nowPage;
            }
            $.ajax({
                url: 'showViewListenStu',
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
                                    $('#music' + i).append("<audio style='padding: 2px' src='showViewListenStu?pageFlag="+pageFlag+"&mediaFlag=music&contextId=" + res.id + "&musicId=" + j + "' controls='controls'></audio>")
                                }
                            }
                            if (res.videoNumber !== 0) {
                                $('#video' + i).empty()
                                for (let j = 0; j < res.videoNumber; j++) {
                                    //$('#video' + i).append("<a class='btn btn-success' onclick='handlerVideo("+i+","+res.id+","+j+")'>点此播放视频-" + (j + 1) + "</a>&nbsp;&nbsp;");
                                    $('#video' + i).append("<a class='btn btn-success' href='showViewListenStu?pageFlag="+pageFlag+"&mediaFlag=video&contextId=" + res.id + "&videoId=" + j + "'>点此下载视频-" + (j + 1) + "</a>&nbsp;&nbsp;");
                                }
                            }
                            if (res.imgNumber !== 0) {
                                $('#image' + i).empty()
                                for (let j = 0; j < res.imgNumber; j++) {
                                    $('#image' + i).append("<a onclick=\"window.open('showViewListenStu?pageFlag="+pageFlag+"&mediaFlag=image&contextId=" + res.id + "&imgId=" + j + "')\">" +
                                        "<img style='width:%30;padding: 2px' src='showViewListenStu?pageFlag="+pageFlag+"&mediaFlag=image&contextId=" + res.id + "&imgId=" + j + "' height='200'>\n" +
                                        "                </a>")
                                }
                            }
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
                }
            })
        }
        // function handlerVideo(i,id,j) {
        //     $('#showVideo'+i).empty()
        //     $('#showVideo' + i).append("<br/><video style='width: 450px' src='showViewListen?mediaFlag=video&contextId=" + id + "&videoId=" + j + ".mp4' controls='controls'></video>")
        // }
        function ajaxSearchAppreciate() {
            var count = 0;
            var cId = $('#selectedStu').val()
            var index = $("input[name='doSearch']").val()
            $.ajax({
                url: 'searchViewListenStu',
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
                                $('#music' + i).append("<audio style='padding: 2px' src='searchViewListenStu?mediaFlag=music&contextId=" + res.id + "&musicId=" + j + "' controls='controls'></audio>")
                            }
                        }
                        if (res.videoNumber !== 0) {
                            $('#video' + i).empty()
                            for (let j = 0; j < res.videoNumber; j++) {
                                $('#video' + i).append("<a class='btn btn-success' href='searchViewListenStu?mediaFlag=video&contextId=" + res.id + "&videoId=" + j + "'>点此下载视频" + (j + 1) + "</a>&nbsp;&nbsp;");
                                //$('#video' + i).append("<video style='padding: 2px' src='searchViewListen?mediaFlag=video&contextId=" + res.id + "&videoId=" + j + "' controls='controls' width='40%' height='21%'></video>")
                            }
                        }
                        if (res.imgNumber !== 0) {
                            $('#image' + i).empty()
                            for (let j = 0; j < res.imgNumber; j++) {
                                $('#image' + i).append("<a onclick=\"window.open('searchViewListenStu?mediaFlag=image&contextId=" + res.id + "&imgId=" + j + "')\">" +
                                    "<img style='width:%30;padding: 2px' src='searchViewListenStu?mediaFlag=image&contextId=" + res.id + "&imgId=" + j + "' height='200'>\n" +
                                    "                </a>")
                            }
                        }

                    })
                    $('#thisContent').append("<hr/>共" + count + "条结果");
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
        <h1>
            ${sessionScope.sName}
            <small>(学生)</small>
        </h1>
    </section>
    <!--内容头部显示用户名称-->

    <!--这里是内容主体居中显示，放在section里面-->
    <section class="content">
        <!-- 这里可以添加div内容，content表示居中，其他div可以自己添加-->
        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#activity" data-toggle="tab">已发布内容</a></li>
            </ul>

            <div class="tab-content">
                <div class="active tab-pane" id="activity">
                    <%---------------------------显示内容--------------------------------%>
                    <div class="form-group">
                        <label style="color: #0d6aad"><h4>选择课程</h4></label>
                        <%-- <select size="20" style="width:200px;font-size:12px" multiple>--%>
                        <select class="form-control" style="width:300px;height:35px;font-size:16px;" id="selectedStu"
                                onchange="ajaxShowAppreciate()">
                        </select>
                        <br>
                        <div class="row">
                            <form class="navbar-form navbar-left">
                                <div class="form-group">
                                    <input type="text" class="form-control" placeholder="标题搜索" name="doSearch">
                                </div>
                                <button type="button" class="btn btn-default" onclick="ajaxSearchAppreciate()">搜索一下
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
            </div>
        </div>
        <!-- 这里可以添加div内容，content表示居中，其他div可以自己添加-->
    </section>
    <!--这里是内容主体居中显示，放在section里面-->
</div>
<!--这里是主体内容窗口-->
</body>
</html>

