package com.gxyan.pojo;

import lombok.Data;
import lombok.ToString;
import org.apache.ibatis.annotations.Param;

import java.util.Date;

@Data
@ToString
public class Customer {
    private String id;
    private String name;
    private String phone;
    private String id_card;
    private String create_time;



    public Customer() {
        super();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getIdCard() {
        return id_card;
    }

    public void setIdCard(String idCard) {
        this.id_card = idCard == null ? null : idCard.trim();
    }

    public String getCreateTime() {
        return create_time;
    }

    public void setCreateTime(String createTime) {
        this.create_time = createTime;
    }
}