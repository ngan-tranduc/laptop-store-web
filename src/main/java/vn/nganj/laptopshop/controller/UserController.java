package vn.nganj.laptopshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.repository.UserRepository;
import vn.nganj.laptopshop.service.UserService;

import java.util.List;


@Controller
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    //main
    @RequestMapping("/")
    public String handleHello(Model model){
        List<User> arrUsers = this.userService.getAllUser();
        System.out.printf(arrUsers.toString());
        model.addAttribute("nganj", "hi");
        return "hello";
    }

    //table
    @RequestMapping(value = "/admin/user")
    public String getUserPage(Model model){
        List<User> users = this.userService.getAllUser();
        model.addAttribute("users", users);
        return "admin/user/table-user";
    }

    //detail
    @RequestMapping(value = "/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable("id") Long id){
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/show";
    }

    //create
    @RequestMapping(value = "/admin/user/create")
    public String getCreatePage(Model model){
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }
    @RequestMapping(value = "/admin/user/create", method = {RequestMethod.POST})
    public String createUserPage(Model model, @ModelAttribute("newUser") User user){
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
