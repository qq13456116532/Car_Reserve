package com.gxyan.controller;

import com.gxyan.common.Const;
import com.gxyan.common.ServerResponse;
import com.gxyan.dao.EmployeeMapper;
import com.gxyan.pojo.Employee;
import com.gxyan.service.IEmployeeService;
import com.gxyan.service.IUserService;
import com.gxyan.vo.LoginVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @author gxyan
 * @date 2018/12/26 20:39
 */
@Slf4j
@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    private IUserService userService;
    @Autowired
    private IEmployeeService employeeService;

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public ServerResponse login(@RequestBody LoginVo loginVo, HttpSession session) {
        String employeeId = loginVo.getUsername();
        String password = loginVo.getPassword();
        ServerResponse response = userService.login(Integer.valueOf(employeeId), password);
        if (response.isSuccess()) {
            session.setAttribute(Const.CURRENT_USER, response.getData());

            Map<String, String> map = new HashMap <>(1);
            map.put("token",employeeId );
            response = ServerResponse.createBySuccess(map);
        }
        log.info("userId:{}, password:{}, data:{}", employeeId, password, response.getData());
        return response;
    }

    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public ServerResponse logout(HttpSession session) {
        session.removeAttribute(Const.CURRENT_USER);
        return ServerResponse.createBySuccess();
    }

    @Autowired
    EmployeeMapper employeeMapper;

    @RequestMapping(value = "info", method = RequestMethod.POST)
    public ServerResponse<Employee> info(String token,HttpSession session) {
        Employee employee = employeeMapper.selectById(Integer.parseInt(token));
        if (employee == null) {
            return ServerResponse.createByErrorMessage("用户未登录，无法获取当前用户信息");
        }
        return ServerResponse.createBySuccess(employee);
    }

    @RequestMapping(value = "updateMessage", method = RequestMethod.POST)
    public ServerResponse updateMessage(Employee employee) {
        return employeeService.updateEmployee(employee);
    }

    @RequestMapping(value = "validPassword", method = RequestMethod.POST)
    public ServerResponse validPassword(HttpSession session, String validPass) {
        Employee employee = (Employee) session.getAttribute(Const.CURRENT_USER);
        return employeeService.validPassword(employee.getId(), validPass);
    }

    @RequestMapping(value = "updatePassword", method = RequestMethod.POST)
    public ServerResponse updatePassword(HttpSession session, String oldPass, String newPass) {
        Employee employee = (Employee) session.getAttribute(Const.CURRENT_USER);
        return employeeService.updatePassword(employee.getId(), oldPass, newPass);
    }
}
