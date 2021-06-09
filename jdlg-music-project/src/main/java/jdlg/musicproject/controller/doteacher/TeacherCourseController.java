package jdlg.musicproject.controller.doteacher;

import jdlg.musicproject.entries.common.CoursePlus;
import jdlg.musicproject.entries.student.Student;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface TeacherCourseController {

    /*注：tId是在当前教师登录时，放在session里面的，通过session.getAttribute("tId")获取，tName同理，分别是教师id，和教师名称*/

    /**
     * 跳转到教师课程主页
     * @param session session
     * @return index-course.jsp
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    String indexCourse(Model model, HttpSession session);

    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    List selectTeacherCourse(HttpSession session);

    /**
     * 根据课程名模糊查询该学生的课程
     *
     * @param session    获取学生id
     * @param courseName 课程名
     * @return List<CoursePlus>
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    List<CoursePlus> selectCourseByCourseName(HttpSession session, String courseName);

    /**
     * 课程详情 查询coursePlus, statue, student
     * @param cId cId
     * @param session session
     * @return map
     */
    @RequestMapping(produces = "application/json;charset=UTF-8")
    Object toCourseDetails(Integer cId, HttpSession session);

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
     * 根据课程id查询课程是否存在（系统中是否有）
     * @param cId cId
     * @return int
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    int selectCourseByCId(Integer cId);

    /**
     * 添加课程
     *
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示添加结果
     * produces = "application/json;charset=UTF-8" ：设置返回客户端的数据类型，这里表示UTF-8的字符串，前端ajax中 dataType："text"
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    int addCourse(Integer cId, String cName, HttpSession session);

    /**
     *  为当前教师添加课程
     * @param cId
     * @param session
     * @return
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    int addTchCourse(Integer cId, HttpSession session);
//
//    /**
//     * 删除课程
//     *
//     * @param cId 课程id
//     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示删除结果
//     */
//    @Transactional
//    @RequestMapping(produces = "application/json;charset=UTF-8")
//    @ResponseBody
//    String deleteCourse(Integer cId, HttpSession session);
//
    /**
     * 更新课程名，课程id
     *
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示修改结果
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    int modifyCourse(Integer cId,String cName);
//
    /**
     * 将课程设置为完结
     *
     * @param cId
     * @param status 0代表为完结，1代表已完结
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示修改结果
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    int CourseCompleted(Integer cId, Integer status, HttpSession session);
//
//    /**
//     * 查看所有选择了这门课程的学生
//     *
//     * @param cId 课程id
//     * @return
//     */
//    @ResponseBody
//    List<Student> showStuInCourse(Integer cId);
//
//    /**
//     * 通过课程名来查找课程
//     *
//     * @param cName 课程名
//     * @return
//     */
//    @ResponseBody
//    List<CoursePlus> findCourseByName(String cName, HttpSession session);
}
