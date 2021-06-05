package jdlg.musicproject.service;

import jdlg.musicproject.entries.student.*;
import jdlg.musicproject.entries.common.Courses;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentService {
    int addStudent(Student student);

    int regStudent(StudentAdmin stuAdmin);

    StudentNamePwd stuLoginById(Integer stuId);

    Integer usedStudent(Integer sId);

    /*查看学生已选课程*/
    List<Courses> showStuCourses(Integer sId);

    /*学生添加课程*/
    int addCourse(StudentCourse course);

    /*学生成绩表添加记录*/
    int addGradeRecord(StudentGrade grade);

    /*获取学生成绩，如果返回值为null，则未完成*/
    List<StudentGrade> showGrade(Integer sId);

    /*添加成绩*/
    int addGrade(StudentGrade grade);

    /*记录学生答案*/
    int recordAnswer(StudentQAnswer answer);

    /*获取学生答案*/
    StudentQAnswer showAnswer(Integer qId, Integer sId);
}
