package jdlg.musicproject.dao;

import jdlg.musicproject.entries.common.WorkExplain;
import jdlg.musicproject.entries.student.*;
import jdlg.musicproject.entries.common.Courses;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentDao {

    /*添加基本数据*/
    int insertStudent(Student student);

    /*添加账号密码*/
    int insertStuAdmin(StudentAdmin stuAdmin);

    /*学生是否被禁用*/
    Integer usedStudent(@Param("s_id") Integer stuId);

    /*通过学号获取学生密码和姓名*/
    StudentNamePwd selectStuPwdById(@Param("stu_id") Integer stuId);

    /*通过学生Id查找课程*/
    List<Courses> selectAllCourses(@Param("stu_id") Integer sId);

    /*为学生添加课程*/
    int insertStuCourse(StudentCourse course);

    /*获取一门课程的所有作业次数*/
    List<WorkExplain> selectAllExplain(@Param("c_id") Integer cId);

    /*将作业添加到成绩表*/
    int insertGrade(StudentGrade grade);

    /*获取学生成绩，如果返回值为null，则未完成*/
    List<StudentGrade> selectGrade(@Param("sId") Integer sId);

    /*添加成绩*/
    int updateGrade(StudentGrade grade);

    /*插入学生答案*/
    int insertAnswer(StudentQAnswer answer);

    /*获取学生答案*/
    StudentQAnswer selectAnswer(@Param("qId") Integer qId, @Param("sId") Integer sId);

}
