package jdlg.musicproject.entries.student;

public class StudentQAnswer {
    private Integer questionId;
    private Integer studentId;
    private String stuAnswer;

    public Integer getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public String getStuAnswer() {
        return stuAnswer;
    }

    public void setStuAnswer(String stuAnswer) {
        this.stuAnswer = stuAnswer;
    }

    @Override
    public String toString() {
        return "StudentQAnswer{" +
                "questionId=" + questionId +
                ", studentId=" + studentId +
                ", stuAnswer='" + stuAnswer + '\'' +
                '}';
    }
}
