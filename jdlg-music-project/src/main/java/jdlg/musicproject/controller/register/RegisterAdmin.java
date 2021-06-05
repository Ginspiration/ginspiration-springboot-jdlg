package jdlg.musicproject.controller.register;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RegisterAdmin {
    /*注册选择*/
    @RequestMapping("/registerPosition")
    public ModelAndView userRegister() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/admin-register-select");
        return mv;
    }
}
