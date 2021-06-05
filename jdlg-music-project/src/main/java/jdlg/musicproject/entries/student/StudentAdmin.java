package jdlg.musicproject.entries.student;

public class StudentAdmin {
    private String student_pwd;
    private Integer admin_stu_id;

    public String getStudent_pwd() {
        return student_pwd;
    }

    public void setStudent_pwd(String student_pwd) {
        this.student_pwd = student_pwd;
    }

    public Integer getAdmin_stu_id() {
        return admin_stu_id;
    }

    public void setAdmin_stu_id(Integer admin_stu_id) {
        this.admin_stu_id = admin_stu_id;
    }

    @Override
    public String toString() {
        return "StudentAdmin{" +
                "student_pwd='" + student_pwd + '\'' +
                ", admin_stu_id=" + admin_stu_id +
                '}';
    }
}
