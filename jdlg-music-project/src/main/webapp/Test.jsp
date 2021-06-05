<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" + request.getServerPort() +
            request.getContextPath() + "/";
%>
<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
multiple指可以同时上传多个文件
<br/>
input type="file" name="abc" multiple="multiple" id="a"
<input type="file" name="abc" multiple="multiple" id="a">
<br/>
input type="text" name="stuName"
<input type="text" name="stuName">
<br/>
<button type="button" onclick="ajaxSubmit()" value="提交">提交</button>
<script>
    var thisData = new FormData();
    function ajaxSubmit() {
        var thisFiles = $('#a')
        //1、遍历所有文件，查看文件类型
        for (var i = 0; i < thisFiles[0].files.length; i++) {
            //最后出现'.'处的索引
            var index = thisFiles[0].files[i].name.lastIndexOf(".");
            //往后截取
            var fileName = thisFiles[0].files[i].name.substring(index + 1);
            //获取文件后缀名
            console.log(fileName)
        }
        //2、将文件放入formDate()
        for (var i = 0; i < thisFiles[0].files.length; i++) {
            thisData.append("files",thisFiles[0].files[i])
        }
        //3、将其他类型的数据放入formDate
        thisData.append("stuName",$("input[name='stuName']").val())
        //4、ajax提交文件给后端
        $.ajax({
            url:'fileTest',
            type: 'post',
            dataType: 'text',
            data: thisData,
            cache: false,
            //async: false,
            //不处理数据
            processData: false,
            //不设置内容类型
            contentType: false,
            success: function (resp) {
            }
        })
    }
</script>