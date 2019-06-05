package logic.service;

import logic.message.request.AdminInfoRequest;
import logic.message.request.RegisterInfoRequest;

import javax.servlet.http.HttpServletRequest;

public interface UserService {
    public void validateUser(HttpServletRequest request, AdminInfoRequest adminInfo) throws Exception;

    public String getCaptcha(HttpServletRequest request) throws Exception;

    public void registerUser(HttpServletRequest request, RegisterInfoRequest registerInfo);
}
