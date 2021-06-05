package jdlg.musicproject.controller.doteacher;

import jdlg.musicproject.entries.common.Courses;
import jdlg.musicproject.entries.common.QuestionBank;
import jdlg.musicproject.entries.common.WorkExplain;
import jdlg.musicproject.entries.student.Student;
import jdlg.musicproject.entries.student.StudentCompletion;
import jdlg.musicproject.entries.student.StudentGrade;
import jdlg.musicproject.service.StudentService;
import jdlg.musicproject.service.TeacherService;
import jdlg.musicproject.util.UtilTeacherWebURI;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/doTeacher")
public class DoExamine {
    @Resource(name = "studentServiceImpl")
    StudentService studentService;
    @Resource(name = "teacherServiceImpl")
    TeacherService teacherService;

    //private static List<QuestionBank> bank = new ArrayList<>();
    /*转发添加作业*/
    @RequestMapping("/addWork")
    public ModelAndView addWork(HttpServletRequest request, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        /*创建Session用来临时保存添加的题库中的问题*/
        if (session.getAttribute("QuestionBank") == null) {
            session.setAttribute("QuestionBank", new ArrayList<QuestionBank>());
        }
        /*往全局作用域对象中放入一个对象用来保持线程安全*/
        Object addWorkSyn = session.getServletContext().getAttribute("addWorkSyn");
        if (addWorkSyn == null) {
            session.getServletContext().setAttribute("addWorkSyn",new Object());
        }
        request.setAttribute("Context", UtilTeacherWebURI.workAddUri.getUri());
        mv.setViewName("index/index-teacher");
        return mv;
    }

    /*展示课程*/
    @RequestMapping(value = "/addWork/showCourses", method = RequestMethod.POST)
    @ResponseBody
    public List<Courses> AddWorkShowCourses(HttpSession session) {
        /*获取当前教师课程*/
        Integer tId = (Integer) session.getAttribute("tId");
        List<Courses> courses = teacherService.showAllCourses(tId);
        return courses;
    }

    /*展示次数*/
    @RequestMapping(value = "/addWork/showTimes", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String addWorkShowTimes(Courses courses) {
        String strTimes = "往期：";
        List<Integer> times = teacherService.showAllTimes(courses.getCourseId());
        if (times.size() != 0) {
            int i = 0;
            for (Integer t : times) {
                strTimes += t + "、";
                i++;
            }
            strTimes = strTimes.substring(0, strTimes.length() - 1);
            strTimes += "  (共" + i + "次作业)";
        } else
            strTimes = "往期：暂时没发布过作业";
        return strTimes;
    }

    /*添加题目*/
    @Transactional
    @RequestMapping(value = "/addWork/addProblem", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doAddProblem(QuestionBank question, HttpSession session) {
        String flag = "保存成功！请勿刷新页面";
        if (question.getAnswer() != null && question.getContext() != null && question.getCourseId() != null && question.getTimes() != null) {
            if (teacherService.selectCourse(question.getCourseId()) != null) {
                /*临时储存题目*/
                List<QuestionBank> bank = (List<QuestionBank>) session.getAttribute("QuestionBank");
                bank.add(question);
                session.setAttribute("QuestionBank", bank);
            } else
                flag = "添加失败！当前课程不存在";
        } else
            flag = "添加失败！";
        return flag;
    }

    /*添加当前作业*/
    @Transactional
    @RequestMapping(value = "/doAddWork", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String doAddWork(WorkExplain explain, HttpSession session) {
        String flag = "发布成功！";
        if (explain.getCourseId() != null && explain.getExplainContext() != null && explain.getTimes() != null && explain.getTotalPoints() != null) {
            if (teacherService.selectCourse(explain.getCourseId()) != null) {
                if (teacherService.showExplain(explain.getTimes(), explain.getCourseId()) == null) {
                    /**
                     * 使用synchronized关键字，使得在其他使用相同表的线程不会出现数据错误
                     */
                    synchronized (session.getServletContext().getAttribute("addWorkSyn")) {
                        /*添加到作业描述*/
                        teacherService.addExplain(explain);
                        /*获取这门课程所有学生信息*/
                        List<Student> students = teacherService.showStuByCourse(explain.getCourseId());
                        for (Student student : students) {
                            /*更新成绩表*/
                            StudentGrade grade = new StudentGrade();
                            grade.setTimes(explain.getTimes());
                            grade.setStuId(student.getStudent_id());
                            grade.setCourseId(explain.getCourseId());
                            studentService.addGradeRecord(grade);
                        }
                        /*更新题库*/
                        List<QuestionBank> bank = (List<QuestionBank>) session.getAttribute("QuestionBank");
                        for (QuestionBank question : bank) {
                            teacherService.addQuestions(question);
                        }
                        bank.clear();
                        //清空session中题目，使可以重复添加
                        session.setAttribute("QuestionBank", bank);
/*                        try {
                            Thread.sleep(1000 * 60);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }*/
                    }
                } else
                    flag = "添加失败！这次作业已被添加";
            } else
                flag = "添加失败！当前课程不存在";
        } else
            flag = "添加失败！";
        return flag;
    }

    /*转发往期作业*/
    @RequestMapping("/previousWork")
    public ModelAndView previousWork(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        request.setAttribute("Context", UtilTeacherWebURI.workPreviousUri.getUri());
        mv.setViewName("index/index-teacher");
        return mv;
    }

    /*展示往期作业*/
    @RequestMapping("/previousWork/showPreviousWork")
    @ResponseBody
    public List<WorkExplain> showPreviousWork(Integer cId) {
        return teacherService.showAllExplain(cId);
    }

    /*显示当前次数的作业内容,分页*/
    @RequestMapping("/previousWork/showQuestions")
    @ResponseBody
    public List<QuestionBank> showQuestions(Integer cId, Integer times, Integer index, Integer size) {
        //session.removeAttribute("totalPages");
        QuestionBank saveTotalPage = new QuestionBank();
        List<QuestionBank> temp = null;
        if (cId != null && times != null && index != null && size != null) {
            temp = teacherService.showQuestionsByIndex(cId, times, index, size);
        }
        List<QuestionBank> temp2 = new ArrayList<>();
        /*拦截总页数*/
        int intercept = temp.size();
        /*截取字符串*/
        for (QuestionBank q : temp) {
            if (intercept > 1) {
                QuestionBank bank = new QuestionBank();
                StringBuilder builder = new StringBuilder();
                /*处理context字符串*/
                String context = q.getContext();
                String[] c = context.split("\\*&\\*");
                for (int i = 0; i < c.length; i++) {
                    /*题目内容*/
                    if (i == 0) {
                        builder.append("题目：").append(c[i]).append("<br/>");
                        /*A*/
                    } else if (i == 1) {
                        builder.append("A、").append(c[i]).append("<br/>");
                        /*B*/
                    } else if (i == 2) {
                        builder.append("B、").append(c[i]).append("<br/>");
                        /*C*/
                    } else if (i == 3) {
                        builder.append("C、").append(c[i]).append("<br/>");
                        /*D*/
                    } else if (i == 4) {
                        builder.append("D、").append(c[i]).append("<br/>");
                    }
                }
                bank.setContext(builder.toString());
                bank.setAnswer(q.getAnswer());
                bank.setCourseId(q.getCourseId());
                bank.setTimes(q.getTimes());
                bank.setqId(q.getqId());
                temp2.add(bank);
                intercept--;
            } else {
                /*总页数放入QuestionBank对象*/
                saveTotalPage.setqId(q.getqId());
                //intercept = 1;
            }
        }
        temp2.add(saveTotalPage);
        return temp2;
    }

    /*删除题目*/
    @RequestMapping(value = "/previousWork/deleteQuestion", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String deleteQuestion(Integer qId) {
        String flag = "删除成功！";
        if (qId != null) {
            teacherService.deleteQuestion(qId);
        } else
            flag = "删除失败！";
        return flag;
    }

    /*删除描述*/
    @RequestMapping(value = "/previousWork/deleteExplain", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String deleteExplain(Integer cId, Integer times) {
        String flag = "删除成功！";
        if (cId != null && times != null) {
            teacherService.deleteExplain(cId, times);
        } else
            flag = "删除失败！";
        return flag;
    }

    /*完成情况*/
    @RequestMapping("/previousWork/showCompletion")
    @ResponseBody
    public List<StudentCompletion> showCompletion(Integer cId, Integer times) {
        List<StudentCompletion> grades = null;
        if (cId != null && times != null) {
            grades = teacherService.showGrade(cId, times);
        }
        return grades;
    }

    /*总排名*/
    /*完成情况*/
    @RequestMapping(value = "/totalRanking", method = RequestMethod.POST)
    @ResponseBody
    public List<StudentCompletion> totalRanking(Integer cId) {
        List<StudentCompletion> completion = new ArrayList<>();
        if (cId != null) {
            /*总成绩*/
            List<StudentCompletion> gradesTemp = teacherService.showTotalGrade(cId);
            /*总次数*/
            Integer times = teacherService.showTotalTimes(cId);
            /*处理得 平均成绩*/
            for (StudentCompletion stu : gradesTemp) {
                if (stu.getGrade() != null) {
                    StudentCompletion studentCompletion = new StudentCompletion();
                    studentCompletion.setsId(stu.getsId());
                    studentCompletion.setsName(stu.getsName());

                    //Float g = (totalPoints / thisQCount) * rCount;
                    //Float thisGrade = (float) (Math.round(g * 10)) / 10;
                    Float g = Float.valueOf(stu.getGrade());
                    Integer averageGrade = Math.round((g / times) * 10) / 10;
                    studentCompletion.setGrade(averageGrade);

                    completion.add(studentCompletion);
                }
            }
        }
        return completion;
    }
}
