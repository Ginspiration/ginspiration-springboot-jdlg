package jdlg.musicproject.service;

import jdlg.musicproject.entries.common.CoursePlus;

import java.util.List;

public interface StudentServiceCourse {
    /**
     * 列出所有课程，工具方法
     *
     * @return
     */
    List<CoursePlus> showAllCourse();

    /**
     * 显示学生所有选择的课程
     *
     * @param sId 学生Id
     * @return
     */
    List<CoursePlus> showChosenCourse(Integer sId);

    /**
     * 添加课程，前提是课程表中有这个课程，用showAllCourse()查询
     *
     * @param cId 课程
     * @param sId 学生
     * @return
     */
    int addCourse(Integer cId, Integer sId);

    /**
     * 显示所有已经完结的课程
     *
     * @param sId
     * @return
     */
    List<CoursePlus> showCompletedCourse(Integer sId);

    /**
     * 退选课程，
     *
     * @param cId 课程id
     * @param sId 学生id
     * @return String 在处理完逻辑后，给前端页面返回一个String，弹出窗口，显示退选结果
     */
    String withdrawCourse(Integer cId, Integer sId);
}
