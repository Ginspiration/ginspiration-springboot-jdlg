package jdlg.musicproject.service.impl;

import jdlg.musicproject.dao.TeacherDaoManageStudent;
import jdlg.musicproject.entries.student.Student;
import jdlg.musicproject.entries.student.StudentNamePwd;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherServiceManageStudent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeacherServiceManageStudentImpl implements TeacherServiceManageStudent {

    @Autowired
    private TeacherDaoManageStudent manageStudent;
    @Autowired
    private StudentService studentService;

    @Override
    public List<Student> queryStudentsByName(String sName) {
        if (sName != null) {
            return manageStudent.selectStudentsByName("%"+sName+"%");
        } else
            return null;
    }

    @Override
    public String deleteStudentBysId(Integer sId) {
        if (sId != null) {
            if (studentService.stuLoginById(sId) != null) {
                if (manageStudent.deleteStudentBysId(sId) != 1) {
                    return "系统错误，请重试";
                } else
                    return "删除成功";
            } else
                return "没有该学员";
        } else
            return "系统错误，请重试";
    }

    @Override
    public String resetPasswordBycId(Integer cId, String password) {
        if (cId != null && password != null) {
            if (manageStudent.resetPasswordBycId(cId, password) != 1) {
                return "系统错误，请重试";
            } else
                return "重置成功";
        } else
            return "系统错误，请重试";
    }

    @Override
    public String resetPasswordAllStudent(String password) {
        if (password != null) {
            manageStudent.resetPasswordAllStudent(password);
            return "所有学生密码重置成功";
        } else
            return "系统错误，请重试";
    }

    @Override
    public String resetPasswordBysId(Integer sId, String password) {
        if (sId != null && password != null) {
            if (studentService.stuLoginById(sId) != null) {
                if (manageStudent.resetPasswordBysId(sId, password) != 1) {
                    return "系统错误，请重试";
                } else
                    return "该学生密码重置成功";
            } else
                return "没有该学员";
        } else
            return "系统错误，请重试";
    }
}
