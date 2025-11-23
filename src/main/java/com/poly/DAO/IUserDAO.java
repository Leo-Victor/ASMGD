package com.poly.DAO;

import com.poly.entity.User;

import java.util.List;

public interface IUserDAO extends IGenericDAO<User>{
    User findByIdAndPassword(String id, String password);
    User findByEmail(String email);
    User findByUsernameAndEmail(String id, String email);
    // Lấy danh sách user có phân trang cho Admin
    List<User> findAll(int page, int pageSize);
}
