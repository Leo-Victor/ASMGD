package com.poly.DAO;

import com.poly.entity.Share;
import com.poly.entity.User;
import com.poly.entity.Video;

import java.util.List;

public interface IShareDAO extends IGenericDAO<Share>{
    void recordShare(User user, Video video, String emails);
    // BÁO CÁO: Lấy danh sách lượt share của một video
    List<Share> findByVideoId(String videoId);
}
