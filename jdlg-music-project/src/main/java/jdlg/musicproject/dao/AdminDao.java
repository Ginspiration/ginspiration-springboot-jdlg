package jdlg.musicproject.dao;

import jdlg.musicproject.entries.teacher.TeacherRegister;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminDao {
    /**
     * 网站管理权限
     * @return
     */
    TeacherRegister selectAdminPermit();

    /**
     * 教师注册邀请码
     * @return
     */
    List<String> selectTeacherRegisterCode();

    /**
     * 管理员添加邀请码
     * @param code
     * @return
     */
    int insertTeacherRegisterCode(@Param("code") String code);
}
