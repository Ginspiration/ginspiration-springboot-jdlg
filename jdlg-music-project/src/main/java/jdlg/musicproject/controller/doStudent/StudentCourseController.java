package jdlg.musicproject.controller.doStudent;

import jdlg.musicproject.entries.common.CoursePlus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface StudentCourseController {

    /*注：sId是在当前学生登录时，放在session里面的，通过session.getAttribute("sId")获取，sName同理，分别是学生id，和学生名称*/


    /**
     * 显示学生所有选择的课程
     *
     * @return
     */
    @ResponseBody
    List<CoursePlus> showChosenCourse(HttpSession session);


    /**
     * 添加课程
     *
     * @param cId
     * @param session 获取学生id
     * @return 返回String，通过Ajax显示添加结果，其中String尽量在Service层中返回，Controller层直接调用Service层的方法就行
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    String addCourse(Integer cId, HttpSession session);

    /**
     * 显示所有已经完结的课程
     *
     * @return
     */
    @ResponseBody
    List<CoursePlus> showCompletedCourse(HttpSession session);

    /**
     * 退选课程，
     *
     * @param cId 课程id
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示退选结果
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    String withdrawCourse(Integer cId, HttpSession session);


}
