package com.poly.DAO;

import com.poly.entity.Video;

import java.util.List;

public interface IVideoDAO extends IGenericDAO<Video>{
    // Lấy top video cho trang chủ
    List<Video> findTopVideosByViews(int maxResult);
    // Phân trang cho Admin (Trang bao nhiêu, lấy bao nhiêu)
    List<Video> findAll(int page, int pageSize);
    // Tìm kiếm video theo tiêu đề (cho Admin search)
    List<Video> findByTitle(String title);
    // Tăng view
    void incrementViews(String videoId);
}
