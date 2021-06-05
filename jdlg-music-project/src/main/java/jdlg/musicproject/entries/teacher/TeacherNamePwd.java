package jdlg.musicproject.entries.teacher;

public class TeacherNamePwd {
    private String t_pwd;
    private String t_name;

    public String getT_pwd() {
        return t_pwd;
    }

    public void setT_pwd(String t_pwd) {
        this.t_pwd = t_pwd;
    }

    public String getT_name() {
        return t_name;
    }

    public void setT_name(String t_name) {
        this.t_name = t_name;
    }

    @Override
    public String toString() {
        return "TeacherNamePwd{" +
                "t_pwd='" + t_pwd + '\'' +
                ", t_name='" + t_name + '\'' +
                '}';
    }
}
