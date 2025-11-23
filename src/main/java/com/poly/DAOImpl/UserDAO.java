package com.poly.DAOImpl;

import com.poly.DAO.IUserDAO;
import com.poly.entity.User;

import java.util.List;

public class UserDAO extends AbstractDAO<User> implements IUserDAO {
    public UserDAO() {
        super(User.class);
    }

    @Override
    public User findByIdAndPassword(String id, String password) {
        String hql = "SELECT u FROM User u WHERE u.id = ?1 AND u.password = ?2";
        List<User> list = findMany(hql, -1, -1, id, password);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public User findByEmail(String email) {
        String hql = "SELECT u FROM User u WHERE u.email = ?1";
        List<User> list = findMany(hql, -1, -1, email);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public User findByUsernameAndEmail(String id, String email) {
        String hql = "SELECT u FROM User u WHERE u.id = ?1 AND u.email = ?2";
        List<User> list = findMany(hql, -1, -1, id, email);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<User> findAll(int page, int pageSize) {
        String hql = "SELECT u FROM User u";
        int firstResult = (page - 1) * pageSize;
        return findMany(hql, firstResult, pageSize);
    }
}
