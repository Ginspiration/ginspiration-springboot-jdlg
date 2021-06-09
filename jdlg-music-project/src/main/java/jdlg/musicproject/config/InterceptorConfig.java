package jdlg.musicproject.config;

import jdlg.musicproject.entries.teacher.Teacher;
import jdlg.musicproject.interceptor.login.StudentInterceptor;
import jdlg.musicproject.interceptor.login.TeacherInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {
    /**
     *     <!--拦截器配置-->
     *     <mvc:interceptors>
     *         <!--教师请求拦截-->
     *         <mvc:interceptor>
     *             <!--拦截请求地址-->
     *             <mvc:mapping path="/doTeacher/*"/>
     *             <!--拦截器类所在类-->
     *             <bean class="jdlg.musicproject.interceptor.login.TeacherInterceptor"/>
     *         </mvc:interceptor>
     *         <!--学生请求拦截-->
     *         <mvc:interceptor>
     *             <mvc:mapping path="/doStudent/*"/>
     *             <bean class="jdlg.musicproject.interceptor.login.StudentInterceptor"/>
     *         </mvc:interceptor>
     *     </mvc:interceptors>
     * @param registry
     */
    @Autowired
    private TeacherInterceptor teacherInterceptor;
    @Autowired
    private StudentInterceptor studentInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //设置拦截路径
       registry.addInterceptor(teacherInterceptor).addPathPatterns("/doTeacher/*");
       registry.addInterceptor(studentInterceptor).addPathPatterns("/doStudent/*");
       //.excludePathPatterns(excludePathPatterns); //添加不需要拦截的路径
    }
}
