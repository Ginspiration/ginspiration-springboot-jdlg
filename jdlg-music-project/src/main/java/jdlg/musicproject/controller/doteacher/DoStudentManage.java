package jdlg.musicproject.controller.doteacher;

import jdlg.musicproject.entries.common.Register;
import jdlg.musicproject.entries.common.Seek;
import jdlg.musicproject.entries.student.Student;
import jdlg.musicproject.entries.student.StudentAdmin;
import jdlg.musicproject.entries.student.StudentNamePwd;
import jdlg.musicproject.entries.teacher.TeacherRegister;
import jdlg.musicproject.service.AdminService;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import jdlg.musicproject.service.TeacherServiceManageStudent;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/doTeacher")
public class DoStudentManage {
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;
    @Autowired
    TeacherServiceManageStudent manageStudent;
    @Autowired
    AdminService adminService;

    /*跳转管理员权限*/
    @GetMapping("/studentManagePermitIndex")
    public ModelAndView studentManagePermitIndex() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("teacher/stu/admin-power");
        return mv;
    }

    /*教师获取管理员权限*/
    @RequestMapping(value = "/studentManagePermit", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView userRegisterTeacherPermit(@RequestParam("adminName") String name,
                                                  @RequestParam("adminPassword") String password,HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        if (name != null && password != null) {
            TeacherRegister register = adminService.registerPermit();
            if (register.getAdmin_Name().equals(name) && register.getPassword().equals(password)) {
                request.setAttribute("Context", UtilTeacherWebURI.studentManage.getUri());
                mv.setViewName("index/index-teacher");
                return mv;
            } else
                mv.setViewName("teacher/stu/admin-power-error");
            return mv;
        } else {
            mv.setViewName("teacher/stu/admin-power-error");
            return mv;
        }
    }


//    /*跳转学生管理*/
//    @PostMapping("/studentManage")
//    public ModelAndView addStudent(HttpServletRequest request) {
//        ModelAndView mv = new ModelAndView();
//        request.setAttribute("Context", UtilTeacherWebURI.studentManage.getUri());
//        mv.setViewName("index/index-teacher");
//        return mv;
//    }

    /*添加学生*/
    @Transactional
    @RequestMapping(value = "/regStudent", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String regStudent(Register register) {
        //System.out.println("方法调用");
        String flag = "学生添加成功！";
        if (register.getsRegName() != null && register.getsRegNumber() != null && register.getsRegPwd() != null) {
            StudentNamePwd res = studentService.stuLoginById(register.getsRegNumber());
            if (res == null) {
                Student student = new Student();
                /*插入基本信息*/
                student.setStudent_id(register.getsRegNumber());
                student.setStudent_name(register.getsRegName());
                /*插入账号密码*/
                StudentAdmin studentAdmin = new StudentAdmin();
                studentAdmin.setAdmin_stu_id(register.getsRegNumber());
                studentAdmin.setStudent_pwd(register.getsRegPwd());
                /*返回两条记录*/
                studentService.addStudent(student);
                studentService.regStudent(studentAdmin);
            } else
                flag = "该生已存在！";
        } else
            flag = "学生添加失败！";
        //response.setCharacterEncoding("text/html;charset=utf-8");
        return flag;
    }

    /*跳转禁用学生*/
    @RequestMapping(value = "/unusedStudent")
    public ModelAndView disablesStudent(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilTeacherWebURI.studentDisableUri.getUri());
        mv.setViewName("index/index-teacher");
        return mv;
    }

    /*禁用学生*/
    @Transactional
    @RequestMapping(value = "/disableStudent", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String disableStudent(Seek seek) {
        String flag = "禁用成功！";
        if (seek.getSeekId() != null) {
            teacherService.disableStudent(seek.getSeekId());
        } else
            flag = "禁用失败！";
        return flag;
    }

    /*启用学生*/
    @Transactional
    @RequestMapping(value = "/ableStudent", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String ableStudent(Seek seek) {
        String flag = "启用成功！";
        if (seek.getSeekId() != null) {
            teacherService.ableStudent(seek.getSeekId());
        } else
            flag = "启用失败！";
        return flag;
    }

    /*删除学生*/
    @Transactional
    @PostMapping(value = "/deleteStudent", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String deleteStudent(Integer deleteNumber) {
        return manageStudent.deleteStudentBysId(deleteNumber);
    }

    /*重置单个学生密码*/
    @Transactional
    @PostMapping(value = "resetStudentPassword", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String resetStudentPassword(Integer sId, String password) {
        return manageStudent.resetPasswordBysId(sId, password);
    }

    /*重置所有学生密码*/
    @Transactional
    @PostMapping(value = "resetAllStudentPassword", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String resetAllStudentPassword(String password) {
        return manageStudent.resetPasswordAllStudent(password);
    }

    /*学生搜索*/
    @PostMapping(value = "queryStudentsByName")
    @ResponseBody
    public List<Student> queryStudentsByName(String sName) {
        return manageStudent.queryStudentsByName(sName);
    }
}
