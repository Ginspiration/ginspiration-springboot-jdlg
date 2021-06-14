package jdlg.musicproject.controller.doStudent;

import jdlg.musicproject.entries.common.Courses;
import jdlg.musicproject.entries.common.News;
import jdlg.musicproject.entries.student.StudentGrade;
import jdlg.musicproject.service.NewsService;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/doStudent")
public class UseStudent {
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;
    @Resource(name = "newsServiceImpl")
    private NewsService newsService;

    @RequestMapping("/indexStudent")
    public ModelAndView indexStudent(HttpSession session, HttpServletRequest request) throws UnsupportedEncodingException {
        ModelAndView mv = new ModelAndView();
        String sName;
        Integer sId;
        String sNameBase64 = request.getParameter("sName");
        String sIdBase64 = request.getParameter("sId");
        if ( sNameBase64 != null && sIdBase64 != null) {
            sName = new String(Base64.getDecoder().decode(sNameBase64.replace(" ", "+")), "utf-8");
            String sIdString =  new String(Base64.getDecoder().decode(sIdBase64.replace(" ", "+")), "utf-8");
            sId = Integer.parseInt(sIdString);
            session.setAttribute("sName", sName);
            session.setAttribute("sId", sId);
        }else {
            //sName = (String) session.getAttribute("sName");
            sId = (Integer) session.getAttribute("sId");
        }
//        String sNameBase64 = request.getParameter("sName").replace(" ", "+");
//        String sIdBase64 = request.getParameter("sId").replace(" ", "+");
//        String sName = new String(Base64.getDecoder().decode(sNameBase64), "utf-8");
//        String sIdString = new String(Base64.getDecoder().decode(sIdBase64), "utf-8");
//        Integer sId = Integer.parseInt(sIdString);
//        session.setAttribute("sName", sName);
//        session.setAttribute("sId", sId);
        /*作业完成情况*/
        List<StudentGrade> grades = studentService.showGrade(sId);
        Set<String> courseNames = new HashSet<>();
        for (StudentGrade grade : grades) {
            if (grade.getGrade() == null) {
                Courses course = teacherService.selectCourse(grade.getCourseId());
                courseNames.add(course.getCourseName());
            }
        }
        if (courseNames.size() != 0) {
            session.setAttribute("unDoCourse", courseNames);
        }

        /*获取新闻列表*/
        List<News> newsList = newsService.selectNewsByMark(1);
        session.setAttribute("news",newsList);

        mv.setViewName("index/index-student");
        return mv;
    }

    /*退出登录*/
    @RequestMapping("loginOut")
    public ModelAndView logOut() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("pages/logout");
        return mv;
    }
}
