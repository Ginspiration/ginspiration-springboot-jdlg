package jdlg.musicproject.entries.common;

/*添加题库*/
public class QuestionBank {
    private Integer qId;
    private Integer courseId;
    private String context;
    private String answer;
    private Integer times;

    public Integer getqId() {
        return qId;
    }

    public void setqId(Integer qId) {
        this.qId = qId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer.toUpperCase();
    }

    public Integer getTimes() {
        return times;
    }

    public void setTimes(Integer times) {
        this.times = times;
    }

    @Override
    public String toString() {
        return "QuestionBank{" +
                "qId=" + qId +
                ", courseId=" + courseId +
                ", context='" + context + '\'' +
                ", answer='" + answer + '\'' +
                ", times=" + times +
                '}';
    }
}
