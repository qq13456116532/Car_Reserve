package com.gxyan.controller;

import com.gxyan.common.ServerResponse;
import com.gxyan.dao.CarshopMapper;
import com.gxyan.pojo.Carshop;
import com.gxyan.pojo.Customer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("carshop")
public class CarShopController {

    @Autowired
    CarshopMapper carshopMapper;

    @RequestMapping(value = "getById", method = RequestMethod.GET)
    public ServerResponse getList(String id) {
        return ServerResponse.createBySuccess(carshopMapper.getById(id));
    }

    @RequestMapping(value = "update", method = RequestMethod.POST)
    public ServerResponse update(Carshop carshop) {
        if(carshop.getId()!=null && carshop.getId().equals("-1")){
            carshopMapper.updateByPrimaryKeySelective(carshop);
            //插入
        }else{
            carshopMapper.insertSelective(carshop);
        }
        return ServerResponse.createBySuccess();
    }
    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public ServerResponse update(Integer id) {
        carshopMapper.deleteById(id);
        return ServerResponse.createBySuccess();
    }


}
