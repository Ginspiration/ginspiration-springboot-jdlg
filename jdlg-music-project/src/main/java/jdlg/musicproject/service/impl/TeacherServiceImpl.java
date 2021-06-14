package jdlg.musicproject.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import jdlg.musicproject.dao.TeacherDao;
import jdlg.musicproject.entries.common.Courses;
import jdlg.musicproject.entries.common.QuestionBank;
import jdlg.musicproject.entries.common.WorkExplain;
import jdlg.musicproject.entries.student.Student;
import jdlg.musicproject.entries.student.StudentCompletion;
import jdlg.musicproject.entries.teacher.Teacher;
import jdlg.musicproject.entries.teacher.TeacherAdmin;
import jdlg.musicproject.entries.teacher.TeacherCourse;
import jdlg.musicproject.entries.teacher.TeacherNamePwd;
import jdlg.musicproject.entries.web.WebManage;
import jdlg.musicproject.service.TeacherService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TeacherServiceImpl implements TeacherService {
    @Resource(name = "teacherDao")
    TeacherDao teacherDao;

    @Override
    public TeacherNamePwd tchLoginById(Integer tchId) {
        return teacherDao.selectTchNameById(tchId);
    }

    @Override
    public String queryNameBytId(Integer tId) {
        return teacherDao.selectNameBytId(tId);
    }

    @Override
    public int addTeacher(Teacher teacher) {
        return teacherDao.insertTeacher(teacher);
    }

    @Override
    public int addTchPwdName(TeacherAdmin tchAdmin) {
        return teacherDao.insertTchPwdName(tchAdmin);
    }

    @Override
    public int disableStudent(Integer sId) {
        return teacherDao.disableStudent(sId);
    }

    @Override
    public int ableStudent(Integer sId) {
        return teacherDao.ableStudent(sId);
    }

    @Override
    public List<Student> showAllStu() {
        return teacherDao.selectAllStu();
    }

    @Override
    public WebManage showWebMessage() {
        return teacherDao.webMessage();
    }

    @Override
    public int setUpWeb(WebManage webManage) {
        return teacherDao.webSubmit(webManage);
    }

    @Override
    public int addCourse(Courses courses) {
        return teacherDao.insertCourse(courses);
    }

    @Override
    public int bindTchCourse(TeacherCourse tchCourse) {
        return teacherDao.insertTchCourse(tchCourse);
    }

    @Override
    public Courses selectCourse(Integer courseId) {
        return teacherDao.selectCourses(courseId);
    }

    @Override
    public List<Courses> showAllCourses(Integer cId) {
        return teacherDao.selectAllCourses(cId);
    }

    @Override
    public List<Integer> showAllTimes(Integer cId) {
        return teacherDao.selectWorkTimes(cId);
    }

    @Override
    public int addQuestions(QuestionBank question) {
        return teacherDao.insertQuestions(question);
    }

    @Override
    public List<QuestionBank> showQuestionsByIndex(Integer cId, Integer timeNumber, Integer index, Integer size) {
        /*分页*/
        Page<Object> page = PageHelper.startPage(index, size);
        List<QuestionBank> questionBanks = teacherDao.selectQuestions(cId, timeNumber);
        /*获取总页数*/
        int totalPages = page.getPages();

        QuestionBank question = new QuestionBank();
        /*总页数放入对象*/
        question.setqId(totalPages);

        questionBanks.add(question);
        return questionBanks;
    }

    @Override
    public List<QuestionBank> showQuestions(Integer cId, Integer timeNumber) {
        return teacherDao.selectQuestions(cId, timeNumber);
    }

    @Override
    public int addExplain(WorkExplain explain) {
        return teacherDao.insertExplain(explain);
    }

    @Override
    public WorkExplain showExplain(Integer timeNumber, Integer cId) {
        return teacherDao.selectExplain(timeNumber, cId);
    }

    @Override
    public List<WorkExplain> showAllExplain(Integer cId) {
        return teacherDao.selectAllExplain(cId);
    }

    @Override
    public List<Student> showStuByCourse(Integer cId) {
        return teacherDao.selectStuByCourse(cId);
    }

    @Override
    public List<StudentCompletion> showGrade(Integer cId, Integer times) {
        return teacherDao.selectGrade(cId,times);
    }

    @Override
    public int deleteQuestion(Integer qId) {
        return teacherDao.deleteQuestion(qId);
    }

    @Override
    public int deleteExplain(Integer cId, Integer times) {
        return teacherDao.deleteExplain(cId,times);
    }

    @Override
    public List<StudentCompletion> showTotalGrade(Integer cId) {
        return teacherDao.selectTotalGrade(cId);
    }

    @Override
    public Integer showTotalTimes(Integer cId) {
        return teacherDao.selectTotalTimes(cId);
    }

    @Override
    public Integer selectTidBycId(Integer cId) {
        return teacherDao.selectTidBycId(cId);
    }
}
