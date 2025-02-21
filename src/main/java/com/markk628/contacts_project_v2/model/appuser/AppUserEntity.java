package com.markk628.contacts_project_v2.model.appuser;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "app_user")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class AppUserEntity {
    @Id
    @Column(name = "app_user_username")
    private String username;

    @Column(name = "app_user_email")
    private String email;

    @Column(name = "app_user_password")
    private String password;
}
