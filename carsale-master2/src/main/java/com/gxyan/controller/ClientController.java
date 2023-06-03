package com.gxyan.controller;

import com.gxyan.common.ServerResponse;
import com.gxyan.config.AuthInterceptor;
import com.gxyan.dao.CarshopMapper;
import com.gxyan.dao.CustomerMapper;
import com.gxyan.dao.EmployeeMapper;
import com.gxyan.dao.ReservationMapper;
import com.gxyan.pojo.Carshop;
import com.gxyan.pojo.Customer;
import com.gxyan.pojo.Employee;
import com.gxyan.pojo.Reservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

@RestController
public class ClientController {
    @Resource
    CustomerMapper customerMapper;

    @Resource
    EmployeeMapper employeeMapper;
    @GetMapping("/register")
    public ServerResponse register(String Name,String password,String userName,String id) {
        Customer customer = new Customer();
        customer.setIdCard(id);
        customer.setName(Name);
        customer.setCreateTime(String.valueOf(new Date()));
        customer.setId(new String(String.valueOf(new Random().nextLong())));
        Employee employee = new Employee();
        employee.setName(Name);
        employee.setPassword(password);
        employee.setGender("男");
        employee.setIdCard(userName);
        employee.setRole("0");
        employee.setId(new Random().nextInt(20000));
        employee.setSalary(new BigDecimal(0.5));
        customerMapper.insert(customer);
        employeeMapper.insert(employee);
        String res = "successZC";
        return ServerResponse.createBySuccess(res);
    }


    @GetMapping("/login")
    public ServerResponse login(HttpServletRequest request, HttpServletResponse response, String password, String userName) throws UnsupportedEncodingException {
        Employee employee = employeeMapper.selectByNameAndPassword(password, userName);
        String res="";
        if(employee!=null){
             res = "success";
            // 将用户信息写入到Cookie中
            Cookie cookie = new Cookie("user", employee.getIdCard()+":"+employee.getPassword()+":"+employee.getId());
            cookie.setMaxAge(24 * 60 * 60); // 设置cookie的有效期为1天
            cookie.setPath("/"); // 设置cookie的路径为根路径
            response.addCookie(cookie);
        } else
            res= "error";
        return ServerResponse.createBySuccess(res);
//        return new ResponseEntity<>(res, HttpStatus.OK);

    }

    @Autowired
    CarshopMapper carshopMapper;
    @GetMapping("/getAllCarShop")
    public ServerResponse getAllCarShop(){
       return ServerResponse.createBySuccess(carshopMapper.getAllShop());
    }

    @GetMapping("/selectCarShop")
    public ServerResponse selectCarShop(String key){
        List<Carshop> carshops;
        if(key.equals("China")){
            carshops = carshopMapper.selectChinese();
        }else if (key.equals("America")){
            carshops = carshopMapper.selectAmerica();
        }else if (key.equals("Japan")){
            carshops = carshopMapper.selectJapanese();
        }else{
            carshops = carshopMapper.selectByBrand(key);
        }
        return ServerResponse.createBySuccess(carshops);
    }

    @Resource
    ReservationMapper reservationMapper;

    @GetMapping("/nowEvent")
    public ServerResponse nowEvent(String y,String m,String d,String s,String e,String roomid,String infodel){
        Employee currentUser = AuthInterceptor.getCurrentUser();
        Reservation reservation = new Reservation();
        Calendar cal = Calendar.getInstance();
        cal.set(Integer.parseInt(y), Integer.parseInt(m) - 1, Integer.parseInt(d)); // 注意月份需要减1
        Date date = cal.getTime();
        reservation.setDay(date);

//        reservation.setDay(new Date(Integer.parseInt(y),Integer.parseInt(m),Integer.parseInt(d)));
        if(currentUser != null){
            reservation.setEmpid(currentUser.getId());
            reservation.setUsername(currentUser.getIdCard()==null?"***":currentUser.getIdCard());
        }else{
            reservation.setEmpid(new Random().nextInt(50));
            reservation.setUsername("***");
        }
        Carshop carshop1 = carshopMapper.selectById(Integer.parseInt(roomid));
        reservation.setShopname(carshop1.getName());
        reservation.setEnd(e);
        reservation.setStart(s);
        reservation.setShopid(roomid);
        reservation.setInfodel(infodel);
        Carshop carshop = carshopMapper.selectById(Integer.parseInt(roomid));
        reservationMapper.insert(reservation);
        return ServerResponse.createBySuccess();
    }

    @RequestMapping("/getAllReservation")
    public ServerResponse getAllReservation(String keyword){
        if(keyword!=null && !keyword.equals("")){
            List<Reservation> reservationList = reservationMapper.selectByKeyWord(keyword);
            return ServerResponse.createBySuccess(reservationList);
        }
        List<Reservation> reservationList =reservationMapper.selectall();
        for (Reservation reservation : reservationList) {
            reservation.setUsername(reservation.getUsername()==null?"***":reservation.getUsername());
        }
        return ServerResponse.createBySuccess(reservationList);
    }
    @RequestMapping("/getOneReservation")
    public ServerResponse getOneReservation(Integer id){
        Reservation reservation = reservationMapper.getById(id);
        return ServerResponse.createBySuccess(reservation);
    }
    @RequestMapping("/NoEvent")
    public ServerResponse NoEvent(Integer id){
        reservationMapper.deleteById(id);
        return ServerResponse.createBySuccess(null);
    }

}
