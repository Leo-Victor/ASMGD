package com.poly.util;

import jakarta.servlet.http.HttpServletRequest;
import org.apache.commons.beanutils.BeanUtils;

public class BeanUtil {
    public static <T> T fillForm(HttpServletRequest req, Class<T> clazz) {
        try {
            T entity = clazz.getDeclaredConstructor().newInstance();
            // Map tất cả request parameter vào các trường có tên tương ứng trong entity
            BeanUtils.populate(entity, req.getParameterMap());
            return entity;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi fill data từ form vào entity", e);
        }
    }
}
