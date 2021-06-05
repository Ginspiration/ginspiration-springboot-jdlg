package jdlg.musicproject.dao;

import jdlg.musicproject.entries.teacher.TeacherRegister;
import org.apache.ibatis.annotations.Param;

public interface AdminDao {
    TeacherRegister selectAdminPermit();
}
