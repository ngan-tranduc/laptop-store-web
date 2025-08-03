package vn.nganj.laptopshop.service.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import vn.nganj.laptopshop.domain.dto.RegisterDTO;
import vn.nganj.laptopshop.service.UserService;

public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {

    private UserService userService;

    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;
        context.disableDefaultConstraintViolation();

        // Validate email
        if (user.getEmail() == null || !isValidEmail(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email không hợp lệ")
                    .addPropertyNode("email")
                    .addConstraintViolation();
            valid = false;
        } else {
            if (userService.checkEmailExists(user.getEmail())) {
                context.buildConstraintViolationWithTemplate("Email đã tồn tại")
                        .addPropertyNode("email")
                        .addConstraintViolation();
                valid = false;
            }
        }

        // Validate firstName
        if (user.getFirstName() == null || user.getFirstName().trim().length() < 1 || user.getFirstName().trim().length() > 50) {
            context.buildConstraintViolationWithTemplate("Tên không được để trống")
                    .addPropertyNode("firstName")
                    .addConstraintViolation();
            valid = false;
        }

        // Validate lastName
        if (user.getLastName() == null || user.getLastName().trim().length() < 1 || user.getLastName().trim().length() > 50) {
            context.buildConstraintViolationWithTemplate("Họ không được để trống")
                    .addPropertyNode("lastName")
                    .addConstraintViolation();
            valid = false;
        }

        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            context.buildConstraintViolationWithTemplate("Password không được để trống")
                    .addPropertyNode("password")
                    .addConstraintViolation();
            valid = false;
        }

        if (user.getConfirmPassword() == null || user.getConfirmPassword().trim().isEmpty()) {
            context.buildConstraintViolationWithTemplate("Confirm password không được để trống")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation();
            valid = false;
        }

        if (user.getPassword() != null && user.getConfirmPassword() != null &&
                !user.getPassword().equals(user.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Passwords không khớp")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation();
            valid = false;
        }

        return valid;
    }

    private boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
}
