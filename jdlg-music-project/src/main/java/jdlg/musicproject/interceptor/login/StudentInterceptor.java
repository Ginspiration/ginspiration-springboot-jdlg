package jdlg.musicproject.interceptor.login;

import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StudentInterceptor implements HandlerInterceptor {
    private static String basePath;

    static {
        basePath = UtilTeacherWebURI.basePathURL.getUri();
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
/*        String sName = (String) request.getSession().getAttribute("sName");
        if (sName == null) {
            response.sendRedirect(basePath+"/index.jsp");
            return false;
        } else*/
        return true;
    }
}