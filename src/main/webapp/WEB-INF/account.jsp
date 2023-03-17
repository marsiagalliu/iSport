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
<body>
<div class="navbar" style="background-color: #e3f2fd;">
    <a href="/dashboard">Home</a>
    <a href="/event/new">New</a>
    <a href="/search">Search</a>
    <a style="color: black" href="/users/${user.id}">Account</a>
</div>
<div class="account" style="margin: 20px">
    <h4>Name: <span>${user.firstName} ${user.lastName}</span></h4>
    <h4>Email: <span>${user.email}</span></h4>
    <h4>Password: <span>********</span></h4>
</div>

<a style="margin-left: 20px" class="btn btn-dark" href="/users/${user.id}/edit">Edit Profile</a>
<a style="margin-left: 20px" class="btn btn-dark" href="/logout">Log Out</a>
</body>
</html>