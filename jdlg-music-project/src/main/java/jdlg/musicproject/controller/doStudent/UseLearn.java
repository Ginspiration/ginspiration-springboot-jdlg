package jdlg.musicproject.controller.doStudent;

import jdlg.musicproject.entries.teacher.TeacherAppreciate;
import jdlg.musicproject.entries.teacher.TeacherKnowledge;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.StudentServiceMultimedia;
import jdlg.musicproject.service.TeacherService;
import jdlg.musicproject.service.TeacherServiceMultimedia;
import jdlg.musicproject.util.UtilStudentWebURI;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import static jdlg.musicproject.controller.doteacher.DoMultimedia.writeFileToResponse;

@Controller
@RequestMapping("/doStudent")
public class UseLearn {
    @Resource(name = "studentServiceImpl")
    private StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    private TeacherService teacherService;
    @Resource(name = "studentServiceMultimediaImpl")
    private StudentServiceMultimedia studentServiceMultimedia;
    @Resource(name = "teacherServiceMultimediaImpl")
    private TeacherServiceMultimedia teacherServiceMultimediaImpl;

    @RequestMapping(value = "/learnBasicKnow")
    public ModelAndView LearnBasicKnow(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilStudentWebURI.learnBasicURL.getUri());
        if (request.getSession().getServletContext().getAttribute("multimediaSyn") == null) {
            request.getSession().getServletContext().setAttribute("multimediaSyn", new Object());
        }
        mv.setViewName("index/index-student");
        return mv;
    }

    /*显示所有知识点*/
    @RequestMapping(value = "/showAllKnow", method = RequestMethod.GET)
    @ResponseBody
    public List<TeacherKnowledge> showAllKnow(Integer cId, Integer index, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        //课程Id
        String tempCid = request.getParameter("imgCid");
        //第几个内容
        String tempKnowId = request.getParameter("imgKnowId");
        //第几张图片
        String tempImgId = request.getParameter("imgId");
        if (cId != null && index != null) {
            Map<Integer, List<TeacherKnowledge>> map;
            synchronized (session.getServletContext().getAttribute("multimediaSyn")) {
                map = studentServiceMultimedia.showAllKnow(cId, index);
            }
            int totalPages = 0;
            List<TeacherKnowledge> list = null;
            for (Map.Entry<Integer, List<TeacherKnowledge>> node : map.entrySet()) {
                list = node.getValue();
                totalPages = node.getKey();
            }
            if (session.getAttribute("totalPages") == null) {
                session.setAttribute("totalPages", totalPages);
            }
            session.setAttribute("index", index);
            //添加总的页数
            TeacherKnowledge setTotalPage = new TeacherKnowledge();
            setTotalPage.setCourseId(-1);
            setTotalPage.setId(totalPages);
            list.add(setTotalPage);
            return list;
        } else if (tempImgId != null && tempKnowId != null && tempCid != null) {
            response.reset();
            Integer thisIndex = (Integer) session.getAttribute("index");
            Integer cId2 = Integer.parseInt(tempCid);
            Integer knowId = Integer.parseInt(tempKnowId);
            Integer imgId = Integer.parseInt(tempImgId);
            Map<Integer, List<TeacherKnowledge>> map;
            synchronized (session.getServletContext().getAttribute("multimediaSyn")) {
                map = studentServiceMultimedia.showAllKnow(cId2, thisIndex);
            }
            List<TeacherKnowledge> knowledge = null;
            for (Map.Entry<Integer, List<TeacherKnowledge>> node : map.entrySet()) {
                knowledge = node.getValue();
            }
            /*处理图片*/
            for (TeacherKnowledge k : knowledge) {
                if (k.getId().intValue() == knowId.intValue()) {
                    File[] files = new File(k.getImgUrl()).listFiles();
                    for (int i = 0; i < files.length; i++) {
                        if (i == imgId.intValue()) {
                            try {
                                InputStream in = new FileInputStream(k.getImgUrl() + "\\" + files[i].getName());
                                OutputStream out = response.getOutputStream();
                                byte[] bytes = new byte[1024 * 1024];
                                int readCount;
                                while ((readCount = in.read(bytes)) != -1) {
                                    out.write(bytes, 0, readCount);
                                }
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
            return null;
        } else
            return null;
    }
    /*搜索*/
    @RequestMapping(value = "/studentKnowSearch", method = RequestMethod.GET)
    @ResponseBody
    public List<TeacherKnowledge> KnowSearch(HttpSession session, String title, Integer cId, HttpServletRequest request, HttpServletResponse response) {
        //标题
        String TempSearchTitle = request.getParameter("titleName");
        //获取课程ID
        String TempImgCId = request.getParameter("imgCId");
        //第几张图片
        String TempImgId = request.getParameter("imgId");

        if (title != null && cId != null) {
            synchronized (session.getServletContext().getAttribute("multimediaSyn")) {
                return teacherServiceMultimediaImpl.findKnow(title.trim(), cId);
            }
        } else if (TempSearchTitle != null && !"".equals(TempSearchTitle) && TempImgId != null) {
            String searchTitle = null;
            int imgId = Integer.parseInt(TempImgId);
            Integer imgCId = Integer.parseInt(TempImgCId);
            int tId = teacherService.selectTidBycId(imgCId);
            try {
                searchTitle = new String(Base64.getDecoder().decode(TempSearchTitle.replace(" ", "+")), "utf-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            //String path = System.getProperty("MyWebUrl") + "WEB-INF\\upload\\knowledge\\" + tId + "\\" + imgCId + "\\" + searchTitle;
            String path = System.getProperty("MyWebUrl") + "\\META-INF\\resources\\WEB-INF\\upload\\knowledge\\" + tId + "\\" + imgCId + "\\" + searchTitle;
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
    @RequestMapping(value = "/viewListenStu")
    public ModelAndView viewListen(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilStudentWebURI.learnAppreciate.getUri());
        if (request.getSession().getServletContext().getAttribute("viewListenSyn") == null) {
            request.getSession().getServletContext().setAttribute("viewListenSyn", new Object());
        }
        mv.setViewName("index/index-student");
        return mv;
    }
    /*显示所有视听*/
    @GetMapping("/showViewListenStu")
    @ResponseBody
    public List<TeacherAppreciate> showViewListen(Integer cId, Integer index, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        List<TeacherAppreciate> appreciates;
        if (cId != null && index != null) {
            synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                appreciates = teacherServiceMultimediaImpl.showAllAppreciate(cId, index);
            }
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
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(imgFiles, imgId, response);
                        }
                        //new Thread(() -> new doWrite(imgFiles,imgId,response).writeFileToResponse()).start();
                    } else if ("music".equals(mediaFlag)) {
                        //哪个音乐文件
                        int musicId = Integer.parseInt(request.getParameter("musicId"));

                        File musicFiles = new File(node.getValue() + "\\MP3");
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(musicFiles, musicId, response);
                        }
                        //new Thread(() -> new doWrite(musicFiles,musicId,response).writeFileToResponse()).start();
                    } else if ("video".equals(mediaFlag)) {
                        //哪个视频文件
                        int videoId = Integer.parseInt(request.getParameter("videoId"));
                        File videoFiles = new File(node.getValue() + "\\MP4");
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(videoFiles, videoId, response);
                        }
                        //new Thread(() -> new doWrite(videoFiles,videoId,response).writeFileToResponse()).start();
                    }
                }
            }
        }
        return null;
    }
    /*搜索视听*/
    @GetMapping("/searchViewListenStu")
    @ResponseBody
    public List<TeacherAppreciate> searchViewListen(Integer cId, String index, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        List<TeacherAppreciate> appreciates;
        if (cId != null && index != null) {
            synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                appreciates = teacherServiceMultimediaImpl.findAppreciate(index, cId);
            }
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
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(imgFiles, imgId, response);
                        }
                    } else if ("music".equals(mediaFlag)) {
                        //哪个音乐文件
                        int musicId = Integer.parseInt(request.getParameter("musicId"));

                        File musicFiles = new File(node.getValue() + "\\MP3");
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(musicFiles, musicId, response);
                        }
                    } else if ("video".equals(mediaFlag)) {
                        //哪个视频文件
                        int videoId = Integer.parseInt(request.getParameter("videoId"));

                        File videoFiles = new File(node.getValue() + "\\MP4");
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(videoFiles, videoId, response);
                        }
                    }
                }
            }
        }
        return null;
    }
}
