package jdlg.musicproject.entries.common;

public class Register {
    private String sRegName;
    private Integer sRegNumber;
    private String sRegPwd;

    public String getsRegName() {
        return sRegName;
    }

    public void setsRegName(String sRegName) {
        this.sRegName = sRegName;
    }

    public Integer getsRegNumber() {
        return sRegNumber;
    }

    public void setsRegNumber(Integer sRegNumber) {
        this.sRegNumber = sRegNumber;
    }

    public String getsRegPwd() {
        return sRegPwd;
    }

    public void setsRegPwd(String sRegPwd) {
        this.sRegPwd = sRegPwd;
    }

    @Override
    public String toString() {
        return "Register{" +
                "sRegName='" + sRegName + '\'' +
                ", sRegNumber=" + sRegNumber +
                ", sRegPwd='" + sRegPwd + '\'' +
                '}';
    }
}
