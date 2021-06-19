package jdlg.musicproject.service.impl;

import jdlg.musicproject.dao.AdminDao;
import jdlg.musicproject.entries.teacher.TeacherRegister;
import jdlg.musicproject.service.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    @Resource(name = "adminDao")
    AdminDao adminDao;

    @Override
    public TeacherRegister registerPermit() {
        return adminDao.selectAdminPermit();
    }

    @Override
    public List<String> queryTeacherRegisterCode() {
        return adminDao.selectTeacherRegisterCode();
    }

    @Override
    public int addTeacherRegisterCode(String code) {
        return adminDao.insertTeacherRegisterCode(code);
    }
}
