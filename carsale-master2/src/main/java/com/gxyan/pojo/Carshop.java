package com.gxyan.pojo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;

@Data
@Getter
@Setter
public class Carshop {
    private Integer id;
    private String name;
    private String address;
    private String phone;
    private String brand;
    private String business_hours;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private Date created_time;
    private Date updated_time;



}
