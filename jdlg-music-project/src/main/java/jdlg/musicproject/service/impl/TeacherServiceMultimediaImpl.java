package jdlg.musicproject.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import jdlg.musicproject.dao.TeacherDao;
import jdlg.musicproject.dao.TeacherDaoMultimedia;
import jdlg.musicproject.entries.teacher.TeacherAppreciate;
import jdlg.musicproject.entries.teacher.TeacherKnowAll;
import jdlg.musicproject.entries.teacher.TeacherKnowledge;
import jdlg.musicproject.service.TeacherServiceMultimedia;
import jdlg.musicproject.util.SaveFiles;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class TeacherServiceMultimediaImpl implements TeacherServiceMultimedia {

    public static String systemFalse = "系统错误，请重试";
    @Resource(name = "teacherDao")
    private TeacherDao teacherDao;
    @Resource(name = "teacherDaoMultimedia")
    private TeacherDaoMultimedia teacherDaoMultimedia;

    @Override
    public String addKnow(TeacherKnowledge knowledge) {
        if (knowledge != null) {
            if (teacherDao.selectCourses(knowledge.getCourseId()) != null) {
                List<TeacherKnowledge> k1 = teacherDaoMultimedia.seekKnow(knowledge.getTitle(), knowledge.getCourseId());
                if (k1.size() != 0) {
                    for (TeacherKnowledge k : k1) {
                        if (knowledge.getTitle().equals(k.getTitle())) {
                            return "该标题已被添加，请换个标题。";
                        }
                    }
                } else {
                    teacherDaoMultimedia.insertKnow(knowledge);
                }
            } else
                return "没有这门课程！重新选择";
        } else
            return "添加失败！";
        return "添加成功！";
    }

    @Override
    public String deleteKnow(String title, Integer cId, Integer tId) {
        if (title != null && cId != null) {
            if (teacherDao.selectCourses(cId) != null) {
                List<TeacherKnowledge> k1 = teacherDaoMultimedia.seekKnow(title, cId);
                if (k1.size() != 0) {
                    /*清空数据库*/
                    teacherDaoMultimedia.deleteKnow(title, cId);
                    /*删除本地文件*/
                    String dirPath = System.getProperty("MyWebUrl") + "WEB-INF\\upload\\knowledge\\" + tId + "\\" + cId;
                    //String dirPath = "D:\\MusicProject\\Version3.0\\music-project\\target\\music-project-2.0\\WEB-INF\\upload\\knowledge\\"+tId+"\\"+cId;
                    File thisDirs = new File(dirPath);
                    File[] files = thisDirs.listFiles();
                    for (File file : files) {
                        if (file.getName().equals(title)) {
                            //删除文件夹文件
                            File[] sunFiles = file.listFiles();
                            for (File sunFile : sunFiles) {
                                sunFile.delete();
                            }
                            //删除文件夹
                            file.delete();
                        }
                    }
                } else
                    return "没有这条内容，重新选择。";
            } else
                return "没有这门课程！重新选择";
        } else
            return "删除失败！";

        return "删除成功！";
    }

    @Override
    public String modifyKnow(TeacherKnowledge knowledge) {
        if (knowledge != null) {
            if (teacherDao.selectCourses(knowledge.getCourseId()) != null) {
                List<TeacherKnowledge> k1 = teacherDaoMultimedia.seekKnow(knowledge.getTitle(), knowledge.getCourseId());
                if (k1.size() != 0) {
                    teacherDaoMultimedia.modifyKnow(knowledge);
                } else
                    return "没有这条内容！重新选择。";
            } else
                return "没有这门课程！重新选择";
        } else
            return "修改失败！";

        return "修改成功！";
    }

    @Override
    public List<TeacherKnowledge> findKnow(String index, Integer cId) {
        if (index != null && cId != null) {
            if (teacherDao.selectCourses(cId) != null) {
                List<TeacherKnowledge> temp = new ArrayList<>(10);
                List<TeacherKnowledge> knowledge = teacherDaoMultimedia.seekKnow("%" + index + "%", cId);
                for (TeacherKnowledge teacherKnowledge : knowledge) {
                    TeacherKnowledge k = new TeacherKnowledge();
                    k.setTitle(teacherKnowledge.getTitle());
                    k.setContext(teacherKnowledge.getContext());
                    k.setCourseId(teacherKnowledge.getCourseId());
                    k.setUpTime(teacherKnowledge.getUpTime());
                    k.setImgUrl(teacherKnowledge.getImgUrl());
                    k.setId(teacherKnowledge.getId());
                    File file = new File(teacherKnowledge.getImgUrl());
                    k.setImgNumber(file.listFiles().length);
                    temp.add(k);
                }
                return temp;
                //return teacherDaoMultimedia.seekKnow("%" + index + "%", cId);
            } else
                return null;
        } else
            return null;
    }

    @Override
    public List<TeacherKnowledge> showAllKnow(Integer cId) {
        if (cId != null) {
            return teacherDaoMultimedia.selectAllKnow(cId);
        } else
            return null;
    }

    @Override
    public String saveFiles(MultipartFile[] files, Integer tId, Integer cId, String title) {
        String imgUrl = null;
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                InputStream in;
                FileOutputStream out;
                try {
                    String dirPathPart = System.getProperty("MyWebUrl") + "WEB-INF\\upload\\knowledge\\";
                    File teacherDir = new File(dirPathPart + tId);
                    if (!teacherDir.exists()) {
                        teacherDir.mkdir();
                    }
                    File courseDir = new File(dirPathPart + tId + "\\" + cId);
                    if (!courseDir.exists()) {
                        courseDir.mkdir();
                    }
                    File titleDir = new File(dirPathPart + tId + "\\" + cId + "\\" + title);
                    if (!titleDir.exists()) {
                        titleDir.mkdir();
                    }
                    imgUrl = dirPathPart + tId + "\\" + cId + "\\" + title;
                    in = file.getInputStream();
                    out = new FileOutputStream(dirPathPart + tId + "\\" + cId + "\\" + title + "\\" + file.getOriginalFilename());
                    byte[] bytes = new byte[1024 * 1024];
                    int readCount;
                    while ((readCount = in.read(bytes)) != -1) {
                        out.write(bytes, 0, readCount);
                    }
                    out.flush();
                    in.close();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return imgUrl;
    }

    @Override
    public Map<Integer, List<TeacherKnowAll>> showImg(Integer cId, Integer index, Integer size) {
        if (cId != null) {
            Map<Integer, List<TeacherKnowAll>> map = new HashMap<>();
            List<TeacherKnowAll> knowAll = new ArrayList<>();
            /*pageHelper*/
            Page<Object> pageHelper = PageHelper.startPage(index, size);
            //通过cId获取当前课程的所有知识点
            List<TeacherKnowledge> knowledge = teacherDaoMultimedia.selectAllKnow(cId);
            //遍历获取同一个知识点的图片，内容
            /*获取总页数*/
            int totalPages = pageHelper.getPages();

            int i = 0;
            for (TeacherKnowledge k : knowledge) {
                File[] files = new File(k.getImgUrl()).listFiles();
                TeacherKnowAll all = new TeacherKnowAll();
                all.setId(i);
                all.setTitle(k.getTitle());
                all.setContext(k.getContext());
                //System.out.println(k.getContext());
                all.setTime(k.getUpTime());
                all.setFiles(files);
                if (files != null) {
                    all.setImgNumber(files.length);
                }

                knowAll.add(all);
                i++;
            }
            map.put(totalPages, knowAll);
            return map;
        } else
            return null;
    }

    /**
     * 音乐、视频、图片
     */
    @Override
    public String addAppreciate(TeacherAppreciate appreciate, Integer tId) {
        if (appreciate != null) {
            if (teacherDaoMultimedia.findAppreciate(appreciate.getTitle(),appreciate.getCourseId()).size() != 0) {
                return "标题已被添加，请重试";
            }
            MultipartFile[] files = appreciate.getFiles();
            int imgNumber = 0;
            int mp3Number = 0;
            int videoNumber = 0;
            if ( files != null) {
                for (MultipartFile file : files) {
                    if (file.getSize() != 0) {
                        String type = file.getContentType();
                        //System.out.println(type);
                        if (type == null) {
                            return null;
                        }
                        switch (type) {
                            //图片
                            case "image/jpeg": {
                                type = "image";
                                if (!SaveFiles.doSave(file, tId, appreciate.getCourseId(), appreciate.getTitle(), type))
                                    return systemFalse;
                                imgNumber++;
                            }
                            break;
                            //MP3
                            case "audio/mpeg": {
                                type = "MP3";
                                if (!SaveFiles.doSave(file, tId, appreciate.getCourseId(), appreciate.getTitle(), type))
                                    return systemFalse;
                                mp3Number++;
                            }
                            break;
                            //MP4
                            case "video/mp4": {
                                type = "MP4";
                                if (!SaveFiles.doSave(file, tId, appreciate.getCourseId(), appreciate.getTitle(), type))
                                    return systemFalse;
                                videoNumber++;
                            }
                            break;
                        }
                    } else
                        return systemFalse;
                }
            }
            appreciate.setUrl((System.getProperty("MyWebUrl") + "WEB-INF\\upload\\appreciate\\" + tId + "\\" + appreciate.getCourseId() + "\\" + appreciate.getTitle()).replace("\\", "\\\\"));
            appreciate.setImgNumber(imgNumber);
            appreciate.setMusicNumber(mp3Number);
            appreciate.setVideoNumber(videoNumber);
            appreciate.setFiles(null);
            Date date = new Date();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            appreciate.setUpTime(format.format(date));
            if (teacherDaoMultimedia.insertAppreciate(appreciate) != 1)
                return systemFalse;
            else
                return "添加成功";
        } else
            return systemFalse;
    }

    @Override
    public String deleteAppreciate(String title, Integer tId, Integer cId) {
        if (title != null && cId != null && tId != null) {
            String path = System.getProperty("MyWebUrl") + "WEB-INF\\upload\\appreciate\\" + tId + "\\" + cId + "\\" + title;
            File fileBig = new File(path);
            if (fileBig.exists()) {
                File[] files = fileBig.listFiles();
                //遍历文件夹
                for (File file : files) {
                    File[] fs = file.listFiles();
                    //遍历文件夹下的文件
                    for (File f : fs) {
                        f.delete();
                    }
                    //删除这个文件夹
                    file.delete();
                }
                //删除总文件夹
                fileBig.delete();
            }
            //更新数据库
            if (teacherDaoMultimedia.deleteAppreciate(title,cId) == 1)
                return "删除成功";
            else
                return systemFalse;
        } else
            return systemFalse;
    }

    @Override
    public List<TeacherAppreciate> findAppreciate(String title, Integer cId) {
        if (title != null && cId != null) {
            return teacherDaoMultimedia.findAppreciate("%" + title + "%", cId);
        } else
            return null;
    }

    @Override
    public List<TeacherAppreciate> showAllAppreciate(Integer cId, Integer index) {
        if (cId != null && index != null) {
            //一页显示个数
            int size = 3;
            Page<Object> pageHelper = PageHelper.startPage(index, size);
            List<TeacherAppreciate> appreciates = teacherDaoMultimedia.selectAllAppreciate(cId);
            int totalPages = pageHelper.getPages();

            List<TeacherAppreciate> appreciatesTemp = new ArrayList<>(size);
            int i = 0;
            for (TeacherAppreciate app : appreciates) {
                TeacherAppreciate a = new TeacherAppreciate();
                a.setId(i);
                a.setCourseId(app.getCourseId());
                a.setTitle(app.getTitle());
                a.setContext(app.getContext().replace(" ","&nbsp").replace("\n","<br/>"));
                a.setUpTime(app.getUpTime());
                a.setUrl(app.getUrl());
                a.setImgNumber(app.getImgNumber());
                a.setMusicNumber(app.getMusicNumber());
                a.setVideoNumber(app.getVideoNumber());
                appreciatesTemp.add(a);
                i++;
            }
            TeacherAppreciate appreciate = new TeacherAppreciate();
            appreciate.setId(-1);
            appreciate.setCourseId(totalPages);
            appreciatesTemp.add(appreciate);

            return appreciatesTemp;
        } else
            return null;
    }
}
