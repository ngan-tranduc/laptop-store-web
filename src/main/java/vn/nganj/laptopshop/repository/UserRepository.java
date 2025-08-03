package vn.nganj.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.nganj.laptopshop.domain.User;

import java.util.List;

//crud: create, read, update, delete
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User user);
    List<User> findByEmail(String email);

    List<User> findAll();
    @Query("SELECT u FROM User u LEFT JOIN FETCH u.role WHERE u.email = :email")
    User findOneByEmail(@Param("email") String email);
    boolean existsByEmail(String email);
    @Query("SELECT u FROM User u LEFT JOIN FETCH u.role")
    List<User> findAllWithRoles();
}
