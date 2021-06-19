package jdlg.musicproject.controller.login;

import jdlg.musicproject.entries.teacher.TeacherNamePwd;
import jdlg.musicproject.service.TeacherService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Base64;

@Controller
@RequestMapping("/loginTeacher")
public class LoginTeacher {
    //注入服务层类
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;

    /*教师登录页面转发*/
    @RequestMapping("/Teacher")
    public ModelAndView userLoginTeacher() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/admin-login-teacher");
        return mv;
    }

    /*教师登录账号密码验证*/
    @RequestMapping(value = "/TchJudge", method = RequestMethod.POST)
    public ModelAndView userLoginTeacherJudge(Integer tId, String tPwd, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        TeacherNamePwd namePwd = teacherService.tchLoginById(tId);
        if (namePwd != null) {
            if (tPwd.equals(namePwd.getT_pwd())) {
                session.setAttribute("tName", namePwd.getT_name());
                session.setAttribute("tId", tId);
                mv.setViewName("skip/skip-user");
            } else
                mv.setViewName("admin/admin-login-terror");
        } else
            mv.setViewName("admin/admin-login-terror");
        return mv;
    }

    /*转发到教师index*/
    @RequestMapping("/state")
    public ModelAndView userStudent(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
        ModelAndView mv = new ModelAndView();
        String tName = request.getParameter("tName");
        Integer tId = Integer.valueOf(request.getParameter("tId"));
        if (tId != null && tName != null) {
            session.setAttribute("tName", tName);
            session.setAttribute("tId", tId);
            String tNameBase = Base64.getEncoder().encodeToString(tName.getBytes());
            String tIdBase = Base64.getEncoder().encodeToString(String.valueOf(tId).getBytes());
            //response.sendRedirect("/doTeacher/indexTeacher?tName="+tNameBase+"&tId="+tIdBase);
            String basePath = request.getScheme() + "://" +
                    request.getServerName() + ":" + request.getServerPort() +
                    request.getContextPath() + "/";
            //mv.setViewName("redirect:"+basePath+"registerTeacher/regTeacher");
            mv.setViewName("redirect:"+basePath+"doTeacher/indexTeacher?tName="+tNameBase+"&tId="+tIdBase);
        }
        //mv.setViewName("index/index-teacher");
        return mv;
    }

    /*教师退出登录*/
    @RequestMapping("/loginOut")
    public ModelAndView loginOut(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        session.removeAttribute("tName");
        mv.setViewName("redirect:/index.jsp");
        return mv;
    }
}
