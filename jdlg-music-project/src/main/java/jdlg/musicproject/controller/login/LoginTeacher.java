package jdlg.musicproject.controller.login;

import jdlg.musicproject.entries.teacher.Teacher;
import jdlg.musicproject.entries.teacher.TeacherNamePwd;
import jdlg.musicproject.service.TeacherService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
    public ModelAndView userStudent(HttpSession session, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        String tName = request.getParameter("tName");
        if (tName != null) {
            session.setAttribute("tName", tName);
        }
        mv.setViewName("index/index-teacher");
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
