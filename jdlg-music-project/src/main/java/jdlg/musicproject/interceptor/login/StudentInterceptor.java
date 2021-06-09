package jdlg.musicproject.interceptor.login;

import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class StudentInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String sName = (String) request.getSession().getAttribute("sName");
        if (sName == null) {
            response.sendRedirect("/");
            return false;
        } else
        return true;
    }
}