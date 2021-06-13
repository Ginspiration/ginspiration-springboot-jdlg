package jdlg.musicproject.interceptor.login;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class TeacherInterceptor implements HandlerInterceptor {
/*

    @Value("${server.address}")
    private  String webAddress;
    @Value("${server.port}")
    private String port;
    @Value("${server.servlet.context-path}")
    private String contextPath;
*/

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String tName = (String) request.getSession().getAttribute("tName");
        if ( tName == null) {
            response.sendRedirect("/");
            return false;
        } else
        return true;
    }
}
