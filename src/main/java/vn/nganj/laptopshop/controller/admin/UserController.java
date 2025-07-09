package vn.nganj.laptopshop.controller.admin;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
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

    @RequestMapping("/")
    public String handleHello(Model model){
        List<User> arrUsers = this.userService.getAllUser();
//        System.out.printf(arrUsers.toString());
        model.addAttribute("nganj", "hi");
        return "hello";
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
    @RequestMapping(value = "/admin/user/create")
    public String getCreatePage(Model model){
        model.addAttribute("newUser", new User());
        model.addAttribute("roles", roleService.findAll());
        return "admin/user/create";
    }
    @RequestMapping(value = "/admin/user/create", method = {RequestMethod.POST})
    public String createUserPage(Model model, @ModelAttribute("newUser") User user, @RequestParam("avatarFile") MultipartFile file){
        String avatar = this.uploadService.handleUploadFile(file, "avatar");
        String hashedPassword = passwordEncoder.encode(user.getPassword());
        user.setAvatar(avatar);
        user.setPassword(hashedPassword);
        this.userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    //update
    @PostMapping("/admin/user/edit")
    public String postUpdateUser(@ModelAttribute("currentUser") User user) {
        User currentUser = this.userService.getUserById(user.getId());
        if(currentUser != null){
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());
            currentUser.setAddress(user.getAddress());
            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }
    @RequestMapping(value = "/admin/user/edit/{id}")
    public String getUserEditPage(Model model, @PathVariable long id){
        User user = this.userService.getUserById(id);
        model.addAttribute("currentUser", user);
        return "admin/user/edit";
    }

    //delete
    @PostMapping("admin/user/delete/{id}")
    public String deleteUser(@PathVariable long id) {
        userService.deleteById(id);
        return "redirect:/admin/user";
    }
}
