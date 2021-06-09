package jdlg.musicproject.dao;

import jdlg.musicproject.entries.common.CoursePlus;
import org.apache.ibatis.annotations.Param;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface StudentCourseDao {
    /**
     * 列出所有课程，工具方法
     *
     * @return
     */
    List<CoursePlus> selectAllCourse();

    /**
     * 根据课程id查询课程信息
     * @param cId cid
     * @return CoursePlus
     */
    CoursePlus selectCourseById(@Param("cId") Integer cId);


    /**
     * 添加课程，往stu_course表中添加数据
     *
     * @param cId 课程
     * @param sId 学生
     * @return
     */
    int insertCourse(@Param("c_id") Integer cId, @Param("s_id") Integer sId);

    /**
     * 退选课程，在stu_course表中删除一条记录
     * @param cId 课程id
     * @param sId 学生id
     * @return
     */
    int deleteCourse(@Param("c_id") Integer cId, @Param("s_id") Integer sId);

    /**
     * 查询课程，根据Status查询，stu_course_status字段值=1：完结课程，字段=0：在学课程
     *
     * @param sId
     * @return
     */
    List<CoursePlus> selectCourseByStatus(@Param("sId") Integer sId, @Param("status") Integer status);

    /**
     * 查询课程，根据courseName模糊查询
     *
     * @param sId        studentID
     * @param courseName courseName
     * @return List<CoursePlus>
     */
    List<CoursePlus> selectCourseByCourseName(@Param("sId") Integer sId, @Param("courseName") String courseName);


    /**
     * 根据课程id和 学生id 查询课程状态
     * @param cId cid
     * @param sId sid
     * @return status
     */
    int selectCourseStatusByCIdAndSId(@Param("cId") Integer cId, @Param("sId") Integer sId);

    /**
     * 根据课程id查询教师id
     * @param cId
     * @return
     */
    String selectTNameByCourse(@Param("cId") Integer cId);

}
