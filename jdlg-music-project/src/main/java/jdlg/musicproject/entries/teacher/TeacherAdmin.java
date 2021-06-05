package jdlg.musicproject.entries.teacher;

public class TeacherAdmin {
    private String tch_password;
    private Integer admin_tch_id;

    public String getTch_password() {
        return tch_password;
    }

    public void setTch_password(String tch_password) {
        this.tch_password = tch_password;
    }

    public Integer getAdmin_tch_id() {
        return admin_tch_id;
    }

    public void setAdmin_tch_id(Integer admin_tch_id) {
        this.admin_tch_id = admin_tch_id;
    }

    @Override
    public String toString() {
        return "TeacherAdmin{" +
                "tch_password='" + tch_password + '\'' +
                ", admin_tch_id=" + admin_tch_id +
                '}';
    }
}
