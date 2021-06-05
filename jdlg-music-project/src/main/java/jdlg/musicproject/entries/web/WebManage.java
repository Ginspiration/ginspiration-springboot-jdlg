package jdlg.musicproject.entries.web;

public class WebManage {
    private Integer webUsed;
    private Integer registered;

    public Integer getWebUsed() {
        return webUsed;
    }

    public void setWebUsed(Integer webUsed) {
        this.webUsed = webUsed;
    }

    public Integer getRegistered() {
        return registered;
    }

    public void setRegistered(Integer registered) {
        this.registered = registered;
    }

    @Override
    public String toString() {
        return "WebManage{" +
                "webUsed=" + webUsed +
                ", registered=" + registered +
                '}';
    }
}
