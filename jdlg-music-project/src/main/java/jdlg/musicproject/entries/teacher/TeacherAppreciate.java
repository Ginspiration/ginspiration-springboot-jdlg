package jdlg.musicproject.entries.teacher;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Arrays;
import java.util.Objects;

public class TeacherAppreciate {

    private Integer id;
    private String title;
    private String context;
    private String url;
    private Integer imgNumber;
    private Integer musicNumber;
    private Integer videoNumber;
    private Integer courseId;
    private String upTime;
    private MultipartFile[] files;

    public MultipartFile[] getFiles() {
        return files;
    }

    public void setFiles(MultipartFile[] files) {
        this.files = files;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getImgNumber() {
        return imgNumber;
    }

    public void setImgNumber(Integer imgNumber) {
        this.imgNumber = imgNumber;
    }

    public Integer getMusicNumber() {
        return musicNumber;
    }

    public void setMusicNumber(Integer musicNumber) {
        this.musicNumber = musicNumber;
    }

    public Integer getVideoNumber() {
        return videoNumber;
    }

    public void setVideoNumber(Integer videoNumber) {
        this.videoNumber = videoNumber;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public String getUpTime() {
        return upTime;
    }

    public void setUpTime(String upTime) {
        this.upTime = upTime;
    }

    @Override
    public String toString() {
        return "TeacherAppreciate{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", context='" + context + '\'' +
                ", url='" + url + '\'' +
                ", imgNumber=" + imgNumber +
                ", musicNumber=" + musicNumber +
                ", videoNumber=" + videoNumber +
                ", courseId=" + courseId +
                ", upTime='" + upTime + '\'' +
                ", files=" + Arrays.toString(files) +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TeacherAppreciate that = (TeacherAppreciate) o;
        return title.equals(that.title) &&
                context.equals(that.context) &&
                courseId.equals(that.courseId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(title, context, courseId);
    }
}
