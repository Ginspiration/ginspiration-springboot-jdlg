package jdlg.musicproject.controller.doStudent;

import jdlg.musicproject.entries.common.Courses;
import jdlg.musicproject.entries.common.QuestionBank;
import jdlg.musicproject.entries.common.WorkExplain;
import jdlg.musicproject.entries.student.*;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import jdlg.musicproject.util.UtilStudentWebURI;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/doStudent")
public class UseExamine {
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;

    /*转发展示新作业*/
    @RequestMapping("/showExamine")
    public ModelAndView showExamine(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilStudentWebURI.workShowUri.getUri());
        Object addWorkSyn = request.getSession().getServletContext().getAttribute("addWorkSyn");
        if (addWorkSyn == null) {
            request.getSession().getServletContext().setAttribute("addWorkSyn", new Object());
        }
        mv.setViewName("index/index-student");
        return mv;
    }

    /*显示新作业*/
    @RequestMapping("/doShowExamine")
    @ResponseBody
    public List<WorkExplain> doShowExamine(HttpSession session, Integer cId) {
        List<WorkExplain> explains = new ArrayList<>();
        /*获取学生Id*/
        Integer sId = (Integer) session.getAttribute("sId");
        synchronized (session.getServletContext().getAttribute("addWorkSyn")) {
            /*通过sId获取grade*/
            List<StudentGrade> grades = studentService.showGrade(sId);
            for (StudentGrade grade : grades) {
                /*学生所点击的课程，和所有课程的未完成的作业比较，相同则放入响应体*/
                if (grade.getCourseId().intValue() == cId.intValue()) {
                    /*这次作业未完成*/
                    if (grade.getGrade() == null) {
                        /*获取作业描述*/
                        explains.add(teacherService.showExplain(grade.getTimes(), cId));
                    }
                }
            }
        }
        return explains;
    }

    /*转发写作业页面*/
    @RequestMapping("/doExamine")
    public ModelAndView doExamine(HttpServletRequest request, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        Integer cId = Integer.parseInt(request.getParameter("cId"));
        Integer times = Integer.parseInt(request.getParameter("times"));
        /*获取这次的题目*/
        List<QuestionBank> bank = teacherService.showQuestions(cId, times);
        /*创建Map储存题目*/
        Map<Integer, StudentDoWork> doWorkMap = new HashMap<>();
        int flag = 0;
        for (QuestionBank question : bank) {
            StudentDoWork work = new StudentDoWork();
            /*处理context*/
            String context = question.getContext();
            String[] q = context.split("\\*&\\*");
            for (int i = 0; i < q.length; i++) {
                /*题目内容*/
                if (i == 0) {
                    work.setContext(q[i]);
                    /*A*/
                } else if (i == 1) {
                    work.setOptionA(q[i]);
                    /*B*/
                } else if (i == 2) {
                    work.setOptionB(q[i]);
                    /*C*/
                } else if (i == 3) {
                    work.setOptionC(q[i]);
                    /*D*/
                } else if (i == 4) {
                    work.setOptionD(q[i]);
                }
            }
            work.setAnswer(question.getAnswer());
            /*问题id标识*/
            work.setqId(question.getqId());
            /*flag+1=第几题*/
            doWorkMap.put(flag, work);
            flag++;
        }
        session.setAttribute("questionMap", doWorkMap);
        session.setAttribute("thisCId", cId);
        session.setAttribute("thisTimes", times);
        /*有几题*/
        session.setAttribute("thisQCount", flag);
        request.setAttribute("Context", UtilStudentWebURI.workDoUri.getUri());
        mv.setViewName("index/index-student");
        return mv;
    }

    /*储存学生答案*/
    @Transactional
    @RequestMapping(value = "/storageAnswer", method = RequestMethod.POST)
    public void storageAnswer(@RequestBody List<StudentQAnswer> qAnswers) {
        for (StudentQAnswer answer : qAnswers) {
            studentService.recordAnswer(answer);
        }

    }

    /*展示成绩*/
    @Transactional
    @RequestMapping("/showGrade")
    public ModelAndView showGrade(HttpServletRequest request, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        if (session.getAttribute("thisCId") != null) {
            Integer rCount = Integer.parseInt(request.getParameter("rCount"));
            Integer thisCId = (Integer) session.getAttribute("thisCId");
            Integer thisTimes = (Integer) session.getAttribute("thisTimes");
            Integer thisQCount = (Integer) session.getAttribute("thisQCount");
            Integer sId = (Integer) session.getAttribute("sId");
            /*计算成绩*/
            WorkExplain explain = teacherService.showExplain(thisTimes, thisCId);
            Float totalPoints = Float.valueOf(explain.getTotalPoints());
            if (totalPoints != null) {
                //float   b   =   (float)(Math.round(a*10))/10;
                /*Math.round四舍五入的原理是在参数上加0.5然后进行下取整*/
                Float g = (totalPoints / thisQCount) * rCount;
                Float thisGrade = (float) (Math.round(g * 10)) / 10;
                /*做对几题*/
                session.setAttribute("rCount", rCount);
                /*总分*/
                session.setAttribute("totalPoints", totalPoints);
                /*得分*/
                session.setAttribute("points", thisGrade);

                StudentGrade grade = new StudentGrade();
                grade.setCourseId(thisCId);
                grade.setStuId(sId);
                grade.setTimes(thisTimes);
                grade.setGrade(thisGrade);
                /*添加到数据库*/
                studentService.addGrade(grade);
            }
            /*清空作业session*/
            session.removeAttribute("thisCId");
            session.removeAttribute("thisTimes");
            session.removeAttribute("thisQCount");

            /*重新查询作业完成情况*/
            List<StudentGrade> grades = studentService.showGrade(sId);
            Set<String> courseNames = new HashSet<>();
            for (StudentGrade grade : grades) {
                if (grade.getGrade() == null) {
                    Courses course = teacherService.selectCourse(grade.getCourseId());
                    courseNames.add(course.getCourseName());
                }
            }
            if (courseNames.size() != 0) {
                session.setAttribute("unDoCourse", courseNames);
            } else {
                if (session.getAttribute("unDoCourse") != null) {
                    session.removeAttribute("unDoCourse");
                }
            }


            request.setAttribute("Context", UtilStudentWebURI.workShowGrade.getUri());
            mv.setViewName("index/index-student");
        } else {
            request.setAttribute("Context", UtilStudentWebURI.workShowUri.getUri());
            mv.setViewName("index/index-student");
        }
        return mv;
    }

    /*转发往期作业页面*/
    @RequestMapping("/showPrevious")
    public ModelAndView showPrevious(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilStudentWebURI.workPreviousUri.getUri());
        mv.setViewName("index/index-student");
        return mv;
    }

    /*展示往期作业*/
    @RequestMapping(value = "/showPrevious/showPreviousWork", method = RequestMethod.POST)
    @ResponseBody
    public List<StudentPreviousWork> showPreviousWork(Integer cId, HttpSession session) {
        List<StudentPreviousWork> previousWorks = new ArrayList<>();
        //Map<String, Object> thisWork = new HashMap<>();
        Integer sId = (Integer) session.getAttribute("sId");
        /*获取学生成绩*/
        List<StudentGrade> gd = studentService.showGrade(sId);
        /*获取描述*/
        List<WorkExplain> explain = teacherService.showAllExplain(cId);
        /*拼接*/
        for (WorkExplain exp : explain) {
            for (StudentGrade grade : gd) {
                if (exp.getCourseId().intValue() == grade.getCourseId().intValue() && exp.getTimes().intValue() == grade.getTimes().intValue()) {
                    /*如果成绩不为空*/
                    if (grade.getGrade() != null) {
                        StudentPreviousWork p = new StudentPreviousWork();
                        p.setExplainContext(exp.getExplainContext());
                        p.setGrade(grade.getGrade());
                        p.setTotalPoints(exp.getTotalPoints());
                        p.setTimes(exp.getTimes());
                        p.setCourseId(exp.getCourseId());
                        previousWorks.add(p);
                    }
                }
            }
        }
//        List<Float> grade = null;
//        for (StudentGrade g : gd) {
//            if (g.getCourseId().intValue() == cId.intValue()) {
//                if (g.getGrade() != null) {
//                    grade.add(g.getGrade());
//                } else{
//
//                }
//            }
//        }
        //thisWork.put("explain", explain);
        //thisWork.put("grade", grade);
        return previousWorks;
    }

    /*显示当前次数的作业内容*/
    @RequestMapping(value = "/showPrevious/showQuestions", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> showQuestions(Integer cId, Integer times, HttpSession session) {
        Map<String, Object> thisQuestion = new HashMap<>();

        Integer sId = (Integer) session.getAttribute("sId");
        /*获取问题*/
        List<QuestionBank> temp = teacherService.showQuestions(cId, times);
        List<QuestionBank> temp2 = new ArrayList<>();
        /*储存答案*/
        List<StudentQAnswer> answers = new ArrayList<>();
        /*截取字符串*/
        for (QuestionBank q : temp) {
            QuestionBank bank = new QuestionBank();
            StringBuilder builder = new StringBuilder();
            /*处理context字符串*/
            String context = q.getContext();
            String[] c = context.split("\\*&\\*");
            for (int j = 0; j < c.length; j++) {
                /*题目内容*/
                if (j == 0) {
                    builder.append("题目：").append(c[j]).append("<br/>");
                    /*A*/
                } else if (j == 1) {
                    builder.append("A、").append(c[j]).append("<br/>");
                    /*B*/
                } else if (j == 2) {
                    builder.append("B、").append(c[j]).append("<br/>");
                    /*C*/
                } else if (j == 3) {
                    builder.append("C、").append(c[j]).append("<br/>");
                    /*D*/
                } else if (j == 4) {
                    builder.append("D、").append(c[j]).append("<br/>");
                }
            }
            bank.setContext(builder.toString());
            bank.setAnswer(q.getAnswer());
            bank.setCourseId(q.getCourseId());
            bank.setTimes(q.getTimes());
            temp2.add(bank);
            /*获取学生答案*/
            StudentQAnswer answer = studentService.showAnswer(q.getqId(), sId);
            answers.add(answer);
        }
        thisQuestion.put("questions", temp2);
        thisQuestion.put("answers", answers);

        return thisQuestion;
    }

}
