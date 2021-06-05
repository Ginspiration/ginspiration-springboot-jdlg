package jdlg.musicproject.dao;

import jdlg.musicproject.entries.common.ForumAnswer;
import jdlg.musicproject.entries.common.ForumQuestion;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ForumDao {

    /**
     * 添加提问
     *
     * @param
     * @return
     */
    int insertForumQuestion(ForumQuestion forumQuestion);

    /**
     * 参与回答问题
     *
     * @param
     * @return
     */
    int insertForumAnswer(ForumAnswer answer);

    /**
     * 获取分页的提问id
     * @param cId
     * @return
     */
    List<Integer> selectForumIdByCId(@Param("c_id")Integer cId,@Param("find")String find);

    /**
     * 通过课程id获取所有问题
     *
     * @param cId
     * @return
     */
    List<ForumQuestion> selectForumQuestionByCId(@Param("c_id") Integer cId,
                                                 @Param("HomePageFlag")Boolean ifHomePage,
                                                 @Param("q_id") Integer qId,
                                                 @Param("index_answer") Integer indexAnswer,
                                                 @Param("answer_page_size") Integer answerPageSize);

    /**
     * 删除论题
     *
     * @param queId
     * @return
     */
    int deleteForumByQuestionId(@Param("que_id") Integer queId);

    /**
     * 获取评论记录总条数
     * @param queId
     * @return
     */
    Integer selectForumCommentCountByQid(@Param("queId")Integer queId);

}
