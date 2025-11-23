package com.poly.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "Users")
public class User {
    @Id
    @Column(name = "Id")
    private String id;

    private String password;
    private String email;
    private String fullname;
    private Boolean admin = false; // Mặc định là User

    // Quan hệ 1-N với Favorite
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Favorite> favorites;

    // Quan hệ 1-N với Share
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Share> shares;

}
