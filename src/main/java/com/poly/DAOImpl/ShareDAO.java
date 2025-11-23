package com.poly.DAOImpl;

import com.poly.DAO.IShareDAO;
import com.poly.entity.Share;
import com.poly.entity.User;
import com.poly.entity.Video;

import java.util.List;

public class ShareDAO extends AbstractDAO<Share> implements IShareDAO {
    public ShareDAO() {
        super(Share.class);
    }
    @Override
    public void recordShare(User user, Video video, String emails) {
        Share share = new Share();
        share.setUser(user);
        share.setVideo(video);
        share.setEmails(emails);
        // ShareDate tự động lấy ngày hiện tại (nếu trong entity đã set new Date())
        create(share);
    }

    @Override
    public List<Share> findByVideoId(String videoId) {
        // Dùng cho Báo cáo Admin
        String hql = "SELECT s FROM Share s WHERE s.video.id = ?1";
        return findMany(hql, -1, -1, videoId);
    }
}
