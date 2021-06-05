package jdlg.musicproject.entries.student;

public class StudentCourse {
    private Integer stuId;
    private Integer courseId;
    private Integer status;

    public Integer getStuId() {
        return stuId;
    }

    public void setStuId(Integer stuId) {
        this.stuId = stuId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "StudentCourse{" +
                "stuId=" + stuId +
                ", courseId=" + courseId +
                ", status=" + status +
                '}';
    }
}
