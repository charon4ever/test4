package logic.service.impl;

import logic.message.request.AdminInfoRequest;
import logic.message.request.RegisterInfoRequest;
import logic.service.UserService;
import logic.util.CaptchaUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;

public class UserServiceImpl implements UserService {
    @Override
    public void validateUser(HttpServletRequest request,AdminInfoRequest adminInfo) throws Exception {
        HttpSession session = request.getSession();
        if(!session.getAttribute("password").equals(adminInfo.getPassword())){
            throw new Exception("");
        }
    }

    @Override
    public String getCaptcha(HttpServletRequest request) throws Exception {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        String captcha = CaptchaUtil.generateCaptcha(outputStream);
        return captcha;
    }

    @Override
    public void registerUser(HttpServletRequest request, RegisterInfoRequest registerInfo) {

    }
}
