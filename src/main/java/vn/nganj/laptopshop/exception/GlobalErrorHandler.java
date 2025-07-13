package vn.nganj.laptopshop.exception;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GlobalErrorHandler {

    @ExceptionHandler(NoHandlerFoundException.class)
    public String handleNotFound(NoHandlerFoundException ex, Model model, HttpServletRequest request) {
        String requestPath = request.getRequestURI();

        if (requestPath.startsWith("/admin")) {
            model.addAttribute("requestPath", requestPath);
            model.addAttribute("errorMessage", "Trang admin không tồn tại");
            return "admin/error/404";
        }

        return "error/404";
    }
}
