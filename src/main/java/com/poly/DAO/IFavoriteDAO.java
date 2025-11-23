package com.poly.DAO;

import com.poly.entity.Favorite;

import java.util.List;

public interface IFavoriteDAO extends IGenericDAO<Favorite>{
    // Lấy danh sách video user đã like
    List<Favorite> findByUser(String userId);
    // Kiểm tra user đã like video này chưa
    Favorite findByUserAndVideo(String userId, String videoId);
    // BÁO CÁO: Lấy danh sách người yêu thích theo từng Video
    List<Favorite> findByVideoId(String videoId);
}
