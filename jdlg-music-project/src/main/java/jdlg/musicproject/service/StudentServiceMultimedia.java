package jdlg.musicproject.service;



import jdlg.musicproject.entries.teacher.TeacherKnowledge;

import java.util.List;
import java.util.Map;

public interface StudentServiceMultimedia {
    /*获取所有知识点*/
    Map<Integer,List<TeacherKnowledge>> showAllKnow(Integer cId, Integer index);
}
