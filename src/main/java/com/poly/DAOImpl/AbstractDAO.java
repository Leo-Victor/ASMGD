package com.poly.DAOImpl;

import com.poly.DAO.IGenericDAO;
import com.poly.util.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;

import java.util.List;
/**
 * Lớp DAO cơ bản sử dụng Generic cho các Entity Class
 * @param <T> Loại Entity Class
 */
public class AbstractDAO<T> implements IGenericDAO<T> {
    private Class<T> entityClass;

    public AbstractDAO(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    @Override
    public T create(T entity) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(entity);
            trans.commit();
            return entity;
        } catch (Exception e) {
            if(trans.isActive()) trans.rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }

    @Override
    public T update(T entity) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            T result = em.merge(entity);
            trans.commit();
            return result;
        } catch (Exception e) {
            if(trans.isActive()) trans.rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(Object id) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            T entity = em.find(entityClass, id);
            if (entity != null) {
                em.remove(entity);
            }
            trans.commit();
        } catch (Exception e) {
            if(trans.isActive()) trans.rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }

    @Override
    public T findById(Object id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(entityClass, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<T> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String hql = "SELECT o FROM " + entityClass.getSimpleName() + " o";
            return em.createQuery(hql, entityClass).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<T> findMany(String hql, int firstResult, int maxResult, Object... params) {
        EntityManager em = XJPA.getEntityManager();
        try {
            Query query = em.createQuery(hql, entityClass);
            if (firstResult >= 0) query.setFirstResult(firstResult);
            if (maxResult > 0) query.setMaxResults(maxResult);

            for (int i = 0; i < params.length; i++) {
                query.setParameter(i + 1, params[i]); // Tham số trong JPA bắt đầu từ 1 (?1, ?2)
            }
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long count() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String hql = "SELECT count(o) FROM " + entityClass.getSimpleName() + " o";
            Query query = em.createQuery(hql);
            return (Long) query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
