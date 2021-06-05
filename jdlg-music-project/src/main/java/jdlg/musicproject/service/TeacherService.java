package jdlg.musicproject.service;

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

public interface TeacherService {
    //String teacherLogin(String tName);
    TeacherNamePwd tchLoginById(Integer tchId);

    String queryNameBytId(@Param("t_id")Integer tId);

    int addTeacher(Teacher teacher);

    int addTchPwdName(TeacherAdmin tchAdmin);

    /*禁用学生*/
    int disableStudent(Integer sId);

    /*启用学生*/
    int ableStudent(Integer sId);

    /*显示所有学生*/
    List<Student> showAllStu();

    /*查看网站情况*/
    WebManage showWebMessage();

    /*设置网站*/
    int setUpWeb(WebManage webManage);

    /*添加课程*/
    int addCourse(Courses courses);

    /*绑定教师课程*/
    int bindTchCourse(TeacherCourse tchCourse);

    /*获取一门课程*/
    Courses selectCourse(Integer courseId);

    /*获取所有课程*/
    List<Courses> showAllCourses(Integer tId);

    /*获取当前课程作业总次数*/
    List<Integer> showAllTimes(Integer cId);

    /*往题库加题目*/
    int addQuestions(QuestionBank question);

    /*根据课程iD和次数获取作业,分页*/
    List<QuestionBank> showQuestionsByIndex(Integer cId, Integer timeNumber,Integer index,Integer size);

    /*根据课程iD和次数获取作业*/
    List<QuestionBank> showQuestions(Integer cId, Integer timeNumber);

    /*添加当前作业描述*/
    int addExplain(WorkExplain explain);

    /*查找作业描述 通过次数和课程*/
    WorkExplain showExplain(Integer timeNumber, Integer cId);

    /*展示所有作业描述*/
    List<WorkExplain> showAllExplain(Integer cId);

    /*查看选择这门课程的学生*/
    List<Student> showStuByCourse(Integer cId);

    /*完成情况，获取这门课程学生成绩*/
    List<StudentCompletion> showGrade(Integer cId, Integer times);

    /*通过题目id删除题目*/
    int deleteQuestion(Integer qId);

    /*删除作业描述*/
    int deleteExplain(Integer cId,Integer times);

    /*获取单门课程学生总分*/
    List<StudentCompletion> showTotalGrade(Integer cId);

    /*获取这门课程发布的作业总次数*/
    Integer showTotalTimes(Integer cId);

    /*通过cId获取tId*/
    Integer selectTidBycId(Integer cId);
}
