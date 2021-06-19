package jdlg.musicproject.controller.register;

import jdlg.musicproject.entries.student.Student;
import jdlg.musicproject.entries.student.StudentAdmin;
import jdlg.musicproject.entries.web.WebManage;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/registerStudent")
public class RegisterStudent {
    //注入服务层类
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;

    /*学生注册*/
    @RequestMapping("/regStudent")
    public ModelAndView userRegisterStudent() {
        ModelAndView mv = new ModelAndView();
        WebManage message = teacherService.showWebMessage();
        if (message.getRegistered() == 1) {
            mv.setViewName("error/web-registered");
        } else
            mv.setViewName("admin/admin-register-student");
        return mv;
    }

    @RequestMapping(value = "/regMessage", method = RequestMethod.POST)
    public ModelAndView regStudent(String sRegName, Integer sRegNumber, String sRegPwd, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        if (sRegName != null && sRegNumber != null && sRegPwd != null) {
            Student student = new Student();
            /*插入基本信息*/
            student.setStudent_id(sRegNumber);
            student.setStudent_name(sRegName);
            /*插入账号密码*/
            StudentAdmin studentAdmin = new StudentAdmin();
            studentAdmin.setAdmin_stu_id(sRegNumber);
            studentAdmin.setStudent_pwd(sRegPwd);
            /*返回两条记录*/
            int res = studentService.addStudent(student);
            int res1 = studentService.regStudent(studentAdmin);
            if ((res + res1) == 2) {
                request.setAttribute("sName", sRegName);
                request.setAttribute("sId",sRegNumber);
                mv.setViewName("skip/register-complete");
            } else
                mv.setViewName("admin/admin-register-serror");
        } else
            mv.setViewName("admin/admin-register-serror");
        return mv;
    }
}
