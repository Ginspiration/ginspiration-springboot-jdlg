<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /*做对几题*/
    Integer rCount = (Integer) session.getAttribute("rCount");
    /*总分*/
    Float totalPoints = (Float) session.getAttribute("totalPoints");
    /*得分*/
    Float thisGrade = (Float) session.getAttribute("points");
%>
<div class="content-wrapper">
    <!-- 内容头部 -->
    <section class="content-header">
        <h1>
            ${sessionScope.sName}
            <small>(学生)</small>
        </h1>
    </section>
    <section class="content">
        <div class="content">
            总分：<%=totalPoints%><br/>
            答对数：<%=rCount%><br/>
            <h1 style="color: red">
                得分：<%=thisGrade%>
            </h1>
        </div>
    </section>
</div>