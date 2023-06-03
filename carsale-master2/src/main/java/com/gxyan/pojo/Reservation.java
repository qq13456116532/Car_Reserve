package com.gxyan.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class Reservation {

    private Integer id;
    private String shopid;
    private String username;
    private String start;
    private String end;
    private Date day;
    private String shopname;
    private Integer empid;
    //用途
    private String infodel;
}
