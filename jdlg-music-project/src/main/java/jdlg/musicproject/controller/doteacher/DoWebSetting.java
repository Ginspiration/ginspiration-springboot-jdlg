package jdlg.musicproject.controller.doteacher;

import jdlg.musicproject.entries.teacher.TeacherRegister;
import jdlg.musicproject.entries.web.WebManage;
import jdlg.musicproject.service.AdminService;
import jdlg.musicproject.service.TeacherService;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/doTeacher")
public class DoWebSetting {
    /*    @Resource(name = "studentServiceImpl")
        StudentService studentService;*/
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;
    @Autowired
    AdminService adminService;

    /*跳转管理员权限*/
    @GetMapping("/webSettingPermitIndex")
    public ModelAndView studentManagePermitIndex(HttpSession session,HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        if (session.getAttribute("adminPower") != null && session.getAttribute("adminPower").equals(true)) {
            WebManage message = teacherService.showWebMessage();
            session.setAttribute("webUsed", message.getWebUsed());
            session.setAttribute("webRegister", message.getRegistered());
            request.setAttribute("Context", "../teacher/webSetting/admin-web.jsp");
            mv.setViewName("index/index-teacher");
            return mv;
        }
        mv.setViewName("teacher/webSetting/admin-power");
        return mv;
    }

    /*教师获取管理员权限*/
    @RequestMapping(value = "/webSettingPermit", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView userRegisterTeacherPermit(@RequestParam("adminName") String name,
                                                  @RequestParam("adminPassword") String password,
                                                  HttpServletRequest request,
                                                  HttpSession session) {
        ModelAndView mv = new ModelAndView();
        if (name != null && password != null) {
            TeacherRegister register = adminService.registerPermit();
            if (register.getAdmin_Name().equals(name) && register.getPassword().equals(password)) {
                session.setAttribute("adminPower",true);
                WebManage message = teacherService.showWebMessage();
                session.setAttribute("webUsed", message.getWebUsed());
                session.setAttribute("webRegister", message.getRegistered());
                request.setAttribute("Context", "../teacher/webSetting/admin-web.jsp");
                mv.setViewName("index/index-teacher");
                return mv;
            } else
                mv.setViewName("teacher/webSetting/admin-power-error");
            return mv;
        } else {
            mv.setViewName("teacher/webSetting/admin-power-error");
            return mv;
        }
    }

    /*网站管理转发*/
//    @RequestMapping("webManagement")
//    public ModelAndView webManagement(HttpServletRequest request, HttpSession session) {
//        ModelAndView mv = new ModelAndView();
//        WebManage message = teacherService.showWebMessage();
//        session.setAttribute("webUsed", message.getWebUsed());
//        session.setAttribute("webRegister", message.getRegistered());
//        request.setAttribute("Context", "../teacher/webSetting/admin-web.jsp");
//        mv.setViewName("index/index-teacher");
//        return mv;
//    }

    /*网站管理*/
    @RequestMapping(value = "webSubmit", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String webManagement(WebManage webManage) {
        String flag = "网站设置成功！";
        if (webManage.getRegistered() != null && webManage.getWebUsed() != null) {
            teacherService.setUpWeb(webManage);
        } else
            flag = "网站设置失败！";
        return flag;
    }
}
