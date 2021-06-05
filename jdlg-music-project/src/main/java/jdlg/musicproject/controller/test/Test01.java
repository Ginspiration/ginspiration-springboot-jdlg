package jdlg.musicproject.controller.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;

@Controller
public class Test01 {
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
            //文件上传的地址
            String url = "";
            //文件输出流
            FileOutputStream out = new FileOutputStream(url);
            //输出缓冲流
            BufferedOutputStream buffOut = new BufferedOutputStream(out);
            //一次读取1kb
            byte[] bytes = new byte[1024];
            //读取到的数量
            int readCount;
            //读取到-1说明读取结束
            while ((readCount = in.read(bytes)) != -1){
                //写入本地文件，write(字节对象,开始处，结束处)
                buffOut.write(bytes,0,readCount);
            }
            //关闭输入流
            in.close();
            //刷新管道
            buffOut.flush();
            //关闭缓冲流
            buffOut.close();
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
