package logic.controller;

import logic.message.request.AdminInfoRequest;
import logic.message.request.RegisterInfoRequest;
import logic.message.response.ResponseBean;
import logic.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    private UserService userServiceImpl;

    @RequestMapping(value = "/doLogin", produces = "application/json;charset=UTF-8")
    public ResponseBean<String> login(HttpServletRequest request, AdminInfoRequest adminInfo) {
        try {
            userServiceImpl.validateUser(request, adminInfo);
        } catch (Throwable e) {
            return new ResponseBean<>(e);
        }
        return new ResponseBean<>();
    }

    @RequestMapping(value = "/login")
    public String getLoginPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            return "forward:main";
        } else {
            return "login";
        }
    }

    @RequestMapping(value = "/getCaptcha", produces = "application/json;charset=UTF-8")
    public ResponseBean<String> getCaptcha(HttpServletRequest request) throws Exception {
        String captcha = userServiceImpl.getCaptcha(request);
        return new ResponseBean<>(captcha);
    }


    @RequestMapping(value = "/register")
    public String getRegisterPage(HttpServletRequest request) {
        request.setAttribute("viewPage","registerModal.jsp");
        return "login";
    }


    @RequestMapping(value = "/doRegister",produces = "application/json;charset=UTF-8")
    public ResponseBean<String> register(HttpServletRequest request, RegisterInfoRequest registerInfo) {
        try{
            userServiceImpl.registerUser(request, registerInfo);
        }catch (Exception e){
            return new ResponseBean<>(e);
        }

        return new ResponseBean<>();
    }
}
