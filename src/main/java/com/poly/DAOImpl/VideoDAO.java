package com.poly.DAOImpl;

import com.poly.DAO.IVideoDAO;
import com.poly.entity.Video;
import com.poly.util.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class VideoDAO extends AbstractDAO<Video> implements IVideoDAO {
    public VideoDAO() {
        super(Video.class);
    }

    @Override
    public List<Video> findTopVideosByViews(int maxResult) {
        String hql = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.views DESC";
        return findMany(hql, 0, maxResult);
    }

    @Override
    public List<Video> findAll(int page, int pageSize) {
        String hql = "SELECT v FROM Video v";
        // firstResult = (trang hiện tại - 1) * số lượng mỗi trang
        int firstResult = (page - 1) * pageSize;
        return findMany(hql, firstResult, pageSize);
    }

    @Override
    public List<Video> findByTitle(String title) {
        String hql = "SELECT v FROM Video v WHERE v.titile LIKE ?1";
        return findMany(hql, -1, -1, "%" + title + "%");
    }

    @Override
    public void incrementViews(String videoId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            em.getTransaction().begin();
            Video video = em.find(Video.class, videoId);
            if (video != null) {
                video.setViews(video.getViews() + 1);
                em.merge(video);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    // --- SỬA/THÊM HÀM NÀY ---
    @Override
    public List<Video> findAllActive(int page, int pageSize) {
        String hql = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.id DESC";
        // Tính vị trí bắt đầu cắt: (Trang hiện tại - 1) * Số lượng 1 trang
        int firstResult = (page - 1) * pageSize;
        return findMany(hql, firstResult, pageSize);
    }

    // --- THÊM HÀM NÀY (Để tính tổng số trang) ---
    @Override
    public long countActive() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String hql = "SELECT count(v) FROM Video v WHERE v.active = true";
            return (long) em.createQuery(hql).getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Object[]> reportFavorites() {
        String hql = "SELECT v.titile, count(f), min(f.likeDate), max(f.likeDate) " +
                "FROM Video v LEFT JOIN v.favorites f " +
                "GROUP BY v.titile";
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery(hql, Object[].class).getResultList();
        } finally {
            em.close();
        }
    }
}
