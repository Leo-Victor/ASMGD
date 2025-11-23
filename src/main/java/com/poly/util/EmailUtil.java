package com.poly.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {
    // Cấu hình Email Server của bạn
    private static final String HOST = "smtp.gmail.com";
    private static final String USER = "khoaledang301@gmail.com"; // <--- Thay email thật của bạn vào đây

    // 2. Đây phải là MẬT KHẨU ỨNG DỤNG (16 ký tự), KHÔNG PHẢI mật khẩu đăng nhập
    private static final String PASS = "awws eusc hgak ejyz"; // <--- Thay chuỗi 16 ký tự Google cấp vào đây

    public static void sendEmail(String toEmail, String subject, String content) throws MessagingException {
        // 1. Cấu hình Properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", "587");

        // 2. Tạo Session
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USER, PASS);
            }
        });

        // 3. Tạo Message
        Message message = new MimeMessage(session);
        // Thêm try-catch vì hàm này có thể ném lỗi Encoding
        try {
            // Tham số thứ 2 chính là Tên hiển thị bạn muốn
            message.setFrom(new InternetAddress(USER, "OE Entertainment"));
        } catch (java.io.UnsupportedEncodingException e) {
            message.setFrom(new InternetAddress(USER)); // Fallback nếu lỗi
        }
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setContent(content, "text/html; charset=utf-8");

        // 4. Gửi mail
        Transport.send(message);
    }
}
