<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="web-url.jsp" %>
<%
    session.invalidate();
    response.sendRedirect(basePath + "index.jsp");
%>