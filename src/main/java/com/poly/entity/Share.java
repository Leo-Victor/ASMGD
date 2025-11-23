package com.poly.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "Share")
public class Share {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String emails; // Emails người nhận

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ShareDate")
    private Date shareDate = new Date();

    // Quan hệ N-1 với User
    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;

    // Quan hệ N-1 với Video
    @ManyToOne
    @JoinColumn(name = "VideoId")
    private Video video;
}
