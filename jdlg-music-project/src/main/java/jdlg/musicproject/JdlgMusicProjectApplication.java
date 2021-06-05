package jdlg.musicproject;

import jdlg.musicproject.config.ProjectConfig;
import org.springframework.beans.BeansException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Import;

@SpringBootApplication
@Import(ProjectConfig.class)
public class JdlgMusicProjectApplication{

	public static void main(String[] args) {
		SpringApplication.run(JdlgMusicProjectApplication.class, args);
	}
}
