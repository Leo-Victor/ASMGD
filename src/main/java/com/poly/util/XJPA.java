package com.poly.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJPA {
    private static EntityManagerFactory factory;

    // Khởi tạo EntityManagerFactory chỉ một lần
    public static EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            // "SOF3012" là tên persistence-unit trong persistence.xml
            factory = Persistence.createEntityManagerFactory("SOF3012");
        }
        return factory.createEntityManager();
    }

    // Đóng EntityManagerFactory khi kết thúc ứng dụng
    public static void shutdown() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
