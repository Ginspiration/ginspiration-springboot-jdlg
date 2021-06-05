package jdlg.musicproject.controller.doteacher;

import jdlg.musicproject.entries.common.News;
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
import java.util.List;

@Controller
@RequestMapping("/doTeacher")
public class DoTeacher {
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;
    @Resource(name = "newsServiceImpl")
    private NewsService newsService;

    /*跳转到教师网站*/
    @RequestMapping("/indexTeacher")
    public ModelAndView indexTeacher(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
        ModelAndView mv = new ModelAndView();
        String tName;
        Integer tId = null;
        String tNameBase64 = request.getParameter("tName");
        String tIdBase64 = request.getParameter("tId");
        if (tIdBase64 != null && tNameBase64 != null) {
            tName = new String(Base64.getDecoder().decode(tNameBase64.replace(" ", "+")), "utf-8");
            String tIdString = new String(Base64.getDecoder().decode(tIdBase64.replace(" ", "+")), "utf-8");
            tId = Integer.parseInt(tIdString);
            session.setAttribute("tName", tName);
            session.setAttribute("tId", tId);
        }
//        else {
//            tName = (String) session.getAttribute("sName");
//            tId = (Integer) session.getAttribute("sId");
//        }
//        String tNameBase64 = request.getParameter("tName").replace(" ", "+");
//        String tIdBase64 = request.getParameter("tId").replace(" ", "+");
//        String tName = new String(Base64.getDecoder().decode(tNameBase64), "utf-8");
//        String tIdString = new String(Base64.getDecoder().decode(tIdBase64), "utf-8");
//        Integer tId = Integer.parseInt(tIdString);
//        session.setAttribute("tName", tName);
//        session.setAttribute("tId", tId);

        /*获取新闻列表*/
        List<News> newsList = newsService.selectNewsByMark(1);
        session.setAttribute("news",newsList);

        mv.setViewName("index/index-teacher");
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
