package jdlg.musicproject.entries.common;

/*作业描述*/
public class WorkExplain {
    private Integer courseId;
    private Integer times;
    private String explainContext;
    private Integer totalPoints;

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

    @Override
    public String toString() {
        return "WorkExplain{" +
                "courseId=" + courseId +
                ", times=" + times +
                ", explainContext='" + explainContext + '\'' +
                ", totalPoints=" + totalPoints +
                '}';
    }
}
