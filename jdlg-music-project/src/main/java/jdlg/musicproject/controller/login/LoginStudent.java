package jdlg.musicproject.controller.login;

import jdlg.musicproject.entries.student.StudentNamePwd;
import jdlg.musicproject.entries.web.WebManage;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/loginStudent")
public class LoginStudent {
    //注入服务层类
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;

    /*学生登录转发*/
    @RequestMapping("/student")
    public ModelAndView userLoginStudent(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        WebManage message = teacherService.showWebMessage();
        if (message.getWebUsed() == 1) {
            mv.setViewName("error/web-used");
        } else
            mv.setViewName("admin/admin-login-student");
        return mv;
    }

    /*学生登录账号密码验证*/
    @RequestMapping(value = "/stuJudge", method = RequestMethod.POST)
    public ModelAndView userLoginStudentJudge(Integer sId, String sPwd, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        /*判断数据库中是否有学生信息*/
        StudentNamePwd pwdName = studentService.stuLoginById(sId);
        /*比较密码信息*/
        if (pwdName != null) {
            /*密码正确*/
            if (sPwd.equals(pwdName.getS_pwd())) {
                if (studentService.usedStudent(sId) == 0) {
                    session.setAttribute("sName", pwdName.getS_name());
                    session.setAttribute("sId", sId);
                    mv.setViewName("skip/skip-user");
                } else {
                    session.setAttribute("used", false);
                    mv.setViewName("skip/skip-user");
                }
            } else {
                mv.setViewName("admin/admin-login-serror");
            }
        } else
            mv.setViewName("admin/admin-login-serror");
        return mv;
    }

    /*转发到学生index*/
    @RequestMapping("/state")
    public ModelAndView userStudent(HttpServletRequest request, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        String stuName = request.getParameter("sName");
        if (stuName != null) {
            session.setAttribute("sName", stuName);
        }
        mv.setViewName("index/index-student");
        return mv;
    }

    /*学生退出登录*/
    @RequestMapping("/loginOut")
    public ModelAndView loginOut(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        session.removeAttribute("sName");
        mv.setViewName("redirect:/index.jsp");
        return mv;
    }
}