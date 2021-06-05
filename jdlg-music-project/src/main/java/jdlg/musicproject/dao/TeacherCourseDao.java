package jdlg.musicproject.dao;

import jdlg.musicproject.entries.common.CoursePlus;
import jdlg.musicproject.entries.student.Student;
import jdlg.musicproject.entries.teacher.TeacherCourse;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherCourseDao {

    /*
     *
     * 注：一个教师对应多个课程,
     *
     */

    /**
     * 获取当前教师所教的所有课程，联合tch_course表和course表进行查询
     *
     * @param tId
     * @return
     */
    List<CoursePlus> selectCoursePlus(@Param("t_id") Integer tId);

    /**
     * 添加课程 往course表中添加数据,同时向tch_course表中添加数据
     *
     * @param coursePlus 这个类中包含了
     * @return
     */
    int insertCourse(CoursePlus coursePlus);
    int insertTchCourse(TeacherCourse course);//配合insertCourse()

    /**
     * 删除课程，在course表中删除一条记录，前提是tch_course表中，这门课程是当前教师所教的
     *
     * @param cId 课程id 下面方法同理
     * @param tId 教师id 下面方法同理
     * @return
     */
    int deleteCourse(@Param("c_id") Integer cId, @Param("t_id") Integer tId);

    /**
     * 通过cId获取tId,工具方法,返回为空说明当前教师没有该课程
     * Integer selectTidBycId(@Param("c_id") Integer cId);
     *
     * @param cId
     * @return
     */
    Integer selectTidBycId(@Param("c_id") Integer cId);

    /**
     * 更新课程名，课程id,修改course表 前提是tch_course表中，这门课程是当前教师所教的，用selectTidBycId()
     *
     * @return
     */
    int updateCourse(CoursePlus coursePlus);

    /**
     * 将课程设置为完结，用stu_course关系表，修改stu_course_status字段，前提是tch_course表中，这门课程是当前教师所教的，用selectTidBycId()
     *
     * @param cId
     * @param tId
     * @param status 0代表为完结，1代表已完结
     * @return
     */
    int updateCourseComplete(@Param("c_id") Integer cId, @Param("t_id") Integer tId, @Param("status") Integer status);

    /**
     * 查看所有选择了这门课程的学生
     *
     * @param cId 课程id
     * @return
     */
    List<Student> selectStuInCourse(Integer cId);

    /**
     * 通过课程名来查找课程，数据库用 %like% 模糊查找，在tch_course表中联合course表查找，只显示当前教师自己的课程
     *
     * @param cName 课程名
     * @param tId   教师Id
     * @return
     */
    List<CoursePlus> findCourseByName(@Param("c_name") String cName, @Param("t_id") Integer tId);
}
