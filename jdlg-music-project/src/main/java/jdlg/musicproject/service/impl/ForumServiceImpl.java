package jdlg.musicproject.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import jdlg.musicproject.dao.ForumDao;
import jdlg.musicproject.entries.common.ForumAnswer;
import jdlg.musicproject.entries.common.ForumQuestion;
import jdlg.musicproject.service.ForumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ForumServiceImpl implements ForumService {

    @Autowired
    private ForumDao forumDao;

    private static final String success = "提问成功！";
    private static final String answer = "参与讨论成功！";
    private static final String systemError = "系统错误,请重试";
    private static final String delete = "删除成功！";

    @Override
    public String addForumQuestion(ForumQuestion forumQuestion) {
        if (forumQuestion != null) {
            forumQuestion.setContext(forumQuestion.getContext().replace("'","\'").replace("\n","<br/>"));
            if (forumDao.insertForumQuestion(forumQuestion) != 1)
                return systemError;
            else
                return success;
        } else
            return systemError;
    }

    @Override
    public String addForumAnswer(ForumAnswer answer) {
        if (answer != null) {
            answer.setAnswer(answer.getAnswer().replace("'","\'").replace("\n","<br/>"));
            if (forumDao.insertForumAnswer(answer) != 1)
                return systemError;
            else
                return this.answer;
        } else
            return systemError;
    }

    @Override
    public Map<Integer, List<Integer>> selectForumIdByCId(Integer cId,String find ,Integer index, Integer pageSize) {
        if (cId != null && index != null && pageSize != null) {
            Map<Integer, List<Integer>> map = new HashMap<>(1);
            Page<Object> page = PageHelper.startPage(index, pageSize);
            List<Integer> queIds = null;
            if (find == null) {
                queIds = forumDao.selectForumIdByCId(cId,find);
            }else {
                queIds = forumDao.selectForumIdByCId(cId,"%"+find+"%");
            }
            map.put(page.getPages(), queIds);
            return map;
        } else
            return null;
    }

    @Override
    public List<ForumQuestion> queryForumQuestionByCId(Integer cId, Boolean homePageFlag, Integer qId, Integer indexAnswer, Integer answerPageSize) {
        if (cId != null && qId != null && indexAnswer != null && answerPageSize != null) {
            return forumDao.selectForumQuestionByCId(cId, homePageFlag, qId, indexAnswer, answerPageSize);
        } else
            return null;
    }

    @Override
    public String deleteForumByQuestionId(Integer queId) {
        if (queId != null) {
            if (forumDao.deleteForumByQuestionId(queId) != 1)
                return systemError;
            else
                return delete;
        } else
            return systemError;
    }

    @Override
    public Integer queryForumCommentCountByQid(Integer queId) {
        if (queId != null) {
            return forumDao.selectForumCommentCountByQid(queId);
        } else
            return null;
    }
}
