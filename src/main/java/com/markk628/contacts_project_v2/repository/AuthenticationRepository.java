package com.markk628.contacts_project_v2.repository;

import com.markk628.contacts_project_v2.model.appuser.AppUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthenticationRepository extends JpaRepository<AppUserEntity, Integer> {
    AppUserEntity findByEmail(String email);
    AppUserEntity findByUsername(String username);
}
