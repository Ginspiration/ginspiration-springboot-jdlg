package jdlg.musicproject.dao;

import jdlg.musicproject.entries.common.CoursePlus;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentCourseDao {
    /**
     * 列出所有课程，工具方法
     *
     * @return
     */
    List<CoursePlus> selectAllCourse();

    /**
     * 显示学生所有选择的课程,在stu_course，course表中通过学生id获取课程信息
     *
     * @param sId 学生Id
     * @return
     */
    List<CoursePlus> selectChosenCourse(@Param("s_id") Integer sId);


    /**
     * 添加课程，往stu_course表中添加数据
     *
     * @param cId 课程
     * @param sId 学生
     * @return
     */
    int insertCourse(@Param("c_id") Integer cId, @Param("s_id") Integer sId);

    /**
     * 显示所有已经完结的课程，列出stu_course表中，stu_course_status 字段值为1的记录
     *
     * @param sId 学生id
     * @return
     */
    List<CoursePlus> selectCompletedCourse(@Param("s_id") Integer sId);


    /**
     * 退选课程，在stu_course表中删除一条记录
     *
     * @param cId 课程id
     * @param sId 学生id
     * @return
     */
    int deleteCourse(@Param("c_id") Integer cId, @Param("s_id") Integer sId);
}
