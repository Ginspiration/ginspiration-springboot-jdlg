package jdlg.musicproject.controller.index;

import jdlg.musicproject.entries.common.News;
import jdlg.musicproject.service.NewsService;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UseIndex {

    @Resource(name = "newsServiceImpl")
    private NewsService newsService;


    /**
     * 跳转index页面，传递数据
     * @param session
     * @param request
     * @return
     */
    @RequestMapping("index")
    public ModelAndView index(HttpSession session,HttpServletRequest request){
        //获取标记新闻
        List<News> newsList = newsService.selectNewsByMark(1);

        //将数据传给前端
        session.setAttribute("news",newsList);
        session.setAttribute("indexMark",true);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("Newindex");
        return mv;
    }

    /*新闻详情跳转*/
    @RequestMapping("/newsDetail")
    public ModelAndView newsDetail(String newTitle,HttpServletRequest request,
                                   HttpSession session){
        ModelAndView mv = new ModelAndView();
        //获取新闻对象
        List<News> news = newsService.selectNewByTitle(newTitle);
        News news1 = news.get(0);

        session.removeAttribute("news");
        session.setAttribute("news",news1);

        mv.setViewName("news/viewNewsDetail");
        return mv;
    }

}
