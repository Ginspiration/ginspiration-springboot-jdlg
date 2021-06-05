package jdlg.musicproject.controller.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginAdmin {
    @RequestMapping("/loginPosition")
    public ModelAndView userLogin() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("admin/admin-login-select");
        return mv;
    }
}