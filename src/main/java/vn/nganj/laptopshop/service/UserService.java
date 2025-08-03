package vn.nganj.laptopshop.service;

import org.springframework.stereotype.Service;
import vn.nganj.laptopshop.domain.Role;
import vn.nganj.laptopshop.domain.User;
import vn.nganj.laptopshop.domain.dto.RegisterDTO;
import vn.nganj.laptopshop.repository.UserRepository;

import java.util.List;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleService roleService;
    public UserService(UserRepository userRepository, RoleService roleService) {
        this.userRepository = userRepository;
        this.roleService = roleService;
    }

    public List<User> getAllUser() {
        return userRepository.findAllWithRoles();
    }

    public User handleSaveUser(User user){
        User userTemp = this.userRepository.save(user);
        return userTemp;
    }
    public User getUserById(Long id){
        return this.userRepository.findById(id).get();
    }

    public void deleteById(Long id) {
        userRepository.deleteById(id);
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFullName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        Role role = roleService.findByName("USER");
        if (role != null) {
            user.setRole(role);
        }
        return user;
    }

    public boolean checkEmailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    public User getUserByEmail(String email) {
        return userRepository.findOneByEmail(email);
    }
}
