package jdlg.musicproject.controller.doteacher;

import jdlg.musicproject.entries.common.Courses;
import jdlg.musicproject.entries.teacher.TeacherCourse;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/doTeacher")
public class DoCourse {
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;

    /*转发添加课程*/
    @RequestMapping("/addCourse")
    public ModelAndView addCourse(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilTeacherWebURI.coursesAddUri.getUri());
        mv.setViewName("index/index-teacher");
        return mv;
    }

    /*添加课程*/
    @Transactional
    @RequestMapping(value = "/doAddCourse", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String addCourse(Courses courses, HttpSession session) {
        String flag = "添加成功！";
        if (courses.getCourseId() != null && courses.getCourseName() != null) {
            Courses course = teacherService.selectCourse(courses.getCourseId());
            if (course == null) {
                int tId = (int) session.getAttribute("tId");
                /*课程添加*/
                teacherService.addCourse(courses);
                /*绑定关系*/
                TeacherCourse teacherCourse = new TeacherCourse();
                teacherCourse.setCourseId(courses.getCourseId());
                teacherCourse.setTchId(tId);
                teacherService.bindTchCourse(teacherCourse);
            } else
                flag = "课程已存在！";
        } else
            flag = "添加失败！";
        return flag;
    }
}
