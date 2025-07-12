package vn.nganj.laptopshop.service;

import org.springframework.stereotype.Service;
import vn.nganj.laptopshop.repository.RoleRepository;

@Service
public class RoleService {
    private final RoleRepository roleRepository;
    public RoleService(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }
    public Object findAll() {
        // Assuming roleRepository has a method to find all roles
        return roleRepository.findAll();
    }
}
