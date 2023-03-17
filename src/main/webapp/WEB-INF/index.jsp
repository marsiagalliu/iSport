<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!-- c:out ; c:forEach ; c:if -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (like dates) -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Welcome to iSport</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<section class="vh-100" style="background-color: #9A616D;">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100 justify-content-center">
            <div class="col col-xl-10">
                <div class="card" style="border-radius: 1rem;">
                    <div class="row g-0 align-items-center justify-content-center">
                        <div class="col-md-6 col-lg-7 d-flex align-items-center text-center">
                            <div class="card-body p-4 p-lg-5 text-black">

                                <%--@elvariable id="newLogin" type="java"--%>
                                <form:form action="/login" method="post" modelAttribute="newLogin">
                                    <div class="d-flex align-items-center mb-3 pb-1">
                                        <i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
                                        <span class="h1 fw-bold mb-0">iSport</span>
                                    </div>

                                    <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Sign into your account</h5>

                                    <div class="form-outline mb-4">
                                        <input name="email" type="email" id="form2Example17" class="form-control form-control-lg" />
                                        <label name="email" class="form-label" for="form2Example17">Email address</label>
                                    </div>

                                    <div class="form-outline mb-4">
                                        <input name="password" type="password" id="form2Example27" class="form-control form-control-lg" />
                                        <label name="password" class="form-label" for="form2Example27">Password</label>
                                    </div>

                                    <div class="pt-1 mb-4">
                                        <button class="btn btn-dark btn-lg btn-block" type="submit">Login</button>
                                    </div>

                                    <p class="mb-5 pb-lg-2" style="color: #393f81;">Don't have an account? <a href="/register"
                                                                                                              style="color: #393f81;">Register here</a></p>
                                </form:form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>