package com.poly.DAOImpl;

import com.poly.DAO.IFavoriteDAO;
import com.poly.entity.Favorite;

import java.util.List;

public class FavoriteDAO extends AbstractDAO<Favorite> implements IFavoriteDAO {
    // Nghiệp vụ: Tìm tất cả Video yêu thích của một User [cite: 47]
    public FavoriteDAO() {
        super(Favorite.class);
    }

    @Override
    public List<Favorite> findByUser(String userId) {
        String hql = "SELECT f FROM Favorite f WHERE f.user.id = ?1 ORDER BY f.likeDate DESC";
        return findMany(hql, -1, -1, userId);
    }

    @Override
    public Favorite findByUserAndVideo(String userId, String videoId) {
        String hql = "SELECT f FROM Favorite f WHERE f.user.id = ?1 AND f.video.id = ?2";
        List<Favorite> list = findMany(hql, -1, -1, userId, videoId);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<Favorite> findByVideoId(String videoId) {
        // Dùng cho trang Báo cáo Admin: Xem ai đã like video này
        String hql = "SELECT f FROM Favorite f WHERE f.video.id = ?1";
        return findMany(hql, -1, -1, videoId);
    }
}
