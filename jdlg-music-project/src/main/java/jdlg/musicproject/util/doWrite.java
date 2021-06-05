package jdlg.musicproject.util;

import javax.servlet.http.HttpServletResponse;
import java.io.*;

public class doWrite {
    private File file;
    private int fileId;
    private HttpServletResponse response;
    private static final Object syn = new Object();

    public doWrite(File file, int fileId, HttpServletResponse response) {
        this.file = file;
        this.fileId = fileId;
        this.response = response;
    }

    public void writeFileToResponse() {
        synchronized (syn) {
            File[] files = file.listFiles();
            for (int i = 0; i < files.length; i++) {
                if (fileId == i) {
                    OutputStream out = null;
                    InputStream in = null;
                    try {
                        out = new BufferedOutputStream(response.getOutputStream());
                        in = new FileInputStream(files[i].getAbsolutePath());
                        byte[] bytes = new byte[1024 * 500];
                        int readCount;
                        while ((readCount = in.read(bytes)) != -1) {
                            out.write(bytes, 0, readCount);
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            out.flush();
                            out.close();
                            in.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
    }
}
