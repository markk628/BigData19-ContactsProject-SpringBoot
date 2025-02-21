package com.markk628.contacts_project_v2.service;

import com.markk628.contacts_project_v2.repository.AuthenticationRepository;
import com.markk628.contacts_project_v2.model.appuser.AppUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class AuthenticationService implements UserDetailsService {
    @Autowired
    private AuthenticationRepository repository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        AppUserEntity user = this.repository.findByUsername(username);
        if (user != null) {
            return User.withUsername(user.getUsername())
                       .password(user.getPassword())
                       .build();
        }
        return null;
    }

    public UserDetails getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken)) {
            return (UserDetails) authentication.getPrincipal();
        }
        return null;
    }

    public String getCurrentUsername() {
        UserDetails userDetails = getCurrentUser();
        return (userDetails != null) ? userDetails.getUsername() : null;
    }
}
