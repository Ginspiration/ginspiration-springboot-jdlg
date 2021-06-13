package jdlg.musicproject.exception;


import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

//@Controller
//public class Error500 {
//
//    @ExceptionHandler(Throwable.class)
//    public @ResponseBody String handleCustomException(HttpServletRequest request) {
//        return "<h1>error500</h1>";
//    }
//
//}
//@ControllerAdvice(basePackages = "jdlg.musicproject")
//public class Error500 extends ResponseEntityExceptionHandler {
//
//    @ResponseBody
//    @ExceptionHandler(Throwable.class)
//    public String handleControllerException(HttpServletRequest request, Throwable ex) {
//        HttpStatus status = getStatus(request);
//        return "<h1>error500</h1>"+status.toString();
//    }
//
//    private HttpStatus getStatus(HttpServletRequest request) {
//        Integer code = (Integer) request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
//        HttpStatus status = HttpStatus.resolve(code);
//        return (status != null) ? status : HttpStatus.INTERNAL_SERVER_ERROR;
//    }
//}
@Component
public class ErrorSkip implements ErrorViewResolver {

    @Override
    public ModelAndView resolveErrorView(HttpServletRequest request, HttpStatus status, Map<String, Object> model) {
        ModelAndView mv = new ModelAndView();
        if (status == HttpStatus.NOT_FOUND) {
            mv.addObject("errorStatus", 404);
            // We could add custom model values here
            mv.setViewName("web_error/error");
        } else if (status == HttpStatus.INTERNAL_SERVER_ERROR) {
            mv.addObject("errorStatus", 500);
            // We could add custom model values here
            mv.setViewName("web_error/error");
        }else{
            mv.addObject("errorStatus", 87654321);
            // We could add custom model values here
            mv.setViewName("web_error/error");
        }
        return mv;
    }

}