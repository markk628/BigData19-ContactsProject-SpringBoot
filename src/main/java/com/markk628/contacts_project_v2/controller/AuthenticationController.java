package com.markk628.contacts_project_v2.controller;

import com.markk628.contacts_project_v2.model.appuser.AppUserEntity;
import com.markk628.contacts_project_v2.model.appuser.AppUserDTO;
import com.markk628.contacts_project_v2.repository.AuthenticationRepository;
import com.markk628.contacts_project_v2.security.SecurityConfig;
import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AuthenticationController {
    @Autowired
    private AuthenticationRepository repository;

    @Autowired
    private SecurityConfig securityConfig;

    @GetMapping("/login")
    public String loginPage(Model model) {
        AppUserDTO appUserDTO = new AppUserDTO();
        model.addAttribute(appUserDTO);
        return "authentication/login";
    }

    @GetMapping("/signup")
    public String signupPage(Model model) {
        AppUserDTO appUserDTO = new AppUserDTO();
        model.addAttribute(appUserDTO);
        return "signup";
    }

    @PostMapping("/signup")
    public String signup(Model model,
                         @Valid @ModelAttribute AppUserDTO appUserDTO,
                         BindingResult result) {
        if (!appUserDTO.getPassword().equals(appUserDTO.getConfirmPassword())) {
            result.addError(new FieldError("appUserDTO", "confirmPassword", "password and confirmPassword mismatch"));
        }
        if (this.repository.findByUsername(appUserDTO.getUsername()) != null) {
            result.addError(new FieldError("appUserDTO", "username", "username is already in use"));
        }
        if (this.repository.findByEmail(appUserDTO.getEmail()) != null) {
            result.addError(new FieldError("appUserDTO", "email", "email is already in use"));
        }
        if (result.hasErrors()) {
            return "signup";
        }

        repository.save(new AppUserEntity(appUserDTO.getUsername(), appUserDTO.getEmail(), this.securityConfig.passwordEncoder().encode(appUserDTO.getPassword())));
        return "redirect:/login";
    }
}
