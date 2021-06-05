package jdlg.musicproject.entries.student;

public class StudentGrade {
    private Integer stuId;
    private Integer courseId;
    private Integer times;
    private Float grade;

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

    public Integer getTimes() {
        return times;
    }

    public void setTimes(Integer times) {
        this.times = times;
    }

    public Float getGrade() {
        return grade;
    }

    public void setGrade(Float grade) {
        this.grade = grade;
    }

    @Override
    public String toString() {
        return "StudentGrade{" +
                "stuId=" + stuId +
                ", courseId=" + courseId +
                ", times=" + times +
                ", grade=" + grade +
                '}';
    }
}
