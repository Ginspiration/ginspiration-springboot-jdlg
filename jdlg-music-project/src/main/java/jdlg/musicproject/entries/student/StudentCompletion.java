package jdlg.musicproject.entries.student;

public class StudentCompletion {
    private Integer sId;
    private String sName;
    private Integer grade;

    public Integer getsId() {
        return sId;
    }

    public void setsId(Integer sId) {
        this.sId = sId;
    }

    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
    }

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    @Override
    public String toString() {
        return "StudentCompletion{" +
                "sId=" + sId +
                ", sName='" + sName + '\'' +
                ", grade=" + grade +
                '}';
    }
}
