package jdlg.musicproject.controller.doteacher;

import jdlg.musicproject.entries.common.ForumAnswer;
import jdlg.musicproject.entries.common.ForumQuestion;
import jdlg.musicproject.service.ForumService;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/doTeacher")
public class DoForum {
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;
    @Autowired
    private ForumService forumService;

    @GetMapping("/indexForum")
    public ModelAndView indexForum(Model model) {
        model.addAttribute("Context", UtilTeacherWebURI.forumTeacher.getUri());
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index/index-teacher");
        return mv;
    }

    @PostMapping("/showQuestion")
    @ResponseBody
    public List<ForumQuestion> showQuestion(Integer cId, Integer qId, Integer indexAnswer, Integer answerPageSize) {
        return forumService.queryForumQuestionByCId(cId, true, qId, indexAnswer, answerPageSize);
    }

    @PostMapping("/showQueIdByCid")
    @ResponseBody
    public Map<Integer, List<Integer>> showQueIdByCid(Integer cId, Integer index, Integer pageSize) {
        return forumService.selectForumIdByCId(cId, null,index, pageSize);
    }

    @PostMapping("/findQueIdByCid")
    @ResponseBody
    public Map<Integer, List<Integer>> findQueIdByCid(Integer cId,String find, Integer index, Integer pageSize) {
        return forumService.selectForumIdByCId(cId, find,index, pageSize);
    }

    @GetMapping("/showQuestionDetail")
    public ModelAndView showQuestionDetail(HttpServletRequest request) {
        Integer queId = Integer.parseInt(request.getParameter("queId"));
        if (queId != null && request.getParameter("cId") != null) {
            Integer commentCount = forumService.queryForumCommentCountByQid(queId);
            ModelAndView mv = new ModelAndView();
            mv.addObject("commentCount", commentCount);
            mv.addObject("Context", UtilTeacherWebURI.forumTeacherDetail.getUri());
            mv.setViewName("index/index-teacher");
            return mv;
        } else
            return null;
    }

    @PostMapping("/questionDetail")
    @ResponseBody
    public List<ForumQuestion> questionDetail(Integer cId, Integer queId, Integer indexAnswer, Integer answerPageSize) {
        return forumService.queryForumQuestionByCId(cId, null, queId, indexAnswer, answerPageSize);
    }

    @Transactional
    @PostMapping(value = "/submitComment",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String submitComment(ForumAnswer answer) {
        if (answer != null) {
            return forumService.addForumAnswer(answer);
        } else return "????????????????????????";
    }

    @Transactional
    @PostMapping(value = "/submitQuestion",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String submitQuestion(ForumQuestion question){
        return forumService.addForumQuestion(question);
    }

    @Transactional
    @PostMapping(value = "/deleteQuestion",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String deleteQuestion(Integer queId){
        return forumService.deleteForumByQuestionId(queId);
    }
}
