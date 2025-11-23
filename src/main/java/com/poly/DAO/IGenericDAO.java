package com.poly.DAO;

import java.util.List;

public interface IGenericDAO<T> {
    T create(T entity);
    T update(T entity);
    void delete(Object id);
    T findById(Object id);
    List<T> findAll();
    List<T> findMany(String hql, int firstResult, int maxResult, Object... params);
    long count();
}
