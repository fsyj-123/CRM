package com.fsyj.crm.web.filter;

import com.fsyj.crm.utils.constStrings.Path;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashSet;

public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession();
        String path = request.getServletPath();
        HashSet<String> letSet = new HashSet<>();

        letSet.add("/index.jsp");
        letSet.add("/login.jsp");
        letSet.add("/settings/user.do");

        /*
        在项目中，所有路径都是使用的绝对路径
        请求转发与请求重定向
            请求转发：不用加/项目名
            请求重定向：需要加上/项目名  在需要将浏览器地址栏更改时使用重定向
         */
        if (session.getAttribute("user") != null || letSet.contains(path)) {
            filterChain.doFilter(req,resp);
        } else {
            response.sendRedirect(Path.PROJECT_PATH + "login.jsp");
        }
    }
}
