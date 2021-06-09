package jdlg.musicproject.util;

public enum UtilStudentWebURI {
    /**
     * -------------------网站地址--------------------------
     */
    basePathURL("http://localhost:8080/music_project_war_exploded/"),
    /**
     * -------------------新闻--------------------------
     */
    /*新闻列表*/
    viewNews("../student/news/viewNews.jsp"),
    viewNewsDetail("../student/news/viewNewsDetail.jsp"),
    /**
     * -------------------学习--------------------------
     */
    learnBasicURL("../student/learn/stu-knowledge.jsp"),
    learnAppreciate("../student/learn/stu-appreciate.jsp"),
    /**
     * -------------------课程--------------------------
     */
    /*添加课程*/
    coursesAddUri("../student/course/add-course.jsp"),
    /*显示课程*/
    coursesIndex("../student/course/index-course.jsp"),
    /**
     * -------------------论坛--------------------------
     */
    forumStudent("../student/forum/student-forum.jsp"),
    forumStudentDetail("../student/forum/student-forum-detail.jsp"),
    /**
     * -------------------考核--------------------------
     */
    workShowUri("../student/examine/show-examine.jsp"),
    workPreviousUri("../student/examine/previous-examine.jsp"),
    workDoUri("../student/examine/do-examine.jsp"),
    workShowGrade("../student/examine/show-grade.jsp"),
    ;
    private final String uri;

    UtilStudentWebURI(String uri) {
        this.uri = uri;
    }

    public String getUri() {
        return this.uri;
    }
}

