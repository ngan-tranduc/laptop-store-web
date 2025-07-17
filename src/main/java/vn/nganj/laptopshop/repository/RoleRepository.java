package vn.nganj.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.nganj.laptopshop.domain.Role;

import java.util.Optional;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    // Define any additional methods if needed
    // For example, you might want to find roles by name or other attributes
    // List<Role> findByName(String name);
    Role findByName(String name);

}
