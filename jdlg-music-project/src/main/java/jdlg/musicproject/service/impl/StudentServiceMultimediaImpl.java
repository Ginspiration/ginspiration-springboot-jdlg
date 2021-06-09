package jdlg.musicproject.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import jdlg.musicproject.dao.TeacherDao;
import jdlg.musicproject.dao.TeacherDaoMultimedia;
import jdlg.musicproject.entries.teacher.TeacherKnowledge;
import jdlg.musicproject.service.StudentServiceMultimedia;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StudentServiceMultimediaImpl implements StudentServiceMultimedia {
    @Resource(name = "teacherDao")
    private TeacherDao teacherDao;
    @Resource(name = "teacherDaoMultimedia")
    private TeacherDaoMultimedia teacherDaoMultimedia;

    @Override
    public Map<Integer, List<TeacherKnowledge>> showAllKnow(Integer cId, Integer index) {
        if (cId != null && index != null) {
            int size = 5;
            Page<Object> pageHelper = PageHelper.startPage(index,size);
            List<TeacherKnowledge> knowledge = teacherDaoMultimedia.selectAllKnow(cId);
            int totalPage = pageHelper.getPages();
            List<TeacherKnowledge> knowTemp = new ArrayList<>(50);
            int i = 0;
            for (TeacherKnowledge k : knowledge) {
                TeacherKnowledge know = new TeacherKnowledge();
                /*获取图片数量*/
                File file = new File(k.getImgUrl());
                if (file.listFiles() != null) {
                    know.setImgNumber(file.listFiles().length);
                }
                know.setId(i);
                know.setImgUrl(k.getImgUrl());
                know.setUpTime(k.getUpTime());
                String temp = k.getContext().replace("\n", "</br>").replace(" ", "&nbsp");
                know.setContext(temp);
                know.setTitle(k.getTitle());
                knowTemp.add(know);
                i++;
            }
            Map<Integer, List<TeacherKnowledge>> map = new HashMap<>(1);
            map.put(totalPage,knowTemp);
            return map;
        }else
            return null;
    }
}
