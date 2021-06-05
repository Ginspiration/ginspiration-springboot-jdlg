package jdlg.musicproject.service.impl;

import jdlg.musicproject.dao.NewsDao;
import jdlg.musicproject.entries.common.News;
import jdlg.musicproject.service.NewsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class NewsServiceImpl implements NewsService {

    @Resource(name = "newsDao")
    private NewsDao newsDao;

    @Override
    public List<News> selectAllNews() {
        return newsDao.selectAllNews();
    }

    @Override
    public List<News> selectNewByTitle(String newTitle) {
        return newsDao.selectNewByTitle("%"+newTitle+"%");
    }

    @Override
    public List<News> selectNewsByMark(Integer newMark) {
        return newsDao.selectNewsByMark(newMark);
    }

    @Override
    public int addNew(News news) {
        return newsDao.addNew(news);
    }

    @Override
    public int deleteNew(String newTitle) {
        return newsDao.deleteNew(newTitle);
    }

    @Override
    public int updateNew(News news,String oldTitle) {
        //int updateNew(
        // @Param("newTitle") String newTitle,
        // @Param("newContext")String newContext,
        // @Param("newImgUrl")String newImgUrl,
        // @Param("newMark") Integer newMark,
        // @Param("oldTitle")String oldTitle);
        return newsDao.updateNew(news.getNewTitle(),news.getNewContext(),news.getNewImgUrl(),news.getNewMark(),oldTitle);
    }
}
