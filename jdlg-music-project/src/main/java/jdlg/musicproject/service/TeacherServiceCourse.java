package jdlg.musicproject.service;

import jdlg.musicproject.entries.common.CoursePlus;
import jdlg.musicproject.entries.student.Student;
import jdlg.musicproject.entries.teacher.TeacherCourse;

import java.util.List;

public interface TeacherServiceCourse {
    /*注：所有业务的逻辑，建议尽量在Service层里面完成，Controller层里面尽量不要放业务逻辑，Controller层直接调用服务层的方法就行*/

    /**
     * 获取当前教师所教的所有课程
     *
     * @param tId
     * @return
     */
    List<CoursePlus> showCoursePlus(Integer tId);

    /**
     * 添加课程 其中，图片的地址 如果要用本地的图片，需要用到文件上传的一系列操作,在服务层里完成这个功能，如果用网络上的，可以忽略。
     *
     * @param coursePlus
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示添加结果
     */
    String addCourse(CoursePlus coursePlus, TeacherCourse course);

    /**
     * 删除课程 前提是，这门课程是当前教师所教的，可以用下面的方法showTidBycId()判断
     *
     * @param cId
     * @param tId
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示删除结果
     */
    String deleteCourse(Integer cId, Integer tId);

    /**
     * 通过cId获取tId
     *
     * @param cId
     * @return
     */
    Integer showTidBycId(Integer cId);

    /**
     * 前提 这门课程是当前教师所教的，用方法showTidBycId()判断
     * 更新课程名，课程id
     *
     * @param tId
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示修改结果
     */
    String modifyCourse(CoursePlus coursePlus, Integer tId);

    /**
     * 将课程设置为完结 前提 这门课程是当前教师所教的，用方法showTidBycId()判断
     *
     * @param cId
     * @param tId
     * @param status 0代表为完结，1代表已完结
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示修改结果
     */
    String CourseCompleted(Integer cId, Integer tId, Integer status);

    /**
     * 查看所有选择了这门课程的学生
     *
     * @param cId 课程id
     * @return
     */
    List<Student> showStuInCourse(Integer cId);

    /**
     * 通过课程名来查找课程
     *
     * @param cName 课程名
     * @param tId   教师Id
     * @return
     */
    List<CoursePlus> findCourseByName(String cName, Integer tId);


}
