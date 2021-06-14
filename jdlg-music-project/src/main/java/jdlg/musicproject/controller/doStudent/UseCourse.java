package jdlg.musicproject.controller.doStudent;

import jdlg.musicproject.entries.common.Courses;
import jdlg.musicproject.entries.common.WorkExplain;
import jdlg.musicproject.entries.student.StudentCourse;
import jdlg.musicproject.entries.student.StudentGrade;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import jdlg.musicproject.util.UtilStudentWebURI;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/doStudent")
public class UseCourse {
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;

    @RequestMapping("/addCourse")
    public ModelAndView addCourse(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilStudentWebURI.coursesAddUri.getUri());
        mv.setViewName("index/index-student");
        return mv;
    }
    /*这里是添加课程*/
    @Transactional
    @RequestMapping(value = "/doAddCourse", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public String doAddCourse(Integer courseId, HttpSession session) {
        String flag = "添加成功！";
        Integer sId = (Integer) session.getAttribute("sId");
        /*查找课程是否存在*/
        if (teacherService.selectCourse(courseId) != null) {
            /*课程是否已选*/
            List<Courses> courses = studentService.showStuCourses(sId);
            for (Courses c : courses) {
                if (c.getCourseId().intValue() == courseId.intValue()) {
                    flag = "课程已选！";
                    return flag;
                }
            }
            /*添加课程*/
            StudentCourse course = new StudentCourse();
            course.setCourseId(courseId);
            course.setStuId(sId);
            studentService.addCourse(course);
            /*添加相关作业,课程对应次数*/
            List<Integer> times = teacherService.showAllTimes(courseId);
            for (Integer t : times) {
                StudentGrade grade = new StudentGrade();
                grade.setCourseId(courseId);
                grade.setStuId(sId);
                grade.setTimes(t);
                studentService.addGradeRecord(grade);
            }
        } else
            flag = "课程不存在！";
        return flag;
    }

    @RequestMapping(value = "/showCourse", method = RequestMethod.POST)
    @ResponseBody
    public List<Courses> showCourse(HttpSession session) {
        List<Courses> courses = studentService.showStuCourses((Integer) session.getAttribute("sId"));
        return courses;
    }

    @RequestMapping(value = "/showWork", method = RequestMethod.POST)
    @ResponseBody
    public List<WorkExplain> showWork() {
        return null;
    }
}
