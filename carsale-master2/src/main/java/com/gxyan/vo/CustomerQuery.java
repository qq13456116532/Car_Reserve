package com.gxyan.vo;

import lombok.Data;

/**
 * @author gxyan
 * @date 2019/1/6 13:29
 */
@Data
public class CustomerQuery {
    private int page = 1;

    private int limit = 5;

    private String id;

    private String name;

    private String phone;

    private String idCard;

    private String orderBy;
}
