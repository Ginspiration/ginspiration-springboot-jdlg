package jdlg.musicproject.entries.student;

public class StudentPreviousWork {
    private Integer times;
    private String explainContext;
    private Integer totalPoints;
    private Integer courseId;
    private Float grade;

    public Integer getTimes() {
        return times;
    }

    public void setTimes(Integer times) {
        this.times = times;
    }

    public String getExplainContext() {
        return explainContext;
    }

    public void setExplainContext(String explainContext) {
        this.explainContext = explainContext;
    }

    public Integer getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(Integer totalPoints) {
        this.totalPoints = totalPoints;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Float getGrade() {
        return grade;
    }

    public void setGrade(Float grade) {
        this.grade = grade;
    }

    @Override
    public String toString() {
        return "StudentPreviousWork{" +
                "times=" + times +
                ", explainContext='" + explainContext + '\'' +
                ", totalPoints=" + totalPoints +
                ", courseId=" + courseId +
                ", grade=" + grade +
                '}';
    }
}
