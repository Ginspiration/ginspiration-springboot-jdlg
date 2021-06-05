package jdlg.musicproject.controller.doteacher;

import jdlg.musicproject.entries.common.CoursePlus;
import jdlg.musicproject.entries.student.Student;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface TeacherCourseController {

    /*注：tId是在当前教师登录时，放在session里面的，通过session.getAttribute("tId")获取，tName同理，分别是教师id，和教师名称*/

    /**
     * 添加课程
     *
     * @param coursePlus
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示添加结果
     * produces = "application/json;charset=UTF-8" ：设置返回客户端的数据类型，这里表示UTF-8的字符串，前端ajax中 dataType："text"
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    String addCourse(CoursePlus coursePlus, HttpSession session);

    /**
     * 删除课程
     *
     * @param cId 课程id
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示删除结果
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    String deleteCourse(Integer cId, HttpSession session);

    /**
     * 更新课程名，课程id
     *
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示修改结果
     */
    @Transactional
    @RequestMapping(produces = "application/json;charset=UTF-8")
    @ResponseBody
    String modifyCourse(CoursePlus coursePlus, HttpSession session);

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
    String CourseCompleted(Integer cId, Integer status, HttpSession session);

    /**
     * 查看所有选择了这门课程的学生
     *
     * @param cId 课程id
     * @return
     */
    @ResponseBody
    List<Student> showStuInCourse(Integer cId);

    /**
     * 通过课程名来查找课程
     *
     * @param cName 课程名
     * @return
     */
    @ResponseBody
    List<CoursePlus> findCourseByName(String cName, HttpSession session);
}
