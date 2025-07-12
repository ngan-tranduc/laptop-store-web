package vn.nganj.laptopshop.controller.admin;

import jakarta.validation.Valid;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.service.RoleService;
import vn.nganj.laptopshop.service.UploadService;
import vn.nganj.laptopshop.service.UserService;

import java.util.List;

@Controller
public class UserController {
    private final UserService userService;
    private final RoleService roleService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, RoleService roleService, UploadService uploadService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.roleService = roleService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    //show
    @GetMapping("/admin/user")
    public String getUserPage(Model model){
        List<User> users = this.userService.getAllUser();
        model.addAttribute("users", users);
        return "admin/user/show";
    }

    //detail
    @RequestMapping(value = "/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable("id") Long id){
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    //create
    @GetMapping("/admin/user/create")
    public String getCreatePage(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("roles", roleService.findAll());
        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String createUserPage(Model model,
                                 @ModelAttribute("newUser") @Valid User user,
                                 BindingResult bindingResult,
                                 @RequestParam("avatarFile") MultipartFile file,
                                 RedirectAttributes redirectAttributes) {
        model.addAttribute("roles", roleService.findAll());
        // Kiểm tra validation errors
        if (bindingResult.hasErrors()) {
            return "admin/user/create";
        }
        if (!file.isEmpty() && file.getOriginalFilename() != null && !file.getOriginalFilename().trim().isEmpty()) {
            String avatar = this.uploadService.handleUploadFile(file, "avatar");
            user.setAvatar(avatar);
        }
        String hashedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(hashedPassword);
        this.userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    //update
    @PostMapping("/admin/user/edit")
    public String postUpdateUser(@ModelAttribute("currentUser") User user, @RequestParam("avatarFile") MultipartFile file) {
        User currentUser = this.userService.getUserById(user.getId());
        if(currentUser != null){
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());
            currentUser.setAddress(user.getAddress());
            currentUser.setRole(user.getRole());
            if (!file.isEmpty() && file.getOriginalFilename() != null && !file.getOriginalFilename().trim().isEmpty()) {
                String avatar = this.uploadService.handleUploadFile(file, "avatar");
                currentUser.setAvatar(avatar);
            }
            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }
    @RequestMapping(value = "/admin/user/edit/{id}")
    public String getUserEditPage(Model model, @PathVariable long id){
        User user = this.userService.getUserById(id);
        model.addAttribute("currentUser", user);
        model.addAttribute("roles", roleService.findAll());
        return "admin/user/edit";
    }

    //delete
    @PostMapping("admin/user/delete/{id}")
    public String deleteUser(@PathVariable long id) {
        userService.deleteById(id);
        return "redirect:/admin/user";
    }
}
