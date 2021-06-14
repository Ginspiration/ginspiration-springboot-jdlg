package jdlg.musicproject.service;

import jdlg.musicproject.entries.student.Student;

import java.util.List;

public interface TeacherServiceManageStudent {
    /*删除学员、搜索学员、修改学员、重置密码*/

    /**
     * 通过学生姓名模糊查找
     * @return
     */
    List<Student> queryStudentsByName(String sName);

    /**
     * 删除学员，需要管理员身份
     * @param sId
     * @return
     */
    String deleteStudentBysId(Integer sId);

//    /**
//     * 更新学员，需要管理员身份
//     * @param student
//     * @return
//     */
//    String updateStudent(Student student);

    /**
     * 通过课程重置学员，需要管理员身份
     * @param cId
     * @return
     */
    String resetPasswordBycId(Integer cId,String password);

    /**
     * 重置所有学员密码，需要管理员身份
     * @return
     */
    String resetPasswordAllStudent(String password);

    /**
     * 重置单个学生的密码
     * @param sId
     * @return
     */
    String resetPasswordBysId(Integer sId,String password);
}
