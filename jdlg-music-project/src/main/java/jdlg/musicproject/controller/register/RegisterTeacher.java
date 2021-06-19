package jdlg.musicproject.controller.register;

import jdlg.musicproject.entries.teacher.Teacher;
import jdlg.musicproject.entries.teacher.TeacherAdmin;
import jdlg.musicproject.entries.teacher.TeacherRegister;
import jdlg.musicproject.service.AdminService;
import jdlg.musicproject.service.TeacherService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/registerTeacher")
public class RegisterTeacher {
    //注入服务层类
    @Resource(name = "adminServiceImpl")
    AdminService adminService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;

    /*教师注册转发*/
    @RequestMapping("/regTeacher")
    public ModelAndView RegisterTeacherDispatcher() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/admin-register-teacher-permit");
        return mv;
    }

    /*教师注册获取管理员权限regTeacherPermit*/
/*    @RequestMapping(value = "/regTeacherPermit", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView userRegisterTeacherPermit(@RequestParam("adminName") String name,
                                                  @RequestParam("adminPassword") String password) {
        ModelAndView mv = new ModelAndView();
        TeacherRegister register = adminService.registerPermit();
        if (register.getAdmin_Name().equals(name) && register.getPassword().equals(password)) {
            mv.setViewName("admin/admin-register-teacher");
        } else
            mv.setViewName("admin/admin-register-teacher-perror");
        return mv;
    }*/
    @RequestMapping(value = "/regTeacherPermit", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView userRegisterTeacherPermit(@RequestParam("adminName") String name) {
        ModelAndView mv = new ModelAndView();
        List<String> codes = adminService.queryTeacherRegisterCode();
        for (String code : codes) {
            if (code.equals(name)) {
                mv.setViewName("admin/admin-register-teacher");
                return mv;
            }
        }
        mv.setViewName("admin/admin-register-teacher-perror");
        return mv;
    }

    /*教师注册*/
    @RequestMapping("/regMessage")
    public ModelAndView RegisterTeacher(String sRegName, Integer sRegNumber, String sRegPwd, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        if (sRegName != null && sRegNumber != null && sRegPwd != null) {
            Teacher teacher = new Teacher();
            /*插入基本信息*/
            teacher.setTeacher_id(sRegNumber);
            teacher.setTeacher_name(sRegName);
            /*插入账号密码*/
            TeacherAdmin teacherAdmin = new TeacherAdmin();
            teacherAdmin.setAdmin_tch_id(sRegNumber);
            teacherAdmin.setTch_password(sRegPwd);
            /*返回两条记录*/
            int res = teacherService.addTeacher(teacher);
            int res1 = teacherService.addTchPwdName(teacherAdmin);
            if ((res + res1) == 2) {
                request.setAttribute("tName", sRegName);
                request.setAttribute("tId", sRegNumber);
                mv.setViewName("skip/register-complete");
            } else
                mv.setViewName("admin/admin-register-terror");
        } else
            mv.setViewName("admin/admin-register-terror");
        return mv;
    }

}
