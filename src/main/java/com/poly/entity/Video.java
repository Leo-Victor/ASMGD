package com.poly.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "Video")
public class Video {
    @Id
    @Column(name = "Id")
    private String id; // Youtube ID

    private String titile;
    private String poster;
    private Integer views = 0;
    private String description;
    private Boolean active = true; // Mặc định là Active

    // Quan hệ 1-N với Favorite
    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL)
    private List<Favorite> favorites;

    // Quan hệ 1-N với Share
    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL)
    private List<Share> shares;
}
