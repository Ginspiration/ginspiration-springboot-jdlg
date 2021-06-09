package jdlg.musicproject.controller.index;

import jdk.nashorn.internal.objects.annotations.Property;
import jdlg.musicproject.entries.common.News;
import jdlg.musicproject.service.NewsService;
import jdlg.musicproject.util.UtilResourceBasePath;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.List;
import java.util.Properties;

@Controller
public class UseIndex {

    @Resource(name = "newsServiceImpl")
    private NewsService newsService;


    /**
     * 跳转index页面，传递数据
     *
     * @param session
     * @param request
     * @return
     */
    @RequestMapping({"/", "/index"})
    public ModelAndView index(HttpSession session, HttpServletRequest request) {
        //加入网站地址属性
        System.setProperty("MyWebUrl", UtilResourceBasePath.getResourcePath());
        //System.out.println(System.getProperty("MyWebUrl"));

        //添加多线程防止出现线程安全问题
        if (session.getAttribute("synNews") == null) {
            session.setAttribute("synNews", new Object());
        }
        //获取标记新闻
        List<News> newsList = null;
        synchronized (session.getAttribute("synNews")) {
            newsList = newsService.selectNewsByMark(1);
        }
        //将数据传给前端
        session.setAttribute("news", newsList);
        session.setAttribute("indexMark", true);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("Newindex");
        return mv;
    }

//    /*新闻详情跳转*/
//    @RequestMapping("/newsDetail")
//    public ModelAndView newsDetail(String newTitle,HttpServletRequest request,
//                                   HttpSession session){
//        ModelAndView mv = new ModelAndView();
//        //获取新闻对象
//        List<News> news = newsService.selectNewByTitle(newTitle);
//        News news1 = news.get(0);
//
//        session.removeAttribute("news");
//        session.setAttribute("news",news1);
//
//        mv.setViewName("news/viewNewsDetail");
//        return mv;
//    }

}
