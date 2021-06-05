package jdlg.musicproject.entries.common;

public class Seek {
    private Integer seekId;

    public Integer getSeekId() {
        return seekId;
    }

    public void setSeekId(Integer seekId) {
        this.seekId = seekId;
    }

    @Override
    public String toString() {
        return "Seek{" +
                "seekId=" + seekId +
                '}';
    }
}
