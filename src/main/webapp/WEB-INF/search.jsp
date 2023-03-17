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
    <a href="/event/new">New</a>
    <a style="color: black" href="/search">Search</a>
    <a href="/users/${user.id}">Account</a>
</div>
<%--@elvariable id="search" type="java"--%>
<form action="/search" method="post">
<div class="input-group md-form form-sm form-2 pl-0" style="width: 50%; margin-left: 400px; margin-top: 50px">
    <input class="form-control my-0 py-1 lime-border" type="text" placeholder="Search" aria-label="Search" name="name">
    <div class="input-group-append">
        <button type="submit" class="input-group-text lime lighten-2" id="basic-text1"><i class="fas fa-search text-grey" aria-hidden="true">Search</i></button>
    </div>
</div>
</form>
    <table class="table table-bordered table-striped mb-0">
        <thead>
        <tr>
            <th scope="col">Event Name</th>
            <th scope="col">Location Name</th>
            <th scope="col">Attendees</th>
            <th scope="col">Date</th>
            <th scope="col">Creator</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${search}" var="search">
            <tr>
                <td> <c:out value="${search.eventName}"></c:out> </td>
                <td> <c:out value="${search.eventLocation}"></c:out> </td>
                <td> <c:out value="${search.attendees.size()} / ${search.maxAttendees}"></c:out> </td>
                <td><fmt:formatDate value="${search.date}" type="date" dateStyle="long"/></td>
                <td><a href="/users/${search.creator.id}"> <c:out value="${search.creator.firstName} ${search.creator.lastName}"></c:out> </a></td>
                <form action="/joinEvent/${search.id}" method="post">
                <td>
                    <c:if test="${search.attendees.size() < search.maxAttendees && search.attendees.indexOf(user) == -1}"><button type="submit" class="btn btn-link">Join</button> </c:if>
                    <c:if test="${search.attendees.size() >= search.maxAttendees}"><p >Full</p> </c:if>
                    <c:if test="${search.attendees.indexOf(user) != -1}"><p >Joined</p> </c:if>
                </td>
                </form>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</body>
</html>