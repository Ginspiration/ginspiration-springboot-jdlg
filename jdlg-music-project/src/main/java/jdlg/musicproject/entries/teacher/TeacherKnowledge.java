package jdlg.musicproject.entries.teacher;

import java.util.Objects;

public class TeacherKnowledge {
    private Integer id;
    private String title;
    private String context;
    private String imgUrl;
    private Integer courseId;
    private String upTime;
    private Integer imgNumber;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getUpTime() {
        return upTime;
    }

    public void setUpTime(String upTime) {
        this.upTime = upTime;
    }

    public Integer getImgNumber() {
        return imgNumber;
    }

    public void setImgNumber(Integer imgNumber) {
        this.imgNumber = imgNumber;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TeacherKnowledge knowledge = (TeacherKnowledge) o;
        return Objects.equals(id, knowledge.id) &&
                Objects.equals(title, knowledge.title) &&
                Objects.equals(context, knowledge.context) &&
                Objects.equals(imgUrl, knowledge.imgUrl) &&
                Objects.equals(courseId, knowledge.courseId) &&
                Objects.equals(upTime, knowledge.upTime) &&
                Objects.equals(imgNumber, knowledge.imgNumber);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, title, context, imgUrl, courseId, upTime, imgNumber);
    }
}
