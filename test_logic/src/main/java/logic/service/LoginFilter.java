package logic.service;

import logic.config.InterServiceEnum;
import logic.config.messageCode.BaseMessageCode;
import logic.model.Exception.NibErrorInfo;
import logic.model.Exception.NibException;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        try {
            checkLogin(req, resp);
            //checkAuth(req);  可能放在别的filter中更好
            filterChain.doFilter(servletRequest, servletResponse);
        } catch (Exception e) {
            RequestDispatcher rd = servletRequest.getRequestDispatcher("/login");
            rd.forward(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {

    }

    private void checkLogin(HttpServletRequest httpRequest, HttpServletResponse httpResponse) {
        HttpSession session = httpRequest.getSession();
        if (session.getAttribute("user") == null) {
            throw new NibException(InterServiceEnum.TEST.getInternalServiceId(), new NibErrorInfo(BaseMessageCode.ERROR_CODE_USER_NOT_LOGIN,
                    "user not login"));
        }
    }

    private void checkAuth(HttpServletRequest httpRequest) {

    }
}
