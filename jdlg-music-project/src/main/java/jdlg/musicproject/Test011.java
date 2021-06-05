package jdlg.musicproject;

import jdlg.musicproject.entries.teacher.TeacherAppreciate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;

public class Test011 {
    @RequestMapping(value = "/fileTest",method = RequestMethod.POST,produces = "application/josn;charset=UTF-8")
    public String upFiles(UpFileClassTest test) throws IOException {
        System.out.println(test.toString());
        MultipartFile[] files = test.getFiles();
        for (MultipartFile file : files) {
            System.out.println("文件类型:"+file.getContentType());
            System.out.println("获取原始文件名:"+file.getOriginalFilename());
            System.out.println("获取文件大小:"+file.getSize());
            //获取输入流对象
            InputStream in = file.getInputStream();

        }
        return "文件上传成功!";
    }
}
class UpFileClassTest{
    private String stuName;
    private MultipartFile[] files;

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public MultipartFile[] getFiles() {
        return files;
    }

    public void setFiles(MultipartFile[] files) {
        this.files = files;
    }

    @Override
    public String toString() {
        return "UpFileClassTest{" +
                "stuName='" + stuName + '\'' +
                ", files=" + Arrays.toString(files) +
                '}';
    }
}
