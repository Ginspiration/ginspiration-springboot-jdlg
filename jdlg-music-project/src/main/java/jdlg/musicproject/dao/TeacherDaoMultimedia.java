package jdlg.musicproject.dao;

import jdlg.musicproject.entries.teacher.TeacherAppreciate;
import jdlg.musicproject.entries.teacher.TeacherKnowledge;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherDaoMultimedia {
    /**
     * 音乐基础理论知识
     */
    /*添加理论知识*/
    int insertKnow(TeacherKnowledge knowledge);

    /*删除理论知识*/
    int deleteKnow(@Param("k_title") String title, @Param("k_cid") Integer cId);

    /*修改理论知识*/
    int modifyKnow(TeacherKnowledge knowledge);

    /*查找理论知识*/
    List<TeacherKnowledge> seekKnow(@Param("k_index") String index, @Param("k_cid") Integer cId);

    /*显示所有*/
    List<TeacherKnowledge> selectAllKnow(@Param("k_cid") Integer cId);


    /**
     * 音乐鉴赏 用同一个网页进行显示
     */
    //添加记录
    int insertAppreciate(TeacherAppreciate appreciate);

    //删除记录
    int deleteAppreciate(@Param("app_title") String title,@Param("app_cId")Integer cId);

    //查找记录
    List<TeacherAppreciate> findAppreciate(@Param("app_title") String title, @Param("app_cId") Integer cId);

    //显示所有
    List<TeacherAppreciate> selectAllAppreciate(@Param("app_cId") Integer cId);
}
