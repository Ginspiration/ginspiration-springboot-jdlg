package jdlg.musicproject.dao;

import jdlg.musicproject.entries.student.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherDaoManageStudent {

    /*删除学员、搜索学员、修改学员、重置密码*/

    /**
     * 通过学生姓名模糊查找
     * @return
     */
    List<Student> selectStudentsByName(@Param("sName")String sName);

    /**
     * 删除学员，需要管理员身份
     * @param sId
     * @return
     */
    int deleteStudentBysId(@Param("sId")Integer sId);

//    /**
//     * 更新学员，需要管理员身份
//     * @param student
//     * @return
//     */
//    int updateStudent(Student student);

    /**
     * 通过课程重置学员，需要管理员身份
     * @param cId
     * @return
     */
    int resetPasswordBycId(@Param("cId")Integer cId,@Param("password")String password);

    /**
     * 重置所有学员密码，需要管理员身份
     * @return
     */
    int resetPasswordAllStudent(@Param("password")String password);

    /**
     * 重置单个学生的密码
     * @param sId
     * @return
     */
    int resetPasswordBysId(@Param("sId")Integer sId,@Param("password")String password);
}
