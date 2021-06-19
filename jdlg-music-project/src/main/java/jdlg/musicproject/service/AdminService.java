package jdlg.musicproject.service;


import jdlg.musicproject.entries.teacher.TeacherRegister;

import java.util.List;

public interface AdminService {
    /**
     * 管理员
     * @return
     */
    TeacherRegister registerPermit();
    /**
     * 教师邀请码
     */
    List<String> queryTeacherRegisterCode();

    /**
     * 添加邀请码
     * @param code
     * @return
     */
    int addTeacherRegisterCode(String code);
}
