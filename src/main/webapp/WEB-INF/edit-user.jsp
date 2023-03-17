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
    <meta charset="UTF-8">
    <title>A Web Page</title>
</head>
<body>
<div class="navbar" style="background-color: #e3f2fd;">
    <a href="/dashboard">Home</a>
    <a style="color: black" href="/event/new">New</a>
    <a href="/search">Search</a>
    <a href="/users/${user.id}">Account</a>
</div>
<%--@elvariable id="user" type="java"--%>
<form:form style="font-weight: bolder; margin-top: 20px" class="container" action="/users/${user.id}/edit" method="post" modelAttribute="user">
    <input type="hidden" name="_method" value="put">
    <div  class="form-group">
        <form:label path="firstName">First Name</form:label>
        <form:errors path="firstName" class="text-danger"/>
        <form:input class="form-control" path="firstName"/>
    </div>
    <div class="form-group">
        <form:label path="lastName">Last Name</form:label>
        <form:errors path="lastName" class="text-danger"/>
        <form:input class="form-control" path="lastName"/>
    </div>
    <div class="form-group">
        <form:label path="email">Email</form:label>
        <form:errors path="email" class="text-danger"/>
        <form:input class="form-control" path="email"/>
    </div>
    <div class="form-group">
        <form:label path="password">New Password</form:label>
        <form:errors path="password" class="text-danger"/>
        <form:input type="password" minlength="8" class="form-control" path="password"/>
    </div>
    <button type="submit" class="btn btn-dark">Submit</button>
</form:form>
</body>
</html>