package com.gxyan.dao;

import com.gxyan.pojo.Carshop;
import com.gxyan.pojo.Customer;

import java.util.List;

public interface CarshopMapper {
    public List<Carshop> selectChinese();

    public Carshop selectById(int id);
    public List<Carshop> selectAmerica();

    public List<Carshop> selectJapanese();

    public List<Carshop> selectByBrand(String brand);

    public List<Carshop> getAllShop();

    Carshop getById(String id);

    void insertSelective(Carshop carshop);
    void updateByPrimaryKeySelective(Carshop record);


    void deleteById(Integer id);
}
