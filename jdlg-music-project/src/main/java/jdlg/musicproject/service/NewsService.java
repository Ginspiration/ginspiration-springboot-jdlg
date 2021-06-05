package jdlg.musicproject.service;

import jdlg.musicproject.entries.common.News;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NewsService {

    /* x:查询所有新闻 */
    List<News> selectAllNews();

    /* x:根据新闻标题查找新闻 */
    List<News> selectNewByTitle(String newTitle);

    /**
     * 根据标记查找新闻
     * @param newMark
     * @return
     */
    List<News> selectNewsByMark(Integer newMark);

    /* x:添加新闻 */
    int addNew(News news);

    /* x:根据新闻标题删除新闻 */
    int deleteNew(String newTitle);

    /* x:更新新闻 */
    int updateNew(News news,String oldTitle);

}
