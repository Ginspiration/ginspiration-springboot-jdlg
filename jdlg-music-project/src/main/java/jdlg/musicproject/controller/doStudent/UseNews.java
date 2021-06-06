package jdlg.musicproject.controller.doStudent;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import jdlg.musicproject.entries.common.News;
import jdlg.musicproject.service.NewsService;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import jdlg.musicproject.util.UtilStudentWebURI;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/doStudent")
public class UseNews {
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;
    @Resource(name = "newsServiceImpl")
    private NewsService newsService;

    /**
     * 查看新闻列表，并可实现翻页功能
     *
     * @param nowPage    当前页
     * @param updatePage 更新页
     * @param model
     * @param request
     * @param session
     * @return
     * @Param mark  判断搜索的范围，0为未标记，1为标记，2为全部
     */
    @GetMapping("viewNews")
    public ModelAndView aPage(int nowPage, int updatePage,
                              Model model, HttpServletRequest request,
                              HttpSession session, int mark) {
        //一页显示多少条数据
        int pageSize = 10;

        //求出跳转页数
        nowPage = nowPage + updatePage;

        /**
         * 查找对应新闻并传送前端
         * 使用pagehelper分页获取
         * 通过mark选择对应搜索方法
         * */
        Page<Object> page;
        List<News> newsList;
        if (mark == 0) {
            page = PageHelper.startPage(nowPage, pageSize);
            synchronized (session.getAttribute("synNews")) {
                newsList = newsService.selectNewsByMark(0);
            }
        } else if (mark == 1) {
            page = PageHelper.startPage(nowPage, pageSize);
            synchronized (session.getAttribute("synNews")) {
                newsList = newsService.selectNewsByMark(1);
            }
        } else {
            page = PageHelper.startPage(nowPage, pageSize);
            synchronized (session.getAttribute("synNews")) {
                newsList = newsService.selectAllNews();
            }
        }


        //获取总页数
        int totalPage = page.getPages();
        //获取当前页
        nowPage = page.getPageNum();

        session.removeAttribute("nowPage");
        session.setAttribute("nowPage", nowPage);

        session.removeAttribute("totalPage");
        session.setAttribute("totalPage", totalPage);

        session.removeAttribute("news");
        session.setAttribute("news", newsList);

        session.removeAttribute("mark");
        session.setAttribute("mark", mark);

        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilStudentWebURI.viewNews.getUri());
        mv.setViewName("index/index-student");
        return mv;
    }

    /**
     * 搜索新闻
     *
     * @param req
     * @param session
     * @return
     */
    @GetMapping("selectNew")
    public ModelAndView selectNew(HttpServletRequest req, HttpSession session) {

        String title = req.getParameter("title");
        //System.out.println(title);
        List<News> newsList = null;
        synchronized (session.getAttribute("synNews")) {
            newsList = newsService.selectNewByTitle(title);
        }
        //System.out.println(newsList);

        session.removeAttribute("mark");
        session.setAttribute("mark", 3);

        session.removeAttribute("news");
        session.setAttribute("news", newsList);

        ModelAndView mv = new ModelAndView();
        req.setAttribute("Context", UtilStudentWebURI.viewNews.getUri());
        mv.setViewName("index/index-student");
        return mv;
    }

    /*新闻详情跳转*/
    @RequestMapping("/newsDetail")
    public ModelAndView newsDetail(String newTitle, HttpServletRequest request,
                                   HttpSession session) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilStudentWebURI.viewNewsDetail.getUri());

        //获取新闻对象
        List<News> news = null;
        synchronized (session.getAttribute("synNews")) {
            news = newsService.selectNewByTitle(newTitle);
        }
        News news1 = news.get(0);

        session.removeAttribute("news");
        session.setAttribute("news", news1);

        mv.setViewName("index/index-student");
        return mv;
    }

}
