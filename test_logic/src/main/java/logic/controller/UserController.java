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

    UserService userServiceImpl;

    @RequestMapping(value = "/doLogin", produces = "application/json;charset=UTF-8")
    public String login(HttpServletRequest request, AdminInfoRequest adminInfo) {
        try {
            userServiceImpl.validateUser(request, adminInfo);
        } catch (Exception e) {

        }
        return "";
    }

    @RequestMapping(value = "/login")
    public String getLoginPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            return "forward:main";
        } else {
            return "src/main/webapp/WEB-INF/views/login.jsp";
        }
    }

    @RequestMapping(value = "/getCaptcha", produces = "application/json;charset=UTF-8")
    public ResponseBean<String> getCaptcha(HttpServletRequest request) throws Exception {
        String captcha = userServiceImpl.getCaptcha(request);
        return new ResponseBean<>(captcha);
    }

//    public ResponseBean<String> register(HttpServletRequest request, RegisterInfoRequest registerInfo) {
//
//    }
}
