package jdlg.musicproject.entries.student;

public class StudentNamePwd {
    private String s_pwd;
    private String s_name;

    public String getS_pwd() {
        return s_pwd;
    }

    public void setS_pwd(String s_pwd) {
        this.s_pwd = s_pwd;
    }

    public String getS_name() {
        return s_name;
    }

    public void setS_name(String s_name) {
        this.s_name = s_name;
    }

    @Override
    public String toString() {
        return "StudentNamePwd{" +
                "s_pwd='" + s_pwd + '\'' +
                ", s_name='" + s_name + '\'' +
                '}';
    }
}
