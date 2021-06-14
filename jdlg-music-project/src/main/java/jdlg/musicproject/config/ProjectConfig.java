package jdlg.musicproject.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Configuration
//@ImportResource({"classpath:dispatcherServlet.xml", "classpath:applicationContext.xml", "classpath:mybatis.xml"})
@MapperScan("jdlg.musicproject.dao")
//事务驱动
@EnableTransactionManagement
@Import(InterceptorConfig.class)
public class ProjectConfig {
    /*
    *  <bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
        <property name="maxUploadSize" value="1073741824000000000"/>
        <!--设置10M文件内存储存，当文件大于10M时文件将写入服务器磁盘-->
        <property name="maxInMemorySize" value="10485760"/>
        <property name="defaultEncoding" value="UTF-8"/>
        <!--<property name="uploadTempDir" value=""/>-->
    </bean>

    /**
     * 文件上传配置类
     * @return
     */
    @Bean
    public CommonsMultipartResolver commonsMultipartResolver(){
        CommonsMultipartResolver cmr = new CommonsMultipartResolver();
        cmr.setMaxUploadSize(1073741824000000000L);
        cmr.setMaxInMemorySize(10485760);
        cmr.setDefaultEncoding("UTF-8");
        return cmr;
    }
}
