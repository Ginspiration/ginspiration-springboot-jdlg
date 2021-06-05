package jdlg.musicproject.controller.doteacher;

import jdlg.musicproject.dao.TeacherDao;
import jdlg.musicproject.dao.TeacherDaoMultimedia;
import jdlg.musicproject.entries.teacher.TeacherAppreciate;
import jdlg.musicproject.entries.teacher.TeacherKnowAll;
import jdlg.musicproject.entries.teacher.TeacherKnowledge;
import jdlg.musicproject.service.TeacherServiceMultimedia;
import jdlg.musicproject.service.impl.TeacherServiceMultimediaImpl;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/doTeacher")
public class DoMultimedia {

    @Resource(name = "teacherDao")
    private TeacherDao teacherDao;
    @Resource(name = "teacherDaoMultimedia")
    private TeacherDaoMultimedia teacherDaoMultimedia;
    @Resource(name = "teacherServiceMultimediaImpl")
    private TeacherServiceMultimedia teacherServiceMultimediaImpl;

    /*转发学习基础知识页面*/
    @RequestMapping("/forwardToMultimedia")
    public ModelAndView forwardToMultimedia(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilTeacherWebURI.multimediaBasicUri.getUri());
        if (request.getSession().getServletContext().getAttribute("multimediaSyn") == null) {
            request.getSession().getServletContext().setAttribute("multimediaSyn", new Object());
        }
        mv.setViewName("index/index-teacher");
        return mv;
    }

    /*接收上传的文件*/
    @RequestMapping(value = "/uploadPhotoFile", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView uploadPhotoFile(@RequestParam("files") MultipartFile[] files, HttpSession session) {
        session.setAttribute("MultipartFiles", files);
        return null;
    }

    /*上传文件和文本内容*/
    @RequestMapping(value = "/addKnowledge", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    @Transactional
    public String addKnowledge(String title, String context, Integer cId, HttpSession session) {
        String flag;
        if (title != null && context != null && cId != null) {
            Integer tId = (Integer) session.getAttribute("tId");
            MultipartFile[] files = (MultipartFile[]) session.getAttribute("MultipartFiles");
            session.removeAttribute("MultipartFiles");
            if (tId == null)
                return "系统错误，请重试";
            else if (files == null)
                return "系统错误，请重试";
            else {
                String imgUrl = teacherServiceMultimediaImpl.saveFiles(files, tId, cId, title).replace("\\", "\\\\");

                //获取系统时间
                Date newDate = new Date();
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String date = format.format(newDate);

                //注入持久层
                TeacherKnowledge knowledge = new TeacherKnowledge();
                knowledge.setImgUrl(imgUrl);
                knowledge.setCourseId(cId);
                knowledge.setContext(context);
                knowledge.setTitle(title);
                knowledge.setUpTime(date);
                synchronized (session.getServletContext().getAttribute("multimediaSyn")) {
                    flag = teacherServiceMultimediaImpl.addKnow(knowledge);
                }
            }
        } else
            flag = "发布失败！";
        return flag;
    }

    /*获取已经发布的内容，已课程为单位*/
    @RequestMapping(value = "/showKnowledge")
    @ResponseBody
    public List<TeacherKnowledge> showKnowledge(Integer cId, Integer index, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
        //图片请求参数获取
        String tempImgId = request.getParameter("img");
        String tempKnowId = request.getParameter("knowId");
        String tempCId2 = request.getParameter("cId2");
        response.reset();
        Integer imgId = null;
        Integer cId2 = null;
        Integer knowId = null;

        //一页放多少条数据
        int pageSize = 3;
        //总共多少页
        int totalPages = 0;


        if (tempKnowId != null && tempCId2 != null && tempImgId != null) {
            knowId = Integer.parseInt(tempKnowId);
            imgId = Integer.parseInt(tempImgId);
            cId2 = Integer.parseInt(tempCId2);
            response.setContentType("image/jpeg");
            index = (Integer) session.getAttribute("index");
            /*查数所有信息*/
            Map<Integer, List<TeacherKnowAll>> allMap = teacherServiceMultimediaImpl.showImg(cId2, index, pageSize);
            List<TeacherKnowAll> allList = new ArrayList<>();

            for (Map.Entry<Integer, List<TeacherKnowAll>> node : allMap.entrySet()) {
                allList = node.getValue();
                //totalPages = node.getKey();
            }

            /*给文件排序*/
            Map<Integer, File[]> files = new TreeMap<>();
            for (TeacherKnowAll k : allList) {
                files.put(k.getId(), k.getFiles());
            }
            /*向浏览器写文件*/
            for (Map.Entry<Integer, File[]> node : files.entrySet()) {
                if (knowId.intValue() == node.getKey().intValue()) {
                    File[] thisFile = node.getValue();
                    try {
                        for (int i = 0; i < thisFile.length; i++) {
                            if (i == imgId.intValue()) {
                                InputStream in = new FileInputStream(thisFile[i]);
                                OutputStream out = response.getOutputStream();
                                byte[] bytes = new byte[1024 * 1024];
                                int readCount;
                                while ((readCount = in.read(bytes)) != -1) {
                                    out.write(bytes, 0, readCount);
                                }
                                in.close();
                                out.flush();
                                out.close();
                            }
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
            return null;
        } else {
            List<TeacherKnowledge> knowledge = new ArrayList<>();
            if (cId != null && index != null) {

                /*查数所有信息*/
                Map<Integer, List<TeacherKnowAll>> allMap = teacherServiceMultimediaImpl.showImg(cId, index, pageSize);
                List<TeacherKnowAll> allList = new ArrayList<>();

                for (Map.Entry<Integer, List<TeacherKnowAll>> node : allMap.entrySet()) {
                    allList = node.getValue();
                    totalPages = node.getKey();
                }

                session.setAttribute("index", index);
                /*加载文本*/
                if (imgId == null && knowId == null) {
                    for (TeacherKnowAll k : allList) {
                        TeacherKnowledge kTemp = new TeacherKnowledge();
                        kTemp.setId(k.getId());
                        kTemp.setTitle(k.getTitle());
                        String temp = k.getContext().replace("\n", "</br>").replace(" ", "&nbsp");
                        kTemp.setContext(temp);
                        String tempTime = k.getTime().substring(0, 19);
                        kTemp.setUpTime(tempTime);
                        kTemp.setImgNumber(k.getImgNumber());
                        knowledge.add(kTemp);
                    }
                }
            }
            TeacherKnowledge setTotalPage = new TeacherKnowledge();
            setTotalPage.setCourseId(-1);
            setTotalPage.setId(totalPages);
            knowledge.add(setTotalPage);
            return knowledge;
        }
    }

    /*在删除中显示标题*/
    @RequestMapping(value = "/showDeleteKnow", method = RequestMethod.POST)
    @ResponseBody
    public List<TeacherKnowledge> showDeleteKnow(Integer cId) {
        if (cId != null) {
            List<TeacherKnowledge> know = teacherServiceMultimediaImpl.showAllKnow(cId);
            List<TeacherKnowledge> temp = new ArrayList<>(50);
            for (TeacherKnowledge k : know) {
                TeacherKnowledge knowledge = new TeacherKnowledge();
                knowledge.setTitle(k.getTitle());
                String tempStr = k.getContext();
                if (tempStr.length() > 20) {
                    tempStr = tempStr.substring(0, 20).replace("\n", " ") + "...";
                } else
                    tempStr = tempStr.replace("\n", " ") + "...";
                knowledge.setContext(tempStr);
                knowledge.setUpTime(k.getUpTime());
                temp.add(knowledge);
            }
            return temp;
        } else
            return null;
    }

    /*通过标题删除*/
    @RequestMapping(value = "/doDeleteKnow", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doDeleteKnow(HttpSession session, String title, Integer cId) {
        if (title != null && cId != null) {
            Integer tId = (Integer) session.getAttribute("tId");
            synchronized (session.getServletContext().getAttribute("multimediaSyn")) {
                return teacherServiceMultimediaImpl.deleteKnow(title, cId, tId);
            }
        } else
            return "系统错误，请重试！";
    }

    /*搜索*/
    @RequestMapping(value = "/KnowSearch", method = RequestMethod.GET)
    @ResponseBody
    public List<TeacherKnowledge> KnowSearch(HttpSession session, String title, Integer cId, HttpServletRequest request, HttpServletResponse response) {
        //标题
        String TempSearchTitle = request.getParameter("titleName");
        //获取课程ID
        String TempImgCId = request.getParameter("imgCId");
        //第几张图片
        String TempImgId = request.getParameter("imgId");

        Integer tId = (Integer) session.getAttribute("tId");
        if (title != null && cId != null) {
            //session.setAttribute("totalRecords",teacherServiceMultimediaImpl.showAllLike(title,cId));
            return teacherServiceMultimediaImpl.findKnow(title.trim(), cId);
        } else if (TempSearchTitle != null && !"".equals(TempSearchTitle) && TempImgId != null) {
            String searchTitle = null;
            int imgId = Integer.parseInt(TempImgId);
            Integer imgCId = Integer.parseInt(TempImgCId);
            try {
                searchTitle = new String(Base64.getDecoder().decode(TempSearchTitle.replace(" ", "+")), "utf-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            String path = System.getProperty("MyWebUrl") + "WEB-INF\\upload\\knowledge\\" + tId + "\\" + imgCId + "\\" + searchTitle;
            File thisFile = new File(path);
            File[] files = thisFile.listFiles();
            for (int i = 0; i < files.length; i++) {
                if (imgId == i) {
                    try {
                        InputStream in = new FileInputStream(path + "\\" + files[i].getName());
                        OutputStream out = response.getOutputStream();
                        byte[] bytes = new byte[1024 * 1024];
                        int readCount;
                        while ((readCount = in.read(bytes)) != -1) {
                            out.write(bytes, 0, readCount);
                        }
                        in.close();
                        out.flush();
                        out.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
            return null;
        } else
            return null;
    }

    /*视听转发*/
    @RequestMapping(value = "/viewListen")
    public ModelAndView viewListen(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilTeacherWebURI.multimediaViewListen.getUri());
        if (request.getSession().getServletContext().getAttribute("viewListenSyn") == null) {
            request.getSession().getServletContext().setAttribute("viewListenSyn", new Object());
        }
        mv.setViewName("index/index-teacher");
        return mv;
    }

    /*添加视听*/
    @RequestMapping(value = "/addViewListen", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    @Transactional
    public String addViewListen(TeacherAppreciate appreciate, HttpSession session) {
        if (appreciate != null) {
            Integer tId = (Integer) session.getAttribute("tId");
            if (appreciate.getFiles() != null) {
                for (MultipartFile file : appreciate.getFiles()) {
                    if (file.getSize() > 1024 * 1024 * 100) {
                        return "文件过大！";
                    }
                }
            }
            synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                return teacherServiceMultimediaImpl.addAppreciate(appreciate, tId);
            }
            //return null;
        } else
            return TeacherServiceMultimediaImpl.systemFalse;
    }

    /*显示所有视听*/
    @GetMapping("/showViewListen")
    @ResponseBody
    public List<TeacherAppreciate> showViewListen(Integer cId, Integer index, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        List<TeacherAppreciate> appreciates;
        if (cId != null && index != null) {
            appreciates = teacherServiceMultimediaImpl.showAllAppreciate(cId, index);
            Map<Integer, String> urlMediaMap = new TreeMap<>();
            for (TeacherAppreciate appreciate : appreciates) {
                urlMediaMap.put(appreciate.getId(), appreciate.getUrl());
            }
            session.setAttribute("indexMedia", index);
            session.setAttribute("urlMediaMap", urlMediaMap);
            return appreciates;
        } else {
            //判断是什么类型
            String mediaFlag = request.getParameter("mediaFlag");
            //判断那条内容
            Integer contextId = Integer.parseInt(request.getParameter("contextId"));
            //获取文件地址
            Map<Integer, String> urlMediaMap = (Map<Integer, String>) session.getAttribute("urlMediaMap");
            for (Map.Entry<Integer, String> node : urlMediaMap.entrySet()) {
                //取得同一条内容
                if (node.getKey().equals(contextId)) {
                    if ("image".equals(mediaFlag)) {
                        //哪张图片
                        int imgId = Integer.parseInt(request.getParameter("imgId"));

                        File imgFiles = new File(node.getValue() + "\\image");
                        writeFileToResponse(imgFiles, imgId, response);
                        //new Thread(() -> new doWrite(imgFiles,imgId,response).writeFileToResponse()).start();
                    } else if ("music".equals(mediaFlag)) {
                        //哪个音乐文件
                        int musicId = Integer.parseInt(request.getParameter("musicId"));

                        File musicFiles = new File(node.getValue() + "\\MP3");
                        writeFileToResponse(musicFiles, musicId, response);
                        //new Thread(() -> new doWrite(musicFiles,musicId,response).writeFileToResponse()).start();
                    } else if ("video".equals(mediaFlag)) {
                        //哪个视频文件
                        int videoId = Integer.parseInt(request.getParameter("videoId"));
                        File videoFiles = new File(node.getValue() + "\\MP4");
                        writeFileToResponse(videoFiles, videoId, response);
                        //new Thread(() -> new doWrite(videoFiles,videoId,response).writeFileToResponse()).start();
                    }
                }
            }
        }
        return null;
    }

    public static void writeFileToResponse(File file, int fileId, HttpServletResponse response) {
        File[] files = file.listFiles();
        for (int i = 0; i < files.length; i++) {
            if (fileId == i) {
                OutputStream outputStream = null;
                InputStream in = null;
                BufferedOutputStream out = null;
                try {
                    outputStream = response.getOutputStream();
                    out = new BufferedOutputStream(outputStream);
                    in = new FileInputStream(files[i].getAbsolutePath());
                    String fileName = files[i].getName();
                    //System.out.println(fileName.substring(fileName.lastIndexOf(".")));
                    if (".mp4".equals(fileName.substring(fileName.lastIndexOf(".")))) {
                        response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
                    }
                    byte[] bytes = new byte[1024 * 500];
                    int readCount;
                    while ((readCount = in.read(bytes)) != -1) {
                        out.write(bytes, 0, readCount);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        out.flush();
                        out.close();
                        in.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    /*搜索视听*/
    @GetMapping("/searchViewListen")
    @ResponseBody
    public List<TeacherAppreciate> searchViewListen(Integer cId, String index, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        List<TeacherAppreciate> appreciates;
        if (cId != null && index != null) {
            appreciates = teacherServiceMultimediaImpl.findAppreciate(index, cId);
            Map<Integer, String> urlMediaMapSearch = new TreeMap<>();
            for (TeacherAppreciate appreciate : appreciates) {
                urlMediaMapSearch.put(appreciate.getId(), appreciate.getUrl());
            }
            session.setAttribute("urlMediaMapSearch", urlMediaMapSearch);
            return appreciates;
        } else {
            //判断是什么类型
            String mediaFlag = request.getParameter("mediaFlag");
            //判断那条内容
            Integer contextId = Integer.parseInt(request.getParameter("contextId"));
            //获取文件地址
            Map<Integer, String> urlMediaMapSearch = (Map<Integer, String>) session.getAttribute("urlMediaMapSearch");
            for (Map.Entry<Integer, String> node : urlMediaMapSearch.entrySet()) {
                //取得同一条内容
                if (node.getKey().equals(contextId)) {
                    if ("image".equals(mediaFlag)) {
                        //哪张图片
                        int imgId = Integer.parseInt(request.getParameter("imgId"));

                        File imgFiles = new File(node.getValue() + "\\image");
                        writeFileToResponse(imgFiles, imgId, response);
                    } else if ("music".equals(mediaFlag)) {
                        //哪个音乐文件
                        int musicId = Integer.parseInt(request.getParameter("musicId"));

                        File musicFiles = new File(node.getValue() + "\\MP3");
                        writeFileToResponse(musicFiles, musicId, response);
                    } else if ("video".equals(mediaFlag)) {
                        //哪个视频文件
                        int videoId = Integer.parseInt(request.getParameter("videoId"));

                        File videoFiles = new File(node.getValue() + "\\MP4");
                        writeFileToResponse(videoFiles, videoId, response);
                    }
                }
            }
        }
        return null;
    }

    @PostMapping("/showAppreciateDelete")
    @ResponseBody
    public List<TeacherAppreciate> showAppreciateDelete(Integer cId) {
        if (cId != null) {
            List<TeacherAppreciate> appreciates = teacherDaoMultimedia.selectAllAppreciate(cId);
            List<TeacherAppreciate> appTemp = new ArrayList<>(10);

            for (TeacherAppreciate appreciate : appreciates) {
                TeacherAppreciate a = new TeacherAppreciate();
                a.setTitle(appreciate.getTitle());
                a.setContext(appreciate.getContext().substring(0, 20).trim() + "...");
                a.setUpTime(appreciate.getUpTime());
                appTemp.add(a);
            }
            return appTemp;
        } else
            return null;
    }

    /*删除视听*/
    @RequestMapping(value = "/doAppreciateDelete", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public String doAppreciateDelete(String index, Integer cId, HttpSession session) {
        if (index != null && cId != null) {
            int tId = (int) session.getAttribute("tId");
            synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                return teacherServiceMultimediaImpl.deleteAppreciate(index, tId, cId);
            }
        } else
            return TeacherServiceMultimediaImpl.systemFalse;
    }
}
