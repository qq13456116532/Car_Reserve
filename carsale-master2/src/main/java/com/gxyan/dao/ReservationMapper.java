package com.gxyan.dao;


import com.gxyan.pojo.Reservation;

import java.util.List;

public interface ReservationMapper {
    int insert(Reservation reservation);
    List<Reservation> selectEmpById(int empid);

    List<Reservation> selectall();

    List<Reservation> selectByKeyWord(String keyword);

    Reservation getById(Integer id);

    void deleteById(Integer id);
}
