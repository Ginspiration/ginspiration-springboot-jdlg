package jdlg.musicproject.entries.teacher;

public class TeacherCourse {
    private Integer tchId;
    private Integer courseId;

    public Integer getTchId() {
        return tchId;
    }

    public void setTchId(Integer tchId) {
        this.tchId = tchId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    @Override
    public String toString() {
        return "TeacherCourse{" +
                "tchId=" + tchId +
                ", courseId=" + courseId +
                '}';
    }
}
