package jdlg.musicproject.entries.common;

import java.util.Objects;

public class CoursePlus {
    private Integer cId;
    private String cName;
    private String cImgUrl;

    public Integer getcId() {
        return cId;
    }

    public void setcId(Integer cId) {
        this.cId = cId;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    public String getcImgUrl() {
        return cImgUrl;
    }

    public void setcImgUrl(String cImgUrl) {
        this.cImgUrl = cImgUrl;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CoursePlus that = (CoursePlus) o;
        return Objects.equals(cId, that.cId) &&
                Objects.equals(cName, that.cName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cId, cName);
    }
}
