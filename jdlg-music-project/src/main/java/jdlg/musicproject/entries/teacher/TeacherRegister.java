package jdlg.musicproject.entries.teacher;

public class TeacherRegister {
    private String admin_Name;
    private String password;

    public String getAdmin_Name() {
        return admin_Name;
    }

    public void setAdmin_Name(String admin_Name) {
        this.admin_Name = admin_Name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "TeacherRegister{" +
                "admin_Name='" + admin_Name + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
