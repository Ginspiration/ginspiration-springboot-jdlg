package jdlg.musicproject.service;

import jdlg.musicproject.entries.teacher.TeacherAppreciate;
import jdlg.musicproject.entries.teacher.TeacherKnowAll;
import jdlg.musicproject.entries.teacher.TeacherKnowledge;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface TeacherServiceMultimedia {
    /**
     * 音乐基础理论知识
     */
    /*添加理论知识*/
    String addKnow(TeacherKnowledge knowledge);

    /*删除理论知识*/
    String deleteKnow(String title, Integer cId, Integer tId);

    /*修改理论知识*/
    String modifyKnow(TeacherKnowledge knowledge);

    /*查找理论知识*/
    List<TeacherKnowledge> findKnow(String index, Integer cId);

    /*显示所有*/
    List<TeacherKnowledge> showAllKnow(Integer cId);

    /*转储文件*/
    String saveFiles(MultipartFile[] files, Integer tId, Integer cId, String title);

    /*从数据库获取文件*/
    Map<Integer, List<TeacherKnowAll>> showImg(Integer cId, Integer index, Integer size);

    /**
     * 音乐鉴赏 用同一个网页进行显示
     */
    //添加记录
    String addAppreciate(TeacherAppreciate appreciate, Integer tId);

    //删除记录
    String deleteAppreciate(String title, Integer tId, Integer cId);

    //查找记录
    List<TeacherAppreciate> findAppreciate(String title, Integer cId);

    //显示所有
    List<TeacherAppreciate> showAllAppreciate(Integer cId,Integer index);
}
