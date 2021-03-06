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

    /*?????????????????????*/
    @RequestMapping(value = "/showAllKnow", method = RequestMethod.GET)
    @ResponseBody
    public List<TeacherKnowledge> showAllKnow(Integer cId, Integer index, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        //??????Id
        String tempCid = request.getParameter("imgCid");
        //???????????????
        String tempKnowId = request.getParameter("imgKnowId");
        //???????????????
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
            //??????????????????
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
            /*????????????*/
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
    /*??????*/
    @RequestMapping(value = "/studentKnowSearch", method = RequestMethod.GET)
    @ResponseBody
    public List<TeacherKnowledge> KnowSearch(HttpSession session, String title, Integer cId, HttpServletRequest request, HttpServletResponse response) {
        //??????
        String TempSearchTitle = request.getParameter("titleName");
        //????????????ID
        String TempImgCId = request.getParameter("imgCId");
        //???????????????
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
    /*????????????*/
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
    /*??????????????????*/
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
            //?????????????????????
            String mediaFlag = request.getParameter("mediaFlag");
            //??????????????????
            Integer contextId = Integer.parseInt(request.getParameter("contextId"));
            //??????????????????
            Map<Integer, String> urlMediaMap = (Map<Integer, String>) session.getAttribute("urlMediaMap");
            for (Map.Entry<Integer, String> node : urlMediaMap.entrySet()) {
                //?????????????????????
                if (node.getKey().equals(contextId)) {
                    if ("image".equals(mediaFlag)) {
                        //????????????
                        int imgId = Integer.parseInt(request.getParameter("imgId"));

                        File imgFiles = new File(node.getValue() + "\\image");
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(imgFiles, imgId, response);
                        }
                        //new Thread(() -> new doWrite(imgFiles,imgId,response).writeFileToResponse()).start();
                    } else if ("music".equals(mediaFlag)) {
                        //??????????????????
                        int musicId = Integer.parseInt(request.getParameter("musicId"));

                        File musicFiles = new File(node.getValue() + "\\MP3");
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(musicFiles, musicId, response);
                        }
                        //new Thread(() -> new doWrite(musicFiles,musicId,response).writeFileToResponse()).start();
                    } else if ("video".equals(mediaFlag)) {
                        //??????????????????
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
    /*????????????*/
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
            //?????????????????????
            String mediaFlag = request.getParameter("mediaFlag");
            //??????????????????
            Integer contextId = Integer.parseInt(request.getParameter("contextId"));
            //??????????????????
            Map<Integer, String> urlMediaMapSearch = (Map<Integer, String>) session.getAttribute("urlMediaMapSearch");
            for (Map.Entry<Integer, String> node : urlMediaMapSearch.entrySet()) {
                //?????????????????????
                if (node.getKey().equals(contextId)) {
                    if ("image".equals(mediaFlag)) {
                        //????????????
                        int imgId = Integer.parseInt(request.getParameter("imgId"));

                        File imgFiles = new File(node.getValue() + "\\image");
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(imgFiles, imgId, response);
                        }
                    } else if ("music".equals(mediaFlag)) {
                        //??????????????????
                        int musicId = Integer.parseInt(request.getParameter("musicId"));

                        File musicFiles = new File(node.getValue() + "\\MP3");
                        synchronized (session.getServletContext().getAttribute("viewListenSyn")) {
                            writeFileToResponse(musicFiles, musicId, response);
                        }
                    } else if ("video".equals(mediaFlag)) {
                        //??????????????????
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
