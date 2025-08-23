package vn.nganj.laptopshop.config;

import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;
import vn.nganj.laptopshop.service.CustomUserDetailsService;
import vn.nganj.laptopshop.service.UserService;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    @Bean
    public UserDetailsService userDetailsService(UserService userService) {
        return new CustomUserDetailsService(userService);
    }

    @Bean
    public DaoAuthenticationProvider authProvider(
            PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {

        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        //authProvider.setHideUserNotFoundExceptions(false);

        return authProvider;
    }

    @Bean
    public AuthenticationSuccessHandler customSuccessHandler(){
        return new CustomSuccessHandler();
    }

    @Bean
    public SpringSessionRememberMeServices rememberMeServices() {
        SpringSessionRememberMeServices rememberMeServices =
                new SpringSessionRememberMeServices();

        rememberMeServices.setAlwaysRemember(true);
        return rememberMeServices;
    }


    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        .dispatcherTypeMatchers(DispatcherType.FORWARD,
                                DispatcherType.INCLUDE).permitAll()

                        .requestMatchers("/", "/product/**", "/login", "/register", "/client/**", "/css/**", "/js/**", "/images/**").permitAll()

                        // Cart endpoints cần authentication
                        .requestMatchers(HttpMethod.GET, "/cart").hasAnyRole("USER", "ADMIN")
                        .requestMatchers(HttpMethod.POST, "/cart/**").hasAnyRole("USER", "ADMIN")

                        .requestMatchers("/admin/**", "/assets/**").hasRole("ADMIN")

                        .anyRequest().authenticated()

                )
                .sessionManagement((sessionManagement) -> sessionManagement
                        .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
                        .invalidSessionUrl("/logout?expired")
                        .maximumSessions(1)
                        .maxSessionsPreventsLogin(false))

                .logout(logout->logout.deleteCookies("JSESSIONID").invalidateHttpSession(true))

                .rememberMe((rememberMe) -> rememberMe
                        .rememberMeServices(rememberMeServices())
                )

                .formLogin(formLogin -> formLogin
                        .loginPage("/login")
                        .successHandler(customSuccessHandler())
                        .failureUrl("/login?error")
                        .permitAll())
                .exceptionHandling(ex -> ex.accessDeniedPage("/access_denied"))

                .csrf(csrf -> csrf
                                // Tắt CSRF cho cart và admin endpoints
                                .ignoringRequestMatchers("/cart/**", "/admin/order/*/status", "/admin/order/*/update-status")

                        // Hoặc có thể tắt hoàn toàn cho toàn bộ admin (ít an toàn hơn):
                        // .ignoringRequestMatchers("/cart/**", "/admin/**")
                );

        return http.build();
    }
}