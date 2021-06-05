package jdlg.musicproject.dao;

import jdlg.musicproject.entries.common.Courses;
import jdlg.musicproject.entries.common.QuestionBank;
import jdlg.musicproject.entries.common.WorkExplain;
import jdlg.musicproject.entries.student.Student;
import jdlg.musicproject.entries.student.StudentCompletion;
import jdlg.musicproject.entries.student.StudentGrade;
import jdlg.musicproject.entries.teacher.*;
import jdlg.musicproject.entries.web.WebManage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherDao {
    //String selectTeacherPwd(@Param("t_name") String tName);
    TeacherNamePwd selectTchNameById(@Param("t_id") Integer tId);

    String selectNameBytId(@Param("t_id")Integer tId);

    int insertTeacher(Teacher teacher);

    int insertTchPwdName(TeacherAdmin tchAdmin);

    /*禁用学生*/
    int disableStudent(@Param("s_id") Integer sId);

    /*启用学生*/
    int ableStudent(@Param("s_id") Integer sId);

    /*查找所有学生*/
    List<Student> selectAllStu();

    /*查询网站信息*/
    WebManage webMessage();

    /*设置网站信息*/
    int webSubmit(WebManage manage);

    /*添加课程*/
    int insertCourse(Courses courses);

    /*将教师信息和课程绑定*/
    int insertTchCourse(TeacherCourse tchCourse);

    /*获取一门课程*/
    Courses selectCourses(@Param("course_id") Integer courseId);

    /*获取所有课程*/
    List<Courses> selectAllCourses(@Param("course_id") Integer cId);

    /*获取作业总次数*/
    List<Integer> selectWorkTimes(@Param("course_id") Integer cId);

    /*往题库加题目*/
    int insertQuestions(QuestionBank question);

    /*获取题库所有作业*/
    List<QuestionBank> selectQuestions(@Param("course_id") Integer cId, @Param("times") Integer timeNumber);

    /*添加当前作业描述*/
    int insertExplain(WorkExplain explain);

    /*查找作业描述,判断这次作业是否被添加*/
    WorkExplain selectExplain(@Param("times") Integer timeNumber, @Param("course_id") Integer cId);

    /*查找作业描述,展示在往期页面*/
    List<WorkExplain> selectAllExplain(@Param("c_id") Integer cId);

    /*查看选择这门课程的学生*/
    List<Student> selectStuByCourse(@Param("c_id") Integer cId);

    /*完成情况，获取这门课程学生成绩*/
    List<StudentCompletion> selectGrade(@Param("c_id") Integer cId, @Param("times") Integer times);

    /*通过题目id删除题目*/
    int deleteQuestion(@Param("q_id")Integer qId);

    /*删除作业描述*/
    int deleteExplain(@Param("c_id")Integer cId,@Param("times")Integer times);

    /*获取单门课程学生总分*/
    List<StudentCompletion> selectTotalGrade(@Param("c_id")Integer cId);

    /*获取这门课程发布的作业总次数*/
    Integer selectTotalTimes(@Param("c_id")Integer cId);

    /*通过cId获取tId*/
    Integer selectTidBycId(@Param("c_id")Integer cId);
}
