package jdlg.musicproject.entries.common;

import java.util.List;
import java.util.Objects;

public class ForumQuestion {
    private Integer queId;
    private String courseId;
    private String name;
    private String context;
    private String upDate;
    private List<ForumAnswer> forumAnswer;

    @Override
    public String toString() {
        return "ForumQuestion{" +
                "queId=" + queId +
                ", courseId='" + courseId + '\'' +
                ", name='" + name + '\'' +
                ", context='" + context + '\'' +
                ", upDate='" + upDate + '\'' +
                ", forumAnswer=" + forumAnswer +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null
                && getQueId() == null
                && getCourseId() == null
                && getName() == null
                && getContext() == null
                && getUpDate() == null
                && getForumAnswer().equals(null))
            return true;
        if (getClass() != o.getClass()) return false;
        ForumQuestion that = (ForumQuestion) o;
        return Objects.equals(queId, that.queId) &&
                Objects.equals(courseId, that.courseId) &&
                Objects.equals(name, that.name) &&
                Objects.equals(context, that.context) &&
                Objects.equals(upDate, that.upDate) &&
                Objects.equals(forumAnswer, that.forumAnswer);
    }

    @Override
    public int hashCode() {
        return Objects.hash(queId, courseId, name, context, upDate, forumAnswer);
    }

    public List<ForumAnswer> getForumAnswer() {
        return forumAnswer;
    }

    public void setForumAnswer(List<ForumAnswer> forumAnswer) {
        this.forumAnswer = forumAnswer;
    }

    public Integer getQueId() {
        return queId;
    }

    public void setQueId(Integer queId) {
        this.queId = queId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getUpDate() {
        return upDate;
    }

    public void setUpDate(String upDate) {
        this.upDate = upDate;
    }

}
