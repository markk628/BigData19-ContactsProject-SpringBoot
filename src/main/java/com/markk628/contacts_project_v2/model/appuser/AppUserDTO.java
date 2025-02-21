package com.markk628.contacts_project_v2.model.appuser;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class AppUserDTO {
    @NotEmpty
    private String username;

    @NotEmpty
    @Email
    private String email;

    @Size(min = 6, message = "Password must be at least 6 characters long")
    private String password;

    private String confirmPassword;
}
