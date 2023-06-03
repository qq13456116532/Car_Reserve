package com.gxyan.config;

import com.gxyan.pojo.Employee;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;

public class AuthInterceptor implements HandlerInterceptor {

    private static final ThreadLocal<Employee> currentUser = new ThreadLocal<>();
    public static Employee getCurrentUser() {
        return currentUser.get();
    }
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 从cookie中获取用户信息并存储到ThreadLocal中
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("user")) {
                    String userInfo = URLDecoder.decode(cookie.getValue(), "UTF-8");
                    Employee employee = parseUserInfo(userInfo);
                    currentUser.set(employee);
                    break;
                }
            }
        }

        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {

        // clear ThreadLocal to avoid memory leak
        currentUser.remove();
    }

    private Employee parseUserInfo(String userInfo) {
        String[] parts = userInfo.split(":");
        if (parts.length == 3) {
            String id_card = parts[0];
            String password = parts[1];
            int id = Integer.parseInt(parts[2]);
            Employee employee = new Employee();
            employee.setPassword(password);
            employee.setIdCard(id_card);
            employee.setId(id);
            return employee;
        } else {
            throw new IllegalArgumentException("Invalid user info: " + userInfo);
        }
    }


}

