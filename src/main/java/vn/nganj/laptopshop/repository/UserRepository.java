package vn.nganj.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.nganj.laptopshop.domain.User;

import java.util.List;

//crud: create, read, update, delete
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User user);
    List<User> findByEmail(String email);
    List<User> findAll();

    boolean existsByEmail(String email);
}
