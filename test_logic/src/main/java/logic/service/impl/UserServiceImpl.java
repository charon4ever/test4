package logic.service.impl;

import dao.mapper.UserMapper;
import dao.model.User;
import logic.message.request.AdminInfoRequest;
import logic.message.request.RegisterInfoRequest;
import logic.service.UserService;
import logic.util.CaptchaUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;

public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public void validateUser(HttpServletRequest request,AdminInfoRequest adminInfo) throws Exception {
        User user = userMapper.selectByPrimaryKey(adminInfo.getUserName());
        if(!user.getPassword().equals(adminInfo.getPassword())){
            throw new Exception("");
        }
        request.getSession().setAttribute("user",user);
        request.getSession().setAttribute("userName",user.getUserName());
    }

    @Override
    public String getCaptcha(HttpServletRequest request) throws Exception {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        String captcha = CaptchaUtil.generateCaptcha(outputStream);
        return captcha;
    }

    @Override
    public void registerUser(HttpServletRequest request, RegisterInfoRequest registerInfo) {
        User userInfo = new User();
        userInfo.setUserName(registerInfo.getUserName());
        userInfo.setPassword(registerInfo.getPassword());
        userInfo.setEmail(registerInfo.getEmail());
        userInfo.setMobileNumber(registerInfo.getPhoneNumber());
        userMapper.insert(userInfo);
    }
}
