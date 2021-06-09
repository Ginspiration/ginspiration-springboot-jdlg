package jdlg.musicproject.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class SaveFiles {
    public static boolean doSave(MultipartFile file, Integer tId, Integer cId, String title, String type) {
        //jdlg-music-project/target/classes/META-INF/resources/WEB-INF/upload/appreciate
        String partDir = System.getProperty("MyWebUrl") + "\\META-INF\\resources\\WEB-INF\\upload\\appreciate\\" + tId + "\\" + cId + "\\" + title + "\\" + type + "\\";
        File file1 = new File(partDir);
        if (!file1.exists())
            file1.mkdirs();
        FileOutputStream out = null;
        InputStream in = null;
        try {
            in = file.getInputStream();
            out = new FileOutputStream(partDir + file.getOriginalFilename());
            byte[] bytes = new byte[1048576];
            int readCount;
            while ((readCount = in.read(bytes)) != -1) {
                out.write(bytes, 0, readCount);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                out.flush();
                out.close();
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }
        return true;
    }
}
