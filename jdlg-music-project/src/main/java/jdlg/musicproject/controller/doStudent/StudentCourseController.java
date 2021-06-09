package jdlg.musicproject.controller.doStudent;

import jdlg.musicproject.entries.common.CoursePlus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface StudentCourseController {

    /*注：sId是在当前学生登录时，放在session里面的，通过session.getAttribute("sId")获取，sName同理，分别是学生id，和学生名称*/

    /**
     * 从导航栏到index-course.jsp
     *
     * @param model
     * @param session 获取studentID
     * @return index-course.jsp
     */
    @RequestMapping(produces = "application/json;charset=UTF-8")
    String courseIndex(Model model, HttpSession session);

    /**
     * 查询课程，根据Status查询
     *
     * @param session 获取studentID
     * @param status  stu_course_status字段值=1：完结课程； =0：在学课程；=null:全部课程
     * @return List<CoursePlus>
     */
    List<CoursePlus> selectCourseByStatus(HttpSession session, Integer status);

    /**
     * 根据课程名模糊查询该学生的课程
     *
     * @param session    获取学生id
     * @param courseName 课程名
     * @return List<CoursePlus>
     */
    List<CoursePlus> selectCourseByCourseName(HttpSession session, String courseName);

//    /**
//     * 添加课程
//     *
//     * @param cId
//     * @param session 获取学生id
//     * @return 返回String，通过Ajax显示添加结果，其中String尽量在Service层中返回，Controller层直接调用Service层的方法就行
//     *  1:添加成功； 0：添加失败
//     */
//    @Transactional
//    @RequestMapping(produces = "application/json;charset=UTF-8")
//    @ResponseBody
//    String addCourse(Integer cId, HttpSession session);


    /**
     * 退选课程，
     * @param cId 课程id
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示退选结果
     *  1:添加成功； 0：添加失败
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    int withdrawCourse(Integer cId, HttpSession session);

    /**
     * 课程详情 查询coursePlus, statue, tName
     * @param cId cId
     * @param session session
     * @return map
     */
    @RequestMapping(produces = "application/json;charset=UTF-8")
    Object toCourseDetails(Integer cId, HttpSession session);

}
