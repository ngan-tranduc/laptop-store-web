<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>

    <!-- CSS -->
    <link rel="stylesheet" href="/client/css/auth.css">

    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>


    <style>

        .form.signup {
            display: block !important;
            opacity: 1 !important;
            pointer-events: auto !important;
        }

        .error-message {
            color: #ff6b6b;
            font-size: 13px;
            margin-top: 3px;
        }

        .success-message {
            color: #51cf66;
            font-size: 13px;
            margin-top: 3px;
        }

        /* Validation styling */
        .input.is-invalid {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }

        .input.is-invalid:focus {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }

        .invalid-feedback {
            display: block;
            color: #dc3545;
            font-size: 13px;
            margin-top: 3px;
            line-height: 1.2;
        }

        /* Name fields styling */
        .name-row {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }

        .name-field {
            flex: 1;
        }

        .name-field .input {
            width: 100%;
        }
    </style>

</head>
<body>
<section class="container forms">
    <div class="form signup" style="display: block; opacity: 1; pointer-events: auto;">
        <div class="form-content">
            <header>Signup</header>

            <!-- Hiển thị thông báo thành công -->
            <c:if test="${not empty successMessage}">
                <div class="success-message">${successMessage}</div>
            </c:if>

            <!-- Hiển thị thông báo lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <form:form action="/register" method="post" modelAttribute="registerUser">
                <!-- Name fields row -->
                <div class="name-row">
                    <div class="name-field field input-field">
                        <c:set var="errorFirstName">
                            <form:errors path="firstName" cssClass="invalid-feedback"/>
                        </c:set>
                        <form:input type="text"
                                    placeholder="Họ"
                                    class="input ${not empty errorFirstName ? 'is-invalid' : ''}"
                                    path="firstName"
                        />
                            ${errorFirstName}
                    </div>

                    <div class="field input-field name-field">
                        <c:set var="errorLastName">
                            <form:errors path="lastName" cssClass="invalid-feedback"/>
                        </c:set>
                        <form:input type="text"
                                    placeholder="Tên"
                                    class="input ${not empty errorLastName ? 'is-invalid' : ''}"
                                    path="lastName"
                        />
                            ${errorLastName}
                    </div>
                </div>

                <div class="field input-field">
                    <c:set var="errorEmail">
                        <form:errors path="email" cssClass="invalid-feedback"/>
                    </c:set>
                    <form:input type="email"
                                placeholder="Email"
                                class="input ${not empty errorEmail ? 'is-invalid' : ''}"
                                path="email"
                    />
                        ${errorEmail}
                </div>

                <div class="field input-field">
                    <c:set var="errorPassword">
                        <form:errors path="password" cssClass="invalid-feedback"/>
                    </c:set>
                    <form:input type="password"
                                placeholder="Create password"
                                class="password input ${not empty errorPassword ? 'is-invalid' : ''}"
                                path="password"
                    />
                        ${errorPassword}
                </div>

                <div class="field input-field">
                    <c:set var="errorConfirmPassword">
                        <form:errors path="confirmPassword" cssClass="invalid-feedback"/>
                    </c:set>
                    <form:input type="password"
                                placeholder="Confirm password"
                                class="password input ${not empty errorConfirmPassword ? 'is-invalid' : ''}"
                                path="confirmPassword"
                    />
                    <i class='bx bx-hide eye-icon'></i>
                        ${errorConfirmPassword}
                    <c:if test="${not empty passwordError}">
                        <div class="invalid-feedback">${passwordError}</div>
                    </c:if>
                </div>

                <div class="field button-field">
                    <button type="submit">Signup</button>
                </div>
            </form:form>

            <div class="form-link">
                <span>Already have an account? <a href="/login" class="link login-link">Login</a></span>
            </div>
        </div>

        <div class="line"></div>

        <div class="media-options">
            <a href="#" class="field facebook">
                <i class='bx bxl-facebook facebook-icon'></i>
                <span>Login with Facebook</span>
            </a>
        </div>

        <div class="media-options">
            <a href="#" class="field google">
                <img src="/client/images/google.png" alt="" class="google-img">
                <span>Login with Google</span>
            </a>
        </div>

    </div>
</section>

<!-- JavaScript -->
<script src="/client/js/auth.js"></script>
</body>
</html>