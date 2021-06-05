package jdlg.musicproject.entries.teacher;

import java.io.File;
import java.util.Arrays;
import java.util.Objects;

public class TeacherKnowAll {
    private String title;
    private String context;
    private String time;
    private Integer id;
    //图片数量
    private Integer imgNumber;
    //图片文件
    private File[] files;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Integer getImgNumber() {
        return imgNumber;
    }

    public void setImgNumber(Integer imgNumber) {
        this.imgNumber = imgNumber;
    }

    public File[] getFiles() {
        return files;
    }

    public void setFiles(File[] files) {
        this.files = files;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TeacherKnowAll all = (TeacherKnowAll) o;
        return Objects.equals(title, all.title) &&
                Objects.equals(context, all.context) &&
                Objects.equals(time, all.time) &&
                Objects.equals(id, all.id) &&
                Objects.equals(imgNumber, all.imgNumber) &&
                Arrays.equals(files, all.files);
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(title, context, time, id, imgNumber);
        result = 31 * result + Arrays.hashCode(files);
        return result;
    }
}
