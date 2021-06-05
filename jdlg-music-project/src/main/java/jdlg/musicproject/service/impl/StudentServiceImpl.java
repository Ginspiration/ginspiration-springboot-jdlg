package jdlg.musicproject.service.impl;

import jdlg.musicproject.dao.StudentDao;
import jdlg.musicproject.entries.student.*;
import jdlg.musicproject.entries.common.Courses;
import jdlg.musicproject.service.StudentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {
    @Resource(name = "studentDao")
    StudentDao studentDao;

    @Override
    public int addStudent(Student student) {
        return studentDao.insertStudent(student);
    }

    @Override
    public int regStudent(StudentAdmin stuAdmin) {
        return studentDao.insertStuAdmin(stuAdmin);
    }

    @Override
    public StudentNamePwd stuLoginById(Integer stuId) {
        return studentDao.selectStuPwdById(stuId);
    }

    @Override
    public Integer usedStudent(Integer sId) {
        return studentDao.usedStudent(sId);
    }

    @Override
    public List<Courses> showStuCourses(Integer sId) {
        return studentDao.selectAllCourses(sId);
    }

    @Override
    public int addCourse(StudentCourse course) {
        return studentDao.insertStuCourse(course);
    }

    @Override
    public int addGradeRecord(StudentGrade grade) {
        return studentDao.insertGrade(grade);
    }

    @Override
    public List<StudentGrade> showGrade(Integer sId) {
        return studentDao.selectGrade(sId);
    }

    @Override
    public int addGrade(StudentGrade grade) {
        return studentDao.updateGrade(grade);
    }

    @Override
    public int recordAnswer(StudentQAnswer answer) {
        return studentDao.insertAnswer(answer);
    }

    @Override
    public StudentQAnswer showAnswer(Integer qId, Integer sId) {
        return studentDao.selectAnswer(qId, sId);
    }
}
