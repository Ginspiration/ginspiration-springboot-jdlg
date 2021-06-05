package jdlg.musicproject.entries.common;

import java.util.Objects;

public class ForumAnswer {

    private Integer id;
    private Integer queId;
    private String name;
    private String answer;
    private String upDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQueId() {
        return queId;
    }

    public void setQueId(Integer queId) {
        this.queId = queId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getUpDate() {
        return upDate;
    }

    public void setUpDate(String upDate) {
        this.upDate = upDate;
    }

    @Override
    public String toString() {
        return "ForumAnswer{" +
                "id=" + id +
                ", queId=" + queId +
                ", name='" + name + '\'' +
                ", answer='" + answer + '\'' +
                ", upDate='" + upDate + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (getAnswer() == null
                && getId() == null
                && getName() == null
                && getQueId() == null
                && getUpDate() == null
                && o == null)
            return true;
        if (getClass() != o.getClass()) return false;
        ForumAnswer that = (ForumAnswer) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(queId, that.queId) &&
                Objects.equals(name, that.name) &&
                Objects.equals(answer, that.answer) &&
                Objects.equals(upDate, that.upDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, queId, name, answer, upDate);
    }
}
