package jdlg.musicproject.util;

public enum UtilTeacherWebURI {
    /**
     * -------------------网站地址--------------------------
     */
    basePathURL("http://localhost:8080/music_project_war_exploded/"),
    /**
     * -------------------新闻--------------------------
     */

    /*添加新闻*/
    teacherAddNewUri("../teacher/news/addNews.jsp"),
    /*新闻列表*/
    teacherViewNews("../teacher/news/viewNews.jsp"),
    /*新闻详情*/
    teacherViewNewsDetail("../teacher/news/viewNewsDetail.jsp"),
    /*修改新闻*/
    teacherUpdateNew("../teacher/news/updateNew.jsp"),

    /**
     * -------------------学生--------------------------
     */
    /*禁用学生*/
    studentDisableUri("../teacher/stu/disable-student.jsp"),
    /*添加学生*/
    studentAddUri("../teacher/stu/add-student.jsp"),
    studentManage("../teacher/stu/advanced-permissions-student.jsp"),

    /**
     * -------------------课程--------------------------
     */
    /*添加课程*/
    coursesAddUri("../teacher/courses/add-course.jsp"),
    /*课程首页*/
    courseIndexUrl("../teacher/courses/index-course.jsp"),
    /**
     * -------------------论坛--------------------------
     */
    forumTeacher("../teacher/forum/teacher-forum.jsp"),
    forumTeacherDetail("../teacher/forum/teacher-forum-detail.jsp"),
    /**
     * -------------------学生自学基础--------------------------
     */
    multimediaBasicUri("../teacher/multimedia/basic-knowledge.jsp"),
    multimediaViewListen("../teacher/multimedia/view-listen.jsp"),
    /**
     * -------------------考核--------------------------
     */
    workAddUri("../teacher/examine/new-work.jsp"),
    workPreviousUri("../teacher/examine/previous-work.jsp"),
    ;
    private final String uri;

    UtilTeacherWebURI(String uri) {
        this.uri = uri;
    }

    public String getUri() {
        return this.uri;
    }
}

